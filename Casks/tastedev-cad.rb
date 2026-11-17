# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-cad" do
  version "0.3.0"
  sha256 "c070b5dba396cfbbb0be0f73485e36a3896d05e1cc7b02317caf7c782cf7e817"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/cad-v0.3.0/tastedev-cad-0.3.0-macos-arm64.dmg"
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
