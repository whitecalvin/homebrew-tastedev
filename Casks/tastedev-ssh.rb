# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ssh" do
  version "0.2.80"
  sha256 "08e64a797af5e0ac8494f5dc215910e4e5ca0c5ed713dd831b1fa1c997a2700d"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ssh-v0.2.80/tastedev-ssh-0.2.80-macos-arm64.dmg"
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
