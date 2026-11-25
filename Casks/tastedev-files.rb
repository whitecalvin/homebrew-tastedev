# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-files" do
  version "0.3.7"
  sha256 "1f4f3d3451251594819416beef747379045661a725dd7bd8f19256fe0957d433"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/files-v0.3.7/tastedev-files-0.3.7-macos-arm64.dmg"
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
