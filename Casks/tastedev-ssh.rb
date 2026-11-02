# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ssh" do
  version "0.2.69"
  sha256 "82b96d6de1eee95ef55e8ae711d4777e7465c4727595b2884efd3a9c72bb421e"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ssh-v0.2.69/tastedev-ssh-0.2.69-macos-arm64.dmg"
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
