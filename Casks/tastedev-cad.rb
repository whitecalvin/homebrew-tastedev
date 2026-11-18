# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-cad" do
  version "0.3.3"
  sha256 "f097fdca8c15f63f3c3d10479d4a405e101eed85cb0e49aaebeb3b38df4e96b5"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/cad-v0.3.3/tastedev-cad-0.3.3-macos-arm64.dmg"
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
