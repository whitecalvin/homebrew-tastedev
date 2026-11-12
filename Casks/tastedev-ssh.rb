# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ssh" do
  version "0.3.13"
  sha256 "bdcbb6d159a64060486b100733cc4c593db57b0aab4190d0f86fc60932d7beb0"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ssh-v0.3.13/tastedev-ssh-0.3.13-macos-arm64.dmg"
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
