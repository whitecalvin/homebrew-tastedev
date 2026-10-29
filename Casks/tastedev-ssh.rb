# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ssh" do
  version "0.2.53"
  sha256 "0fd9e933c688cd8bf73ac7c179bd8f6c290cacf413e647179e5309e2828e96fe"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ssh-v0.2.53/tastedev-ssh-0.2.53-macos-arm64.dmg"
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
