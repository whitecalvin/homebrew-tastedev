# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ssh" do
  version "0.3.23"
  sha256 "58ec17c12d37b82ae48ea0f47200ef8f6bd4a4b9f83906a15a58919dc8faf71f"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ssh-v0.3.23/tastedev-ssh-0.3.23-macos-arm64.dmg"
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
