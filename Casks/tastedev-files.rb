# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-files" do
  version "0.2.34"
  sha256 "9342a755ac9fdcc6b0c9dd12d0ba229540f01e78679b25a973dc71fbae7a181b"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/files-v0.2.34/tastedev-files-0.2.34-macos-arm64.dmg"
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
