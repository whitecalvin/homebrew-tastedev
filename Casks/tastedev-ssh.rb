# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ssh" do
  version "0.3.16"
  sha256 "5b8f0d1e13fa95e25a2bdd864d6a25b16fca0dbf6fa2cf96867415f49d60069c"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ssh-v0.3.16/tastedev-ssh-0.3.16-macos-arm64.dmg"
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
