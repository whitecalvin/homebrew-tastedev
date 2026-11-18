# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-cad" do
  version "0.3.2"
  sha256 "fa6c3fda3e4369924b749765de5861fd91526c7408a48e8e6fc4283f9e8c7b8a"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/cad-v0.3.2/tastedev-cad-0.3.2-macos-arm64.dmg"
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
