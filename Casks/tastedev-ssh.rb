# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ssh" do
  version "0.3.14"
  sha256 "9daaec8bec744513cf3778f22d3b8525a8c5554bdf8fa142ec4ac1e91d517e25"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ssh-v0.3.14/tastedev-ssh-0.3.14-macos-arm64.dmg"
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
