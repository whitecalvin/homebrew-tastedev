# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-cad" do
  version "0.2.38"
  sha256 "3c4f568771262b2af22aa892bb2596e227a2af435e3c2a47ccd676f3c400b1b4"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/cad-v0.2.38/tastedev-cad-0.2.38-macos-arm64.dmg"
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
