# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-stock" do
  version "0.1.9"
  sha256 "ccf6fe241eb012e438c5e6835e59b1e18f2668129502471d784da5724f3640ac"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/stock-v0.1.9/tastedev-stock-0.1.9-macos-arm64.dmg"
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
