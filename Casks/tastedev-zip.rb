# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-zip" do
  version "0.2.44"
  sha256 "f54c9c4bdb689fc0935735f4e5bcac84d8796ce0150cd90f0af2bdc34f2dd4b3"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/zip-v0.2.44/tastedev-zip-0.2.44-macos-arm64.dmg"
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
