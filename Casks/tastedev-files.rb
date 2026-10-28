# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-files" do
  version "0.2.31"
  sha256 "9116a781fb6f10a39f3fae9185f6df1a9d940cc4e99e2394f4b6e1ddeb265469"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/files-v0.2.31/tastedev-files-0.2.31-macos-arm64.dmg"
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
