# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-files" do
  version "0.3.10"
  sha256 "9ed6e4f2eacf6f77dc6ad04c2a085408f31283d4d6b27f83743a0b0c785b4de0"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/files-v0.3.10/tastedev-files-0.3.10-macos-arm64.dmg"
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
