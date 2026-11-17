# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-files" do
  version "0.2.53"
  sha256 "03180dd1f12f32bbb000bf5a91dcd9ebfadec56a85435895860aa223753a78c5"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/files-v0.2.53/tastedev-files-0.2.53-macos-arm64.dmg"
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
