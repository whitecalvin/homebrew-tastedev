# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ssh" do
  version "0.3.24"
  sha256 "5cb3254cf41c5e5b98d9b2aa6fc3411fa21dbdd2413332e41b5ea784b0b57f8c"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ssh-v0.3.24/tastedev-ssh-0.3.24-macos-arm64.dmg"
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
