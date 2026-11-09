# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ssh" do
  version "0.3.2"
  sha256 "f26915a3a2acf5b12d54ffd7d30f85153dafaa8f76a7c9be0723f6021631a33a"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ssh-v0.3.2/tastedev-ssh-0.3.2-macos-arm64.dmg"
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
