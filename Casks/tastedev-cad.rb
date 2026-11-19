# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-cad" do
  version "0.3.8"
  sha256 "b2b5e3d08ebb97c5ddece89dfd927be56613e3664cea7c63703ca04d1f5a05c5"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/cad-v0.3.8/tastedev-cad-0.3.8-macos-arm64.dmg"
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
