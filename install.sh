#!/bin/sh
# POSIX sh: safe to run as curl -fsSL https://packages.tastedev.net/install.sh | sh
# All script bytes are parsed before main starts, so children cannot consume the pipe.
set -eu

fail() { printf 'TASTEDEV: %s\n' "$*" >&2; exit 1; }
say() { printf '%s\n' "$*"; }
usage() {
  cat <<'HELP'
TASTEDEV macOS / Linux installer
  curl -fsSL https://packages.tastedev.net/install.sh | sh
  curl -fsSL https://packages.tastedev.net/install.sh | sh -s -- files ftp --yes
Options: --list  --all  --update  --yes  --dry-run  --no-bootstrap  --help
macOS: Apple Silicon, Homebrew Cask. Linux: x86_64, APT / DNF / YUM / Zypper.
Run again to install missing products and update older installed versions.
--update selects installed products only (all supported products if none specified).
HELP
}
mac_products='cad code files ftp remote ssh zip'
linux_products='cad code etl files ftp geo mail remote rust ssh studio zip'
all_products='cad code etl fast files ftp geo mail office remote rust ssh studio zip'
contains() { case " $1 " in *" $2 "*) return 0 ;; *) return 1 ;; esac; }
normalize() {
  value=$(printf '%s' "$1" | tr '[:upper:]' '[:lower:]')
  case "$value" in tastedev-*) value=${value#tastedev-} ;; taste*) value=${value#taste} ;; esac
  contains "$all_products" "$value" || fail "Unknown product: $1 (use --list)"
  printf '%s' "$value"
}
as_root() {
  if [ "$(id -u)" = 0 ]; then "$@"; else sudo "$@"; fi
}
download() { curl --fail --silent --show-error --location --proto '=https' --proto-redir '=https' --tlsv1.2 --output "$2" "$1"; }
confirm() {
  [ "$yes" = true ] && return
  [ -r /dev/tty ] || fail 'No terminal. Supply products and --yes for non-interactive installation.'
  printf 'Install/update %s on %s? [y/N] ' "$products" "$os" >/dev/tty
  IFS= read -r answer </dev/tty || fail 'Installation cancelled.'
  case "$answer" in y|Y|yes|YES) ;; *) fail 'Installation cancelled.' ;; esac
}
new_work() {
  cache=${XDG_CACHE_HOME:-${HOME:?HOME is required}/.cache}/tastedev/installer
  [ ! -L "$cache" ] || fail 'Linked installer cache is unsupported.'
  mkdir -p "$cache"
  work=$(mktemp -d "$cache/work.XXXXXX")
  # mktemp created this directory; only this invocation owns and removes it.
  trap 'test -z "${work:-}" || rm -rf -- "$work"' 0
  trap 'exit 130' INT
  trap 'exit 143' TERM
}
find_brew() {
  brew=$(command -v brew || true)
  if [ -z "$brew" ]; then
    for candidate in /opt/homebrew/bin/brew /usr/local/bin/brew; do
      if [ -x "$candidate" ]; then brew=$candidate; break; fi
    done
  fi
}
assert_idle() {
  command -v pgrep >/dev/null 2>&1 || fail 'pgrep is required to protect running applications/services.'
  # Include role executables and child scripts below a product installation path.
  # A failed process query is not evidence that the application is idle.
  if pgrep -f "(^|/)taste(dev-)?${1}(-[A-Za-z0-9_-]+)?([/[:space:]]|$)" >/dev/null; then
    fail "$1 is running. Save work and close its instances/services, then retry. No process was terminated."
  else
    status=$?
    [ "$status" = 1 ] || fail "Cannot determine whether $1 is running (pgrep $status)."
  fi
}
install_macos() {
  [ "$(id -u)" != 0 ] || fail 'Run the macOS installer as your normal user, without sudo.'
  find_brew
  if [ -z "$brew" ]; then
    if [ "$update_only" = true ]; then say 'No Homebrew-managed TASTEDEV products are installed.'; return; fi
    [ "$bootstrap" = true ] || fail 'Homebrew is required. Install it from https://brew.sh first.'
    new_work
    download 'https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh' "$work/homebrew-install.sh"
    if [ "$yes" = true ]; then
      NONINTERACTIVE=1 /bin/bash "$work/homebrew-install.sh" </dev/null
    else
      /bin/bash "$work/homebrew-install.sh" </dev/tty
    fi
    find_brew
    [ -n "$brew" ] || fail 'Homebrew installation did not create a brew executable.'
  fi
  "$brew" tap whitecalvin/tastedev </dev/null
  "$brew" update --quiet </dev/null
  actions=
  # Check the entire selection before starting an application installation.
  for product in $products; do
    token="whitecalvin/tastedev/tastedev-$product"
    action=install
    if "$brew" list --cask --versions "tastedev-$product" >/dev/null 2>&1; then
      outdated=$("$brew" outdated --cask --greedy --quiet "$token" </dev/null) || fail "Cannot check updates for $product."
      if [ -z "$outdated" ]; then say "$product is already up to date; keeping the current app."; continue; fi
      action=upgrade
    elif [ "$update_only" = true ]; then
      say "$product is not installed; skipping."
      continue
    fi
    "$brew" info --cask "whitecalvin/tastedev/tastedev-$product" >/dev/null </dev/null ||
      fail "No published Homebrew Cask for $product. No selected apps were installed."
    assert_idle "$product"
    actions="$actions $action:$product"
  done
  for entry in $actions; do
    action=${entry%%:*}; product=${entry#*:}
    token="whitecalvin/tastedev/tastedev-$product"
    assert_idle "$product"
    "$brew" "$action" --cask "$token" </dev/null
  done
  say 'macOS installation finished. Apps are in Applications; macOS may request Open Anyway in Privacy & Security.'
}
verify_key() {
  mkdir -m 700 "$work/gnupg"
  fingerprint=$(gpg --batch --homedir "$work/gnupg" --with-colons --show-keys "$work/key" |
    awk -F: '$1=="pub" {primary=1;next} primary && $1=="fpr" {print $10;primary=0}')
  [ "$fingerprint" = "$1" ] || fail 'Repository signing key fingerprint mismatch; system configuration was not changed.'
}
install_linux() {
  command -v curl >/dev/null 2>&1 || fail 'curl is required.'
  command -v gpg >/dev/null 2>&1 || fail 'Install gnupg with your distribution package manager, then retry.'
  if [ "$(id -u)" != 0 ]; then
    command -v sudo >/dev/null 2>&1 || fail 'sudo is required for system package installation.'
  fi
  new_work
  # Detect the distribution, never choose a foreign package manager from PATH.
  ID= ID_LIKE=
  [ -r /etc/os-release ] || fail 'Cannot identify Linux distribution.'
  . /etc/os-release
  case " $ID $ID_LIKE " in
    *' debian '*|*' ubuntu '*) manager=apt ;;
    *' fedora '*|*' rhel '*|*' centos '*|*' rocky '*|*' almalinux '*)
      if command -v dnf >/dev/null 2>&1; then manager=dnf; else manager=yum; fi ;;
    *' opensuse '*|*' opensuse-leap '*|*' opensuse-tumbleweed '*|*' sles '*|*' suse '*) manager=zypper ;;
    *) fail "Unsupported distribution: $ID. APT or RPM repository support is required." ;;
  esac
  packages=
  for product in $products; do
    if [ "$update_only" = true ]; then
      if [ "$manager" = apt ]; then
        command -v dpkg-query >/dev/null 2>&1 || fail 'dpkg-query is unavailable.'
        installed=$(dpkg-query -W -f='${Status}' "tastedev-$product" 2>/dev/null) || installed=
        [ "$installed" = 'install ok installed' ] || { say "$product is not installed; skipping."; continue; }
      else
        rpm -q --quiet "tastedev-$product" || { say "$product is not installed; skipping."; continue; }
      fi
    fi
    assert_idle "$product"
    packages="$packages tastedev-$product"
  done
  [ -n "$packages" ] || { say 'No installed TASTEDEV products selected for update.'; return; }
  if [ "$manager" = apt ]; then
    command -v apt-get >/dev/null 2>&1 || fail 'apt-get is unavailable.'
    [ ! -L /usr/share/keyrings/tastedev-archive-keyring.gpg ] || fail 'Linked TASTEDEV keyring path.'
    [ ! -L /etc/apt/sources.list.d/tastedev.list ] || fail 'Linked TASTEDEV source path.'
    download 'https://packages.tastedev.net/tastedev-archive-keyring.gpg' "$work/key"
    verify_key '9518CCB64C93F5A28C5FE160A96150ECE089E27B'
    printf '%s\n' 'deb [arch=amd64 signed-by=/usr/share/keyrings/tastedev-archive-keyring.gpg] https://packages.tastedev.net stable main' >"$work/tastedev.list"
    as_root install -d -m 755 /usr/share/keyrings /etc/apt/sources.list.d
    as_root install -m 644 "$work/key" /usr/share/keyrings/tastedev-archive-keyring.gpg
    as_root install -m 644 "$work/tastedev.list" /etc/apt/sources.list.d/tastedev.list
    as_root apt-get update </dev/null
    upgrade_option=
    [ "$update_only" = false ] || upgrade_option=--only-upgrade
    for package in $packages; do assert_idle "${package#tastedev-}"; done
    if [ "$yes" = true ]; then as_root apt-get install $upgrade_option -y $packages </dev/null; else as_root apt-get install $upgrade_option $packages </dev/tty; fi
  else
    command -v "$manager" >/dev/null 2>&1 || fail "$manager is unavailable."
    command -v rpm >/dev/null 2>&1 || fail 'rpm is unavailable.'
    [ ! -L /etc/yum.repos.d/tastedev.repo ] || fail 'Linked TASTEDEV repository path.'
    download 'https://packages.tastedev.net/rpm/RPM-GPG-KEY-TASTEDEV' "$work/key"
    verify_key '8D37A3719E945B7CAE61A2CD0C29B1A9E548A831'
    cat >"$work/tastedev.repo" <<'REPO'
