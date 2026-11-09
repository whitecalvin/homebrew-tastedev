# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ssh" do
  version "0.2.90"
  sha256 "b41207d7ac8b0bb75908a0b161fd234cd1d1f224ca9cabdee463716d957167cd"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ssh-v0.2.90/tastedev-ssh-0.2.90-macos-arm64.dmg"
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
