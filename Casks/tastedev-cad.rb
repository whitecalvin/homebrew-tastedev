# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-cad" do
  version "0.2.29"
  sha256 "2223d5e6577416a3231925f6882613f254cbf060854ad908bc4b5e5ef35cba17"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/cad-v0.2.29/tastedev-cad-0.2.29-macos-arm64.dmg"
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