[tastedev]
name=TASTEDEV
baseurl=https://packages.tastedev.net/rpm/stable/$basearch/
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.tastedev.net/rpm/RPM-GPG-KEY-TASTEDEV
REPO
    as_root rpm --import "$work/key"
    if [ "$manager" = zypper ]; then
      [ ! -L /etc/zypp/repos.d/tastedev.repo ] || fail 'Linked TASTEDEV Zypper repository path.'
      as_root install -d -m 755 /etc/zypp/repos.d
      as_root install -m 644 "$work/tastedev.repo" /etc/zypp/repos.d/tastedev.repo
      action=install; [ "$update_only" = false ] || action=update
      as_root zypper --non-interactive refresh tastedev </dev/null
      for package in $packages; do assert_idle "${package#tastedev-}"; done
      if [ "$yes" = true ]; then as_root zypper --non-interactive "$action" $packages </dev/null; else as_root zypper "$action" $packages </dev/tty; fi
    else
      as_root install -d -m 755 /etc/yum.repos.d
      as_root install -m 644 "$work/tastedev.repo" /etc/yum.repos.d/tastedev.repo
      action=install; refresh=--refresh
      if [ "$manager" = yum ]; then refresh=--setopt=metadata_expire=0; fi
      if [ "$update_only" = true ]; then
        if [ "$manager" = yum ]; then action=update; else action=upgrade; fi
      fi
      for package in $packages; do assert_idle "${package#tastedev-}"; done
      if [ "$yes" = true ]; then as_root "$manager" "$refresh" "$action" -y $packages </dev/null; else as_root "$manager" "$refresh" "$action" $packages </dev/tty; fi
    fi
  fi
  say 'Linux package installation finished.'
}
main() {
  products= yes=false dry_run=false bootstrap=true select_all=false update_only=false
  while [ "$#" -gt 0 ]; do
    case "$1" in
      --help|-h) usage; return ;;
      --list) say "macOS arm64: $mac_products"; say "Linux x86_64: $linux_products"; say 'Not published through these repositories: fast office'; return ;;
      --yes|-y) yes=true ;;
      --dry-run) dry_run=true ;;
      --all) select_all=true ;;
      --update) update_only=true ;;
      --no-bootstrap) bootstrap=false ;;
      -*) fail "Unknown option: $1" ;;
      *) product=$(normalize "$1"); contains "$products" "$product" || products="$products $product" ;;
    esac
    shift
  done
  os=$(uname -s); arch=$(uname -m)
  case "$os:$arch" in
    Darwin:arm64) available=$mac_products ;;
    Linux:x86_64) available=$linux_products ;;
    Darwin:*) fail 'Published macOS packages require Apple Silicon (arm64). Use a native terminal outside Rosetta.' ;;
    Linux:*) fail 'Published Linux repository packages currently require x86_64.' ;;
    *) fail 'This installer supports macOS and Linux.' ;;
  esac
  if [ "$select_all" = true ]; then products=$available; fi
  if [ "$update_only" = true ] && [ -z "$products" ]; then products=$available; fi
  if [ -z "$products" ]; then
    [ "$yes" = false ] || fail 'Specify products or --all with --yes.'
    [ -r /dev/tty ] || fail 'Specify products and --yes when no terminal is attached.'
    printf 'Products: %s\nChoose products (space separated): ' "$available" >/dev/tty
    IFS= read -r choices </dev/tty || fail 'No selection.'
    for choice in $choices; do product=$(normalize "$choice"); contains "$products" "$product" || products="$products $product"; done
  fi
  [ -n "$products" ] || fail 'No products selected.'
  for product in $products; do contains "$available" "$product" || fail "No $os repository package for $product."; done
  say "TASTEDEV: $os $arch; products:$products"
  if [ "$dry_run" = true ]; then say 'Dry run: no downloads, repository changes, or installations.'; return; fi
  confirm
  case "$os" in Darwin) install_macos ;; Linux) install_linux ;; esac
}
main "$@"
