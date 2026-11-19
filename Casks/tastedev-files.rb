# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-files" do
  version "0.3.0"
  sha256 "fc2f138795024b529fbc19aa73ea49d90e472064fa18e9f25b3b54ebc42b1189"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/files-v0.3.0/tastedev-files-0.3.0-macos-arm64.dmg"
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
