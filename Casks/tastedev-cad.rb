# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-cad" do
  version "0.3.13"
  sha256 "d71a319e971d8a2ad6e9b167a1a10459f1ddc3b7fc39de95e42d6f172d258795"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/cad-v0.3.13/tastedev-cad-0.3.13-macos-arm64.dmg"
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
