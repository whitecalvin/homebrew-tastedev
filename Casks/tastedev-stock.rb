# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-stock" do
  version "0.1.3"
  sha256 "4278ea1ed32073f5cea05f0fdd8250d98bc4db91a0bdcd90950ccc71165ef3f2"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/stock-v0.1.3/tastedev-stock-0.1.3-macos-arm64.dmg"
  name "TASTESTOCK"
  desc "TASTESTOCK desktop application"
  homepage "https://tastedev.net/products/stock"

  depends_on arch: :arm64
  depends_on macos: ">= :monterey"

  app "TASTESTOCK.app"

  caveats <<~EOS
    This release is ad-hoc signed and is not Apple notarized.
    macOS may require Open Anyway in System Settings > Privacy & Security.
    No quarantine attributes or Gatekeeper settings are changed by this cask.
  EOS
end
