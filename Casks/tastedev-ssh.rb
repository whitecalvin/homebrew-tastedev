# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ssh" do
  version "0.2.61"
  sha256 "de797f0196a1e301b9ca07b8b184321e7399bc9c9d6d3a5be131df01a10ba9bc"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ssh-v0.2.61/tastedev-ssh-0.2.61-macos-arm64.dmg"
  name "TASTESSH"
  desc "TASTESSH desktop application"
  homepage "https://tastedev.net/products/ssh"

  depends_on arch: :arm64
  depends_on macos: ">= :monterey"

  app "TASTESSH.app"

  caveats <<~EOS
    This release is ad-hoc signed and is not Apple notarized.
    macOS may require Open Anyway in System Settings > Privacy & Security.
    No quarantine attributes or Gatekeeper settings are changed by this cask.
  EOS
end
