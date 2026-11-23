# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-winm" do
  version "0.1.11"
  sha256 "32c8a9206d79b8b686327f266fe01c7ef57f030f91e78c2ecb34897adfc3347b"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/winm-v0.1.11/tastedev-winm-0.1.11-macos-arm64.dmg"
  name "TASTEWINM"
  desc "TASTEWINM desktop application"
  homepage "https://tastedev.net/products/winm"

  depends_on arch: :arm64
  depends_on macos: ">= :monterey"

  app "TASTEWINM.app"

  caveats <<~EOS
    This release is ad-hoc signed and is not Apple notarized.
    macOS may require Open Anyway in System Settings > Privacy & Security.
    No quarantine attributes or Gatekeeper settings are changed by this cask.
  EOS
end
