# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-code" do
  version "0.2.43"
  sha256 "301f6b165a577a707f48d1c9257ce1ad07f3681fd02e014ae8cf0051793673a2"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/code-v0.2.43/tastedev-code-0.2.43-macos-arm64.dmg"
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
