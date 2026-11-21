# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-code" do
  version "0.2.45"
  sha256 "a59ee88c43634230049f4b6cca0bf323833514bc20fc454c77cc9a5c16cda623"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/code-v0.2.45/tastedev-code-0.2.45-macos-arm64.dmg"
  name "TASTECODE"
  desc "TASTECODE desktop application"
  homepage "https://tastedev.net/products/code"

  depends_on arch: :arm64
  depends_on macos: ">= :monterey"

  app "TASTECODE.app"

  caveats <<~EOS
    This release is ad-hoc signed and is not Apple notarized.
    macOS may require Open Anyway in System Settings > Privacy & Security.
    No quarantine attributes or Gatekeeper settings are changed by this cask.
  EOS
end
