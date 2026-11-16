# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ssh" do
  version "0.3.17"
  sha256 "eb7d7e696c8cf6ef54a1ef4c4ff218ea317f06afbf00687bfb70fa16ecf8d777"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ssh-v0.3.17/tastedev-ssh-0.3.17-macos-arm64.dmg"
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
