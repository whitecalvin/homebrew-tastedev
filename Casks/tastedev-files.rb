# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-files" do
  version "0.2.39"
  sha256 "0a3b6d80742b6a6d3b3ce3733d1ea3a270816b5354e494b85a83fbf719238bc7"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/files-v0.2.39/tastedev-files-0.2.39-macos-arm64.dmg"
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
