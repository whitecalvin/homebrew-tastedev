# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-cad" do
  version "0.3.6"
  sha256 "535a1b01e1dee2dc3da60f3cc91e528b14bb7e67d641eb647a4eb8eab2ae158e"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/cad-v0.3.6/tastedev-cad-0.3.6-macos-arm64.dmg"
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
