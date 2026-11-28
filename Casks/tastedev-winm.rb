# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-winm" do
  version "0.1.19"
  sha256 "491409b376001164eca483f81ee181b148dfeb7a03df4cb01dbd32153792eecd"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/winm-v0.1.19/tastedev-winm-0.1.19-macos-arm64.dmg"
  name "TASTEWINM"
  desc "TASTEWINM desktop application"
  homepage "https://tastedev.net/products/winm"

  depends_on arch: :arm64
  depends_on macos: ">= :monterey"

  app "TASTEWINM.app"

  caveats <<~EOS
    This release is ad-hoc signed and is not Apple notarized.
    macOS may require Open Anyway in System Settings > Privacy & Security.
    No quarantine attributes or Gatekeeper settings are changed by this cask.
  EOS
end
