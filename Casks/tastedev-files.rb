# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-files" do
  version "0.2.40"
  sha256 "cb641067673c26ae5a98361999e939bac48a766403dc77f9ebbb460fc49fea7b"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/files-v0.2.40/tastedev-files-0.2.40-macos-arm64.dmg"
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
