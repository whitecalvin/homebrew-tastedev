# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-zip" do
  version "0.2.33"
  sha256 "b8f1b3552454077327ddb49d8ba7bfd36d6b7f723a9e13f5f51875c8360b9ce1"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/zip-v0.2.33/tastedev-zip-0.2.33-macos-arm64.dmg"
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
