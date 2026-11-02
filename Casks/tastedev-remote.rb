# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-remote" do
  version "0.2.13"
  sha256 "a2b218de2a395815c3a7e2ec8cb743c0bc4e34adbd7c84aab8cb875a0891fa34"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/remote-v0.2.13/tastedev-remote-0.2.13-macos-arm64.dmg"
  name "TASTEREMOTE"
  desc "TASTEREMOTE desktop application"
  homepage "https://tastedev.net/products/remote"

  depends_on arch: :arm64
  depends_on macos: ">= :ventura"

  app "TASTEREMOTE.app"

  caveats <<~EOS
    This release is ad-hoc signed and is not Apple notarized.
    macOS may require Open Anyway in System Settings > Privacy & Security.
    No quarantine attributes or Gatekeeper settings are changed by this cask.
  EOS
end
