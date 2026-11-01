# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ssh" do
  version "0.2.60"
  sha256 "5dc462ecf6b92ad1ed844649669b6e285c25eb2559a41332d8be1ebb9370917e"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ssh-v0.2.60/tastedev-ssh-0.2.60-macos-arm64.dmg"
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
