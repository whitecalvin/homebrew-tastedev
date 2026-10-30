# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-files" do
  version "0.2.33"
  sha256 "317a7f27fb40c1b904843c71760f7a787174f4438e399903a81f1b4fdd5ef708"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/files-v0.2.33/tastedev-files-0.2.33-macos-arm64.dmg"
  name "TASTEFILES"
  desc "TASTEFILES desktop application"
  homepage "https://tastedev.net/products/files"

  depends_on arch: :arm64
  depends_on macos: ">= :monterey"

  app "TASTEFILES.app"

  caveats <<~EOS
    This release is ad-hoc signed and is not Apple notarized.
    macOS may require Open Anyway in System Settings > Privacy & Security.
    No quarantine attributes or Gatekeeper settings are changed by this cask.
  EOS
end
