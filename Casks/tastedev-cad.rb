# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-cad" do
  version "0.3.7"
  sha256 "333bce335b1ef64ad3b952dc8711ffe72d7bf6fdd236ca6d48c1a26372e31c66"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/cad-v0.3.7/tastedev-cad-0.3.7-macos-arm64.dmg"
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
