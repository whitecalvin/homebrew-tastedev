# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-winm" do
  version "0.1.16"
  sha256 "812e92ccad6b6a3bb2206a8bc890dc5e6e5bc57a761d625fbee6090623f40e74"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/winm-v0.1.16/tastedev-winm-0.1.16-macos-arm64.dmg"
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
