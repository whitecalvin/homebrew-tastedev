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
Options: --list  --all  --update  --user  --yes  --dry-run  --no-bootstrap  --help
macOS: Apple Silicon, Homebrew Cask. Linux: x86_64, APT / DNF / YUM / Zypper.
Run again to install missing products and update older installed versions.
--update selects installed products only (all supported products if none specified).
--user: supported products; macOS ~/Applications, Linux ~/.local/opt, without system package managers.
HELP
}
mac_products='cad code etl files ftp geo mail remote ssh studio zip'
linux_products='cad code etl files ftp geo mail remote ssh studio zip'
all_products='cad code etl fast files ftp geo mail office remote ssh studio zip'
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
assert_brew_writable() {
  # Metadata queries must not start Homebrew's automatic update before preflight.
  prefix=$(HOMEBREW_NO_AUTO_UPDATE=1 "$brew" --prefix </dev/null) || fail 'Cannot determine the Homebrew prefix.'
  repository=$(HOMEBREW_NO_AUTO_UPDATE=1 "$brew" --repository </dev/null) || fail 'Cannot determine the Homebrew repository.'
  cache_path=$(HOMEBREW_NO_AUTO_UPDATE=1 "$brew" --cache </dev/null) || fail 'Cannot determine the Homebrew cache.'
  for required in "$prefix" "$repository" "$repository/Library" "$repository/Library/Taps" \
    "$repository/Library/Taps/whitecalvin" "$repository/Library/Taps/whitecalvin/homebrew-tastedev" \
    "$prefix/Caskroom" "$prefix/var/homebrew/locks" "$cache_path"; do
    case "$required" in /*) ;; *) fail 'Homebrew returned a non-absolute directory.' ;; esac
    probe=$required
    while [ ! -e "$probe" ]; do
      [ ! -L "$probe" ] || fail "Broken Homebrew directory link: $probe"
      probe=${probe%/*}; [ -n "$probe" ] || probe=/
    done
    if [ ! -d "$probe" ] || [ ! -w "$probe" ] || [ ! -x "$probe" ]; then
      printf 'TASTEDEV: Homebrew directory is not writable/searchable by %s: %s\n' "$(id -un)" "$probe" >&2
      ls -ld "$probe" >&2 || :
      printf '%s\n' 'No tap, update, or app installation was started.' \
        'Run brew doctor and inspect this directory owner and ACLs (ls -lde).' \
        'Use the Homebrew owner account, or have an administrator repair only the incorrect paths.' \
        'Do not run this installer with sudo or recursively chown the entire Homebrew prefix.' >&2
      exit 1
    fi
  done
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
assert_user_path() {
  probe=$1
  while [ "$probe" != / ]; do
    [ ! -L "$probe" ] || fail "Linked personal installation path: $probe"
    probe=${probe%/*}; [ -n "$probe" ] || probe=/
  done
}
user_install_cleanup() {
  if [ "${user_mounted:-false}" = true ]; then
    if ! hdiutil detach "$work/mount" >/dev/null 2>&1; then
      printf 'TASTEDEV: disk image is still mounted at %s; staging preserved.\n' "$work/mount" >&2
      return
    fi
  fi
  if [ -n "${user_stage:-}" ] && [ -d "$user_stage/previous.app" ]; then
    if [ ! -e "$user_app" ]; then mv "$user_stage/previous.app" "$user_app" || :; fi
    printf 'TASTEDEV: recovery staging retained: %s\n' "$user_stage" >&2
    user_stage=
  fi
  if [ -n "${user_stage:-}" ] && [ -d "$user_stage" ]; then rm -rf -- "$user_stage"; fi
  if [ -n "${work:-}" ] && [ -d "$work" ]; then rm -rf -- "$work"; fi
  if [ "${user_locked:-false}" = true ]; then rmdir "$user_state/lock"; fi
}
assert_personal_idle() {
  command -v pgrep >/dev/null 2>&1 || fail 'pgrep is required to protect personal app work.'
  # The bundle launcher may be named tastedev-launcher rather than tasteremote.
  pattern=$(printf '%s' "$user_app/" | sed 's/[][\\.^$*+?(){}|]/\\&/g')
  if pgrep -u "$(id -u)" -f "$pattern|(^|/)taste(dev-)?${personal_product}(-[A-Za-z0-9_-]+)?([/[:space:]]|$)" >/dev/null; then
    fail "The personal $personal_product app is running. Save work and close every instance, then retry."
  else
    status=$?; [ "$status" = 1 ] || fail 'Cannot inspect personal app processes.'
  fi
}
install_macos_user() {
  [ "$(id -u)" != 0 ] || fail 'Personal installation must run as the intended user, without sudo.'
  case "${HOME:-}" in /*) ;; *) fail 'An absolute HOME is required.' ;; esac
  user_apps="$HOME/Applications"
  user_app="$user_apps/${personal_brand}.app"
  user_state="$HOME/Library/Application Support/TASTEDEV/Installer/$personal_product"
  assert_user_path "$user_app"; assert_user_path "$user_state"
  if [ "$update_only" = true ] && [ ! -d "$user_app" ]; then say "No personal $personal_brand installation; skipping."; return; fi
  for tool in osascript hdiutil ditto codesign shasum; do command -v "$tool" >/dev/null 2>&1 || fail "$tool is required."; done
  mac_major=$(sw_vers -productVersion | cut -d. -f1)
  case "$mac_major" in ''|*[!0-9]*) fail 'Cannot identify macOS version.' ;; esac
  [ "$mac_major" -ge "$personal_minimum" ] || fail "$personal_brand requires macOS $personal_minimum or later."
  [ "$(LC_ALL=C ls -nd "$HOME" | awk '{print $3}')" = "$(id -u)" ] || fail 'HOME does not belong to the current user.'
  if [ -e "$user_state" ]; then
    [ "$(LC_ALL=C ls -nd "$user_state" | awk '{print $3}')" = "$(id -u)" ] || fail 'Personal installer state has another owner.'
  fi
  mkdir -p "$user_apps" "$user_state"
  [ "$(LC_ALL=C ls -nd "$user_apps" | awk '{print $3}')" = "$(id -u)" ] || fail 'Applications directory has another owner.'
  chmod go-w "$user_apps"
  chmod -N "$user_state"; chmod 700 "$user_state"
  user_locked=false; user_mounted=false; user_stage=
  new_work
  trap 'user_install_cleanup' 0
  assert_user_path "$work"
  chmod -N "$work"; chmod 700 "$work"
  mkdir "$user_state/lock" 2>/dev/null || fail "Another installation or unfinished lock exists: $user_state/lock"
  user_locked=true
  cat >"$work/metadata.js" <<'JXA'
ObjC.import('Foundation');
function run(args) {
  const text=ObjC.unwrap($.NSString.stringWithContentsOfFileEncodingError(args[0], $.NSUTF8StringEncoding, null));
  const response=JSON.parse(text);
  const releases=Array.isArray(response)?response:[response];
  if(releases.length!==1)throw Error('Expected one public release');
  const id=args[1]||'remote';
  if(!/^(cad|code|etl|files|ftp|geo|mail|remote|ssh|studio|zip)$/.test(id))throw Error('Unsupported product');
  const r=releases[0];
  if(r.draft!==false || r.prerelease!==false || !new RegExp('^(?:taste)?'+id+'-v\\d+\\.\\d+\\.\\d+$').test(r.tag_name))throw Error('Not a stable product release');
  const version=r.tag_name.split('-v')[1];
  const name='tastedev-'+id+'-'+version+'-macos-arm64.dmg';
  const assets=(r.assets||[]).filter(a=>a.name===name);
  if(assets.length!==1)throw Error('No unique Apple Silicon DMG');
  const a=assets[0];
  const url='https://github.com/whitecalvin/tastedev-releases/releases/download/'+r.tag_name+'/'+name;
  if(a.browser_download_url!==url || !/^sha256:[a-f0-9]{64}$/.test(a.digest||'') || !Number.isSafeInteger(a.size) || a.size<=0)throw Error('Invalid DMG URL, digest or size');
  return [version,url,a.digest.slice(7),String(a.size)].join('\n');
}

JXA
  download "https://tastedev.net/api/updates/$personal_product" "$work/update.json"
  osascript -l JavaScript "$work/metadata.js" "$work/update.json" "$personal_product" >"$work/metadata" || fail "Cannot validate public $personal_brand metadata."
  { IFS= read -r user_version; IFS= read -r user_url; IFS= read -r user_sha; IFS= read -r user_bytes; } <"$work/metadata"
  assert_user_path "$user_state/receipt"
  if [ -e "$user_app" ]; then
    [ -d "$user_app" ] && [ "$(LC_ALL=C ls -nd "$user_app" | awk '{print $3}')" = "$(id -u)" ] || fail 'Existing personal app is not owned by this user.'
    [ -f "$user_state/receipt" ] || fail 'Existing app has no personal installer receipt; preserve it and move it aside before adoption.'
    { IFS= read -r previous_version; IFS= read -r previous_sha; } <"$user_state/receipt"
    case "$previous_version" in ''|*[!0-9.]*) fail 'Invalid personal version receipt.' ;; esac
    [ "$(printf '%s\n%s\n' "$previous_version" "$user_version" | sort -t. -k1,1n -k2,2n -k3,3n | tail -n 1)" = "$user_version" ] || fail 'Refusing to downgrade the personal app.'
    if [ "$previous_version" = "$user_version" ]; then
      [ "$previous_sha" = "$user_sha" ] || fail 'Published bytes changed at the same version; keeping the installed app.'
      codesign --verify --deep --strict "$user_app" || fail 'Installed app signature is damaged.'
      [ "$(/usr/libexec/PlistBuddy -c 'Print :CFBundleShortVersionString' "$user_app/Contents/Info.plist")" = "$user_version" ] || fail 'Installed app version differs from its receipt.'
      chmod -N "$user_app"; chmod 700 "$user_app"
      say "Personal $personal_brand $user_version is already up to date."; return
    fi
  fi
  assert_personal_idle
  download "$user_url" "$work/package.dmg"
  [ "$(wc -c <"$work/package.dmg" | tr -d '[:space:]')" = "$user_bytes" ] || fail 'DMG byte size mismatch.'
  [ "$(shasum -a 256 "$work/package.dmg" | awk '{print $1}')" = "$user_sha" ] || fail 'DMG SHA256 mismatch.'
  mkdir "$work/mount"
  hdiutil attach -readonly -nobrowse -mountpoint "$work/mount" "$work/package.dmg" >/dev/null || fail 'Cannot mount verified DMG.'
  user_mounted=true
  [ -d "$work/mount/${personal_brand}.app" ] && [ ! -L "$work/mount/${personal_brand}.app" ] || fail "DMG has no regular ${personal_brand}.app bundle."
  user_stage=$(mktemp -d "$user_apps/.tastedev-${personal_product}.XXXXXX")
  chmod -N "$user_stage"; chmod 700 "$user_stage"
  ditto --noacl "$work/mount/${personal_brand}.app" "$user_stage/${personal_brand}.app"
  codesign --verify --deep --strict "$user_stage/${personal_brand}.app" || fail 'New app signature verification failed.'
  [ "$(/usr/libexec/PlistBuddy -c 'Print :CFBundleIdentifier' "$user_stage/${personal_brand}.app/Contents/Info.plist")" = "$personal_identifier" ] || fail 'Unexpected app identifier.'
  [ "$(/usr/libexec/PlistBuddy -c 'Print :CFBundleShortVersionString' "$user_stage/${personal_brand}.app/Contents/Info.plist")" = "$user_version" ] || fail 'DMG bundle version mismatch.'
  chmod -N "$user_stage/${personal_brand}.app"; chmod 700 "$user_stage/${personal_brand}.app"
  hdiutil detach "$work/mount" >/dev/null || fail 'Cannot detach DMG; current app preserved.'
  user_mounted=false
  assert_personal_idle
  printf '%s\n%s\n' "$user_version" "$user_sha" >"$user_stage/receipt"
  chmod 600 "$user_stage/receipt"
  if [ -d "$user_app" ]; then mv "$user_app" "$user_stage/previous.app"; fi
  if ! mv "$user_stage/${personal_brand}.app" "$user_app"; then
    if [ -d "$user_stage/previous.app" ]; then mv "$user_stage/previous.app" "$user_app" || { printf 'Previous app preserved in %s\n' "$user_stage" >&2; user_stage=; fail 'Restore failed.'; }; fi
    fail 'Cannot activate personal app.'
  fi
  if ! mv "$user_stage/receipt" "$user_state/receipt"; then
    # Retain both the new app and the previous version for explicit recovery.
    printf 'Personal app installed but receipt failed. Recovery files: %s\n' "$user_stage" >&2
    user_stage=; fail 'Receipt activation failed; no recovery files were deleted.'
  fi
  if [ -d "$user_stage/previous.app" ]; then
    say "Previous app retained for recovery: $user_stage/previous.app"
    user_stage=
  fi
  say "Personal $personal_brand $user_version installed: $user_app"
  say 'Only this normal user can access this app bundle. Administrator/root access is not restricted.'
}
install_linux_user() {
  [ "$(id -u)" != 0 ] || fail 'Personal installation must run as the intended user, without sudo.'
  command -v python3 >/dev/null 2>&1 || fail 'python3 is required for verified Linux personal installation.'
  case "$HOME" in /*) ;; *) fail 'An absolute HOME is required.' ;; esac
  assert_user_path "$HOME/.local/opt/tastedev-$personal_product"
  new_work
  cat >"$work/linux-user.py" <<'PY'
import fcntl, hashlib, json, os, pathlib, re, shlex, subprocess, sys, tempfile, uuid, tarfile, posixpath, shutil
home=pathlib.Path(sys.argv[1]); work=pathlib.Path(sys.argv[2]); update_only=sys.argv[3]=='true'
product=sys.argv[4] if len(sys.argv)>4 else 'remote'
if product not in 'cad code etl files ftp geo mail remote ssh studio zip'.split():raise RuntimeError('Unsupported personal product')
brand='TASTE'+product.upper()
archive_product=product in ('etl','geo','mail','studio')
command={'geo':'tastegeo-server','mail':'tastemail-server'}.get(product,'taste'+product)
uid=os.getuid()
def checked(p):
    for parent in [p,*p.parents]:
        if parent.is_symlink(): raise RuntimeError('Linked personal path: '+str(parent))
    if p.exists() and p.stat().st_uid!=uid: raise RuntimeError('Another owner: '+str(p))
    return p
def directory(p,private=False):
    checked(p);p.mkdir(parents=True,exist_ok=True)
    if private:p.chmod(0o700)
    return p
def atomic(p,data,mode):
    checked(p)
    fd,name=tempfile.mkstemp(prefix='.tastedev-',dir=p.parent)
    try:
        with os.fdopen(fd,'w') as f:f.write(data)
        os.chmod(name,mode);os.replace(name,p)
    finally:
        if os.path.exists(name):os.unlink(name)
def idle(root):
    for proc in pathlib.Path('/proc').iterdir():
        if not proc.name.isdigit() or proc.name==str(os.getpid()):continue
        try:
            if proc.stat().st_uid!=uid:continue
            args=(proc/'cmdline').read_bytes().split(b'\0')
            names=[os.fsdecode(a) for a in args if a]
            if any(str(root)+'/' in a or re.fullmatch(r'taste'+product+r'(?:-[a-z-]+)?',pathlib.Path(a).name) for a in names):
                raise RuntimeError(brand+' is running. Save work and close all instances before updating.')
        except (FileNotFoundError,ProcessLookupError):continue
root=home/('.local/opt/tastedev-'+product); current=root/'current'
checked(home)
if update_only and not root.exists():print('No personal '+brand+' installation; skipping.');sys.exit(0)
directory(root,True)
lock_path=checked(root/'install.lock')
with open(lock_path,'a') as lock:
    os.chmod(lock_path,0o600)
    fcntl.flock(lock,fcntl.LOCK_EX|fcntl.LOCK_NB)
    old=None
    if current.exists() or current.is_symlink():
        if not current.is_symlink():raise RuntimeError('Preserving unmanaged current path')
        target=os.readlink(current)
        if not re.fullmatch(r'versions/\d+\.\d+\.\d+-[a-f0-9]{64}',target):raise RuntimeError('Unsafe personal current reference')
        old=checked(root/target)
        if not old.is_dir():raise RuntimeError('Missing personal checkpoint')
    elif update_only:print('No personal app selected for update.');sys.exit(0)
    def fetch(url,p):subprocess.run(['curl','--fail','--silent','--show-error','--location','--proto','=https','--proto-redir','=https','--tlsv1.2','--output',str(p),url],check=True,stdin=subprocess.DEVNULL)
    fetch('https://tastedev.net/api/updates/'+product,work/'update.json')
    data=json.loads((work/'update.json').read_text());releases=data if isinstance(data,list) else [data]
    if len(releases)!=1:raise RuntimeError('Expected one public release')
    r=releases[0];match=re.fullmatch(r'(?:taste)?'+product+r'-v(\d+\.\d+\.\d+)',r.get('tag_name',''))
    if not match or r.get('draft') is not False or r.get('prerelease') is not False:raise RuntimeError('Not a stable product release')
    version=match[1];package_base='tastedev-'+product+'-'+version+'-linux-x86_64'
    name=package_base+('.tar.gz' if archive_product else '.AppImage')
    assets=[a for a in r.get('assets',[]) if a.get('name')==name]
    if len(assets)!=1:raise RuntimeError('No unique published Linux x64 package for '+product)
    a=assets[0];sha=a.get('digest','');size=a.get('size')
    url='https://github.com/whitecalvin/tastedev-releases/releases/download/'+r['tag_name']+'/'+name
    if a.get('browser_download_url')!=url or not re.fullmatch('sha256:[a-f0-9]{64}',sha) or type(size)!=int or size<=0:raise RuntimeError('Invalid AppImage metadata')
    sha=sha[7:]
    def digest(p):
        checked(p)
        h=hashlib.sha256()
        with open(p,'rb') as f:
            for chunk in iter(lambda:f.read(1024*1024),b''):h.update(chunk)
        return h.hexdigest()
    def inventory(folder):
        result={}
        for p in sorted(folder.rglob('*')):
            rel=str(p.relative_to(folder))
            if p.is_symlink():result[rel]={'link':os.readlink(p)}
            elif p.is_file():result[rel]={'sha256':digest(p),'mode':p.stat().st_mode&0o777}
            elif not p.is_dir():raise RuntimeError('Unexpected payload entry')
        return result
    def payload_entry(folder):
        choices={'etl':['tasteetl' if (folder/'tasteetl-cli').is_file() else 'tasteetl-desktop'],'geo':['bin/tastegeo-server','tastegeo-server'],'mail':['bin/tastemail-server','bin/tastemail','tastemail-server','tastemail'],'studio':['tastestudio']}[product]
        entries=[entry for entry in choices if (folder/entry).is_file() and not (folder/entry).is_symlink() and os.access(folder/entry,os.X_OK)]
        if not entries:raise RuntimeError('No supported personal executable in published archive')
        return entries[0]
    if old:
        receipt=json.loads(checked(old/'receipt.json').read_text())
        prev=receipt['version']
        if not re.fullmatch(r'\d+\.\d+\.\d+',prev):raise RuntimeError('Invalid previous version')
        if tuple(map(int,prev.split('.')))>tuple(map(int,version.split('.'))):raise RuntimeError('Refusing downgrade')
        if prev==version:
            if receipt['sha256']!=sha:raise RuntimeError('Same-version bytes conflict; preserving existing files')
            if archive_product:
                if inventory(old/'payload')!=json.loads(checked(old/'files.json').read_text()):raise RuntimeError('Installed payload changed')
                if checked(old/'entry').read_text()!=payload_entry(old/'payload'):raise RuntimeError('Installed entry checkpoint changed')
            else:
                app=old/'tasteremote.AppImage' if product=='remote' else old/(product+'.AppImage')
                if digest(app)!=sha:raise RuntimeError('Installed AppImage changed')
                app.chmod(0o700)
            print('Personal '+brand+' '+version+' is up to date.');sys.exit(0)
    launcher=home/('.local/bin/'+command); desktop=home/('.local/share/applications/tastedev-'+product+'-user.desktop')
    for p in [launcher,desktop]:
        checked(p)
        if p.exists() and 'TASTEDEV personal installer' not in p.read_text():raise RuntimeError('Preserving unmanaged file: '+str(p))
    idle(root)
    package=work/'package.AppImage';fetch(url,package)
    if package.stat().st_size!=size or digest(package)!=sha:raise RuntimeError('AppImage size/SHA256 mismatch')
    if not archive_product:
        with open(package,'rb') as f:header=f.read(11)
        if header[:4]!=b'\x7fELF' or header[8:11]!=b'AI\x02':raise RuntimeError('Not a type-2 AppImage')
    versions=directory(root/'versions',True);destination=versions/(version+'-'+sha)
    app_name='tasteremote.AppImage' if product=='remote' else product+'.AppImage'
    if destination.exists():
        checked(destination)
        if archive_product:
            if inventory(destination/'payload')!=json.loads(checked(destination/'files.json').read_text()):raise RuntimeError('Existing version checkpoint conflicts')
            if checked(destination/'entry').read_text()!=payload_entry(destination/'payload'):raise RuntimeError('Existing executable checkpoint conflicts')
        elif digest(destination/app_name)!=sha:raise RuntimeError('Existing version checkpoint conflicts')
    else:
        stage=pathlib.Path(tempfile.mkdtemp(prefix='.incoming-',dir=versions));stage.chmod(0o700)
        if archive_product:
            payload=directory(stage/'payload',True);links=[];seen=set()
            with tarfile.open(package,'r:gz') as tar:
                members=tar.getmembers()
                if sum(m.size for m in members)>16*1024**3 or len(members)>500000:raise RuntimeError('Archive expansion exceeds limit')
                for m in members:
                    path=pathlib.PurePosixPath(m.name)
                    if path.is_absolute() or '..' in path.parts or not path.parts or path.parts[0]!=package_base:raise RuntimeError('Archive path escaped product payload')
                    rel=pathlib.PurePosixPath(*path.parts[1:])
                    if str(rel)=='.':
                        if not m.isdir():raise RuntimeError('Archive root must be a directory')
                        continue
                    if str(rel) in seen:raise RuntimeError('Duplicate archive path')
                    seen.add(str(rel));target=payload/str(rel)
                    checked(target);target.parent.mkdir(parents=True,exist_ok=True)
                    if m.isdir():target.mkdir(exist_ok=True);target.chmod(0o700)
                    elif m.isfile():
                        with tar.extractfile(m) as src,open(target,'xb') as dst:shutil.copyfileobj(src,dst)
                        target.chmod(0o700 if m.mode&0o111 else 0o600)
                    elif m.issym() or m.islnk():links.append((m,rel))
                    else:raise RuntimeError('Archive special device entry rejected')
                for m,rel in links:
                    if m.issym():
                        resolved=posixpath.normpath(posixpath.join(str(rel.parent),m.linkname))
                        if m.linkname.startswith('/') or resolved=='..' or resolved.startswith('../'):raise RuntimeError('External archive symlink')
                        checked(payload/str(rel));os.symlink(m.linkname,payload/str(rel))
                    else:
                        p=pathlib.PurePosixPath(m.linkname)
                        if p.is_absolute() or '..' in p.parts or not p.parts or p.parts[0]!=package_base:raise RuntimeError('External archive hardlink')
                        original=checked(payload/str(pathlib.PurePosixPath(*p.parts[1:])))
                        if not original.is_file():raise RuntimeError('Hardlink target unavailable')
                        os.link(original,checked(payload/str(rel)))
            atomic(stage/'entry',payload_entry(payload),0o600)
            atomic(stage/'files.json',json.dumps(inventory(payload),sort_keys=True)+'\n',0o600)
        else:
            os.replace(package,stage/app_name);(stage/app_name).chmod(0o700)
            # The dock and app grid show this icon: the AppImage's top-level PNG, usually a link
            # into usr/share/icons that is extracted in a second step.
            try:
                grab=pathlib.Path(tempfile.mkdtemp(prefix='.icon-',dir=work));squash=grab/'squashfs-root'
                env={k:v for k,v in os.environ.items() if not k.startswith('APPIMAGE')}
                def extract(pattern):subprocess.run([str(stage/app_name),'--appimage-extract',pattern],cwd=grab,env=env,stdout=subprocess.DEVNULL,stderr=subprocess.DEVNULL,timeout=120,check=True)
                extract('*.png')
                tops=sorted(squash.glob('*.png'))
                if tops and tops[0].is_symlink():
                    target=posixpath.normpath(os.readlink(tops[0]))
                    if not re.fullmatch(r'usr/share/icons/[A-Za-z0-9_./-]+\.png',target) or '..' in target.split('/'):raise RuntimeError('icon link')
                    extract(target);found=squash/target
                elif tops:found=tops[0]
                else:found=None
                if found is not None and found.is_file() and not found.is_symlink() and found.stat().st_size<=8*1024**2:
                    png=found.read_bytes()
                    if png[:8]==b'\x89PNG\r\n\x1a\n':(stage/'icon.png').write_bytes(png);(stage/'icon.png').chmod(0o600)
            except Exception:
                pass
        atomic(stage/'receipt.json',json.dumps({'version':version,'sha256':sha,'url':url})+'\n',0o600)
        os.rename(stage,destination)
    idle(root)
    directory(launcher.parent);directory(desktop.parent)
    runtime=directory(home/('.cache/tastedev/'+product+'-runtime'),True)
    if any(c in str(home) for c in '\r\n'):raise RuntimeError('Unsupported HOME characters')
    entry=current/app_name
    if archive_product:
        entry_name=checked(destination/'entry').read_text()
        if not re.fullmatch(r'(?:bin/)?taste[a-z]+(?:-[a-z]+)*',entry_name):raise RuntimeError('Invalid executable checkpoint')
        entry=current/'payload'/entry_name
    wrapper='#!/bin/sh\n# TASTEDEV personal installer\numask 077\n'+('' if archive_product else 'export APPIMAGE_EXTRACT_AND_RUN=1\n')+'export TMPDIR='+shlex.quote(str(runtime))+'\n'+('cd '+shlex.quote(str(current/'payload'))+'\n' if archive_product else '')+'exec '+shlex.quote(str(entry))+' "$@"\n'
    # Wrappers always point to current, so installing them does not run/replace an app.
    atomic(launcher,wrapper,0o700)
    escaped=str(launcher).replace('\\','\\\\').replace('"','\\"').replace('`','\\`').replace('$','\\$').replace('%','%%')
    icon=current/'icon.png'
    icon_line='Icon='+str(icon)+'\n' if (destination/'icon.png').is_file() and not any(c in str(icon) for c in '\r\n') else ''
    wm_class='' if archive_product else 'StartupWMClass=com.gxsoft.tastedev.'+product+'\n'
    atomic(desktop,'[Desktop Entry]\n# TASTEDEV personal installer\nType=Application\nName='+brand+'\nExec="'+escaped+'"\n'+icon_line+wm_class+'Terminal='+('true' if product in ('geo','mail') else 'false')+'\nCategories=Utility;\n',0o600)
    next_link=root/('.current-'+uuid.uuid4().hex)
    try:
        os.symlink('versions/'+destination.name,next_link);os.replace(next_link,current)
    finally:
        if next_link.is_symlink():next_link.unlink()
    print('Personal '+brand+' '+version+' installed: '+str(launcher))
    print('Previous version checkpoints retained. No system services or repositories changed.')
PY
  python3 "$work/linux-user.py" "$HOME" "$work" "$update_only" "$personal_product" || fail 'Linux personal installation stopped; existing checkpoints preserved.'
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
  assert_brew_writable
  "$brew" tap whitecalvin/tastedev </dev/null || fail 'Homebrew tap registration failed; app installation was not started.'
  "$brew" update --quiet </dev/null
  actions=
  unavailable=0; available_count=0
  # Check the entire selection before starting an application installation.
  for product in $products; do
    token="whitecalvin/tastedev/tastedev-$product"
    action=install
    if "$brew" list --cask --versions "tastedev-$product" >/dev/null 2>&1; then
      outdated=$("$brew" outdated --cask --greedy --quiet "$token" </dev/null) || fail "Cannot check updates for $product."
      if [ -z "$outdated" ]; then say "$product is already up to date; keeping the current app."; available_count=$((available_count + 1)); continue; fi
      action=upgrade
    elif [ "$update_only" = true ]; then
      say "$product is not installed; skipping."
      continue
    fi
    if ! "$brew" info --cask "whitecalvin/tastedev/tastedev-$product" >/dev/null </dev/null; then
      if [ "$select_all" = true ]; then
        say "$product has no accessible published Cask; skipping." >&2
        unavailable=$((unavailable + 1)); continue
      fi
      fail "No published Homebrew Cask for $product. No selected apps were installed."
    fi
    available_count=$((available_count + 1))
    assert_idle "$product"
    actions="$actions $action:$product"
  done
  if [ "$unavailable" -gt 0 ] && [ "$available_count" = 0 ]; then fail 'No accessible published Casks in the selection.'; fi
  for entry in $actions; do
    action=${entry%%:*}; product=${entry#*:}
    token="whitecalvin/tastedev/tastedev-$product"
    assert_idle "$product"
    "$brew" "$action" --cask "$token" </dev/null
  done
  say 'macOS installation finished. Apps are in Applications; macOS may request Open Anyway in Privacy & Security.'
}
install_personal_selection() {
  for selected in $products; do
    (
      personal_product=$selected
      personal_brand="TASTE$(printf '%s' "$selected" | tr '[:lower:]' '[:upper:]')"
      personal_identifier="com.gxsoft.tastedev.$selected"
      case "$selected" in etl|geo|mail|studio) personal_minimum=14 ;; remote) personal_minimum=13 ;; *) personal_minimum=12 ;; esac
      case "$os" in Darwin) install_macos_user ;; Linux) install_linux_user ;; esac
    )
  done
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
  products= yes=false dry_run=false bootstrap=true select_all=false update_only=false personal=false
  while [ "$#" -gt 0 ]; do
    case "$1" in
      --help|-h) usage; return ;;
      --list) say "macOS arm64: $mac_products"; say "Linux x86_64: $linux_products"; say 'Not published through these repositories: fast office'; return ;;
      --yes|-y) yes=true ;;
      --dry-run) dry_run=true ;;
      --all) select_all=true ;;
      --update) update_only=true ;;
      --user) personal=true ;;
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
  if [ "$personal" = false ] && [ "$yes" = false ] && [ "$dry_run" = false ]; then
      printf 'Install selected products for this user only, without a system package manager? [Y/n] ' >/dev/tty
      IFS= read -r answer </dev/tty || fail 'Installation cancelled.'
      case "$answer" in ''|y|Y|yes|YES) personal=true ;; n|N|no|NO) ;; *) fail 'Invalid installation scope.' ;; esac
  fi
  say "TASTEDEV: $os $arch; products:$products"
  if [ "$personal" = true ]; then say 'Personal installation: current account only; no system package manager or sudo.'; fi
  if [ "$dry_run" = true ]; then say 'Dry run: no downloads, repository changes, or installations.'; return; fi
  confirm
  if [ "$personal" = true ]; then install_personal_selection
  else case "$os" in Darwin) install_macos ;; Linux) install_linux ;; esac; fi
}
main "$@"
