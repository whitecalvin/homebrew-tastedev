# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ssh" do
  version "0.2.51"
  sha256 "d372912cade7cbe268c8c1252dba87c3dc372bba16688ad95d2f6bf99dbfe671"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ssh-v0.2.51/tastedev-ssh-0.2.51-macos-arm64.dmg"
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
