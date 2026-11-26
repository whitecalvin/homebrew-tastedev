# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-stock" do
  version "0.1.6"
  sha256 "7ff761061774197d29d9a4c60f0bb8ad9a5c08ad19e0ccb8ba4983aecee14240"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/stock-v0.1.6/tastedev-stock-0.1.6-macos-arm64.dmg"
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
