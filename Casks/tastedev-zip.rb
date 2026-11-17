# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-zip" do
  version "0.2.40"
  sha256 "36fb6952c9b3920ec4f33d5b865e95b8ac4f676cf616b1623bd5029b7c90f83a"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/zip-v0.2.40/tastedev-zip-0.2.40-macos-arm64.dmg"
  name "TASTEZIP"
  desc "TASTEZIP desktop application"
  homepage "https://tastedev.net/products/zip"

  depends_on arch: :arm64
  depends_on macos: ">= :monterey"

  app "TASTEZIP.app"

  caveats <<~EOS
    This release is ad-hoc signed and is not Apple notarized.
    macOS may require Open Anyway in System Settings > Privacy & Security.
    No quarantine attributes or Gatekeeper settings are changed by this cask.
  EOS
end
