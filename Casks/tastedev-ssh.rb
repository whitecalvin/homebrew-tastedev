# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ssh" do
  version "0.2.52"
  sha256 "c02ec57eae450187cbbf48425322318bdc7f50a92aec2fa9a264d0b632d87a25"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ssh-v0.2.52/tastedev-ssh-0.2.52-macos-arm64.dmg"
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
