# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-files" do
  version "0.3.4"
  sha256 "6d0aa5821526ee81ecd8e950926991bebe40fdb10e23d4843a9e703b27b22854"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/files-v0.3.4/tastedev-files-0.3.4-macos-arm64.dmg"
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
