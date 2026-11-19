# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-cad" do
  version "0.3.9"
  sha256 "2410606c5c6bf54c33b8ec90a0703487233e4bb38958146722f5873cfed1f0b5"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/cad-v0.3.9/tastedev-cad-0.3.9-macos-arm64.dmg"
  name "TASTECAD"
  desc "TASTECAD desktop application"
  homepage "https://tastedev.net/products/cad"

  depends_on arch: :arm64
  depends_on macos: ">= :monterey"

  app "TASTECAD.app"

  caveats <<~EOS
    This release is ad-hoc signed and is not Apple notarized.
    macOS may require Open Anyway in System Settings > Privacy & Security.
    No quarantine attributes or Gatekeeper settings are changed by this cask.
  EOS
end
