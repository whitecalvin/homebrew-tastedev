# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ssh" do
  version "0.2.62"
  sha256 "03b2e1be0148bcd25ccf1aab1458d2e550541125e495e4a2b0c87b4c0e484bf9"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ssh-v0.2.62/tastedev-ssh-0.2.62-macos-arm64.dmg"
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
