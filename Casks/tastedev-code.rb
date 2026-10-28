# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-code" do
  version "0.2.36"
  sha256 "fe7fb5658c3e6b0e10064d4d7d623c83eea3e3cadf1d6e8b328c747e125b1364"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/code-v0.2.36/tastedev-code-0.2.36-macos-arm64.dmg"
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
