# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ssh" do
  version "0.2.59"
  sha256 "f1c73871ded9218576bfdbe53a9400d0a6c4ea6755994d4c9b44153b56a48891"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ssh-v0.2.59/tastedev-ssh-0.2.59-macos-arm64.dmg"
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
