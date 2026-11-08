# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ssh" do
  version "0.2.86"
  sha256 "af9d4f98a260ff4e3b773ea03b95c405b464b8a1202a62f635aa05196b50ef4b"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ssh-v0.2.86/tastedev-ssh-0.2.86-macos-arm64.dmg"
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
