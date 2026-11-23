# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-files" do
  version "0.3.6"
  sha256 "552fb6f127e3b24674f1b064a2f04484d8b18a2b86b06cc7148452006b3adc73"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/files-v0.3.6/tastedev-files-0.3.6-macos-arm64.dmg"
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
