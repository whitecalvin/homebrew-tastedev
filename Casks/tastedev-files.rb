# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-files" do
  version "0.2.51"
  sha256 "170bdb7028f2e73f6ae393dc7067518e740f026959f8276e9d6257a4d50fe36e"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/files-v0.2.51/tastedev-files-0.2.51-macos-arm64.dmg"
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
