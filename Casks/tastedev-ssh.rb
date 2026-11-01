# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ssh" do
  version "0.2.58"
  sha256 "a7a6ee301675c6515c3a2b92df9b55bf11fa58f0a2801b8237b9af79cd0b876d"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ssh-v0.2.58/tastedev-ssh-0.2.58-macos-arm64.dmg"
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
