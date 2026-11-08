# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ssh" do
  version "0.2.83"
  sha256 "003faa7ab1d19eb07735b88a5c5e8cd2007cbd58fb5d362c8044279753eee7ba"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ssh-v0.2.83/tastedev-ssh-0.2.83-macos-arm64.dmg"
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
