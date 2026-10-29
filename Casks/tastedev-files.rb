# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-files" do
  version "0.2.32"
  sha256 "a6d59c0ded66be716d9a8a4e5586ae49cb85138bd883edb45fab504bcb61d739"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/files-v0.2.32/tastedev-files-0.2.32-macos-arm64.dmg"
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
