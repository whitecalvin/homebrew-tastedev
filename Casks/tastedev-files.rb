# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-files" do
  version "0.2.35"
  sha256 "dc8c9eac73ef11f972ecbb6ab15926507b24f8ed86ba846d8da3be8b1398d898"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/files-v0.2.35/tastedev-files-0.2.35-macos-arm64.dmg"
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
