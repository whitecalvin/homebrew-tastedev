# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ssh" do
  version "0.3.30"
  sha256 "36db18a044c6dcc16c9ccd13a6c8954ca5ac0a25477932a121a46ea2967bb060"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ssh-v0.3.30/tastedev-ssh-0.3.30-macos-arm64.dmg"
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
