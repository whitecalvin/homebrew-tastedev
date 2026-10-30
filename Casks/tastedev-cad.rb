# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-cad" do
  version "0.2.30"
  sha256 "3d9e1fbb754e074abb3218c99595dd04c5b8380bbfc9fdedf61000a8ec686e8e"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/cad-v0.2.30/tastedev-cad-0.2.30-macos-arm64.dmg"
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
