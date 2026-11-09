# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-files" do
  version "0.2.43"
  sha256 "a525fbe8b9d3d3fc56afb587e4e99e40ac6db6cd3c896800152119f882b7b8cd"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/files-v0.2.43/tastedev-files-0.2.43-macos-arm64.dmg"
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
