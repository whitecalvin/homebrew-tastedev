# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-files" do
  version "0.2.36"
  sha256 "9cbef87a70d6d4092a3c3f08d83eaf1ac7133c133c8b3ba876be1dc14d0daffc"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/files-v0.2.36/tastedev-files-0.2.36-macos-arm64.dmg"
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
