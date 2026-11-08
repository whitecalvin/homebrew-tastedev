# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ssh" do
  version "0.2.88"
  sha256 "e972d541689dc461b2171a429b7ee595ebc7636b4f1fb792c5d44e1c5300c9f4"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ssh-v0.2.88/tastedev-ssh-0.2.88-macos-arm64.dmg"
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
