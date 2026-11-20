# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-cad" do
  version "0.3.12"
  sha256 "3e3f6e98e6a53823859d668a1d996cdf10046714ae799e4ce0c4da04e03aaae9"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/cad-v0.3.12/tastedev-cad-0.3.12-macos-arm64.dmg"
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
