# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ssh" do
  version "0.3.29"
  sha256 "2fd13433e87dcaefab7777b383cb54ba1d06a9d75092bec5b2207c08b02f242d"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ssh-v0.3.29/tastedev-ssh-0.3.29-macos-arm64.dmg"
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
