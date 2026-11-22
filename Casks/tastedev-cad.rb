# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-cad" do
  version "0.3.14"
  sha256 "dea7e340ad88842ec9d7254e00ff01d410ee78dc1729d875a92f0b6a97448dae"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/cad-v0.3.14/tastedev-cad-0.3.14-macos-arm64.dmg"
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
