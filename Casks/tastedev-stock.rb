# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-stock" do
  version "0.1.2"
  sha256 "cc383c5740583c5d17a863d42251bff9e4954450ab5af12529285a7c573a3dc5"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/stock-v0.1.2/tastedev-stock-0.1.2-macos-arm64.dmg"
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
