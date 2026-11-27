# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-stock" do
  version "0.1.8"
  sha256 "f0479960a28af9ee6ad9cfcd6381bc2b8e8e47191fbfa271100df86786f1437c"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/stock-v0.1.8/tastedev-stock-0.1.8-macos-arm64.dmg"
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
