# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-files" do
  version "0.3.5"
  sha256 "b45edab28419b13654bbc1f677da597ac19a1f5fb9f527c5f792eea5fa5f8a76"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/files-v0.3.5/tastedev-files-0.3.5-macos-arm64.dmg"
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
