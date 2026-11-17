# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-cad" do
  version "0.3.1"
  sha256 "23b8e0f2c4cb5afdf1ae5246e11c8197028988b97358ff5f6927b9aab0dfe014"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/cad-v0.3.1/tastedev-cad-0.3.1-macos-arm64.dmg"
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
