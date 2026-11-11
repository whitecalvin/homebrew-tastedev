# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-zip" do
  version "0.2.36"
  sha256 "2c3c610f92513c811d7c328fd94188413ed74b66ecba5bc269d24fa26195b4e2"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/zip-v0.2.36/tastedev-zip-0.2.36-macos-arm64.dmg"
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
