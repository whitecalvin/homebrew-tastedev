# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-files" do
  version "0.3.9"
  sha256 "d166630d971cce044290e09a5825f8ad26c32f17dcd14df3083e81d3c3db75b0"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/files-v0.3.9/tastedev-files-0.3.9-macos-arm64.dmg"
  name "TASTEFILES"
  desc "TASTEFILES desktop application"
  homepage "https://tastedev.net/products/files"

  depends_on arch: :arm64
  depends_on macos: ">= :monterey"

  app "TASTEFILES.app"

  caveats <<~EOS
    This release is ad-hoc signed and is not Apple notarized.
    macOS may require Open Anyway in System Settings > Privacy & Security.
    No quarantine attributes or Gatekeeper settings are changed by this cask.
  EOS
end
