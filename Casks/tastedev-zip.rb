# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-zip" do
  version "0.2.29"
  sha256 "f4dae9ac700cd6f28e8cc7371ee7eeffa9405e4c2e31beaf4c3e61ec311a2d79"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/zip-v0.2.29/tastedev-zip-0.2.29-macos-arm64.dmg"
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
