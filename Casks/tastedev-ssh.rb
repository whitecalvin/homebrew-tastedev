# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ssh" do
  version "0.2.87"
  sha256 "c7aaa75aa8e8cd121f64914ebb4fcb85f77f168a4a098595dc9f6651a24903e0"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ssh-v0.2.87/tastedev-ssh-0.2.87-macos-arm64.dmg"
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
