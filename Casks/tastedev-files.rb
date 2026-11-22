# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-files" do
  version "0.3.2"
  sha256 "b30d5c802dac40eda3ea75b759872d3ddb0b49aedadbc36492f71fc32ddb693e"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/files-v0.3.2/tastedev-files-0.3.2-macos-arm64.dmg"
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
