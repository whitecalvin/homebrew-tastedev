# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-zip" do
  version "0.2.26"
  sha256 "2b332fb399d70d6eb91337e92a0c323579b9a863192562581b314384032bb079"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/zip-v0.2.26/tastedev-zip-0.2.26-macos-arm64.dmg"
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
