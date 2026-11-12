# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ssh" do
  version "0.3.11"
  sha256 "d68470b62c9310975deca421d96c7d9961b0ffbca4e428c2b88ff131705f974b"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ssh-v0.3.11/tastedev-ssh-0.3.11-macos-arm64.dmg"
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
