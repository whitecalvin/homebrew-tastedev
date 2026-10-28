# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-code" do
  version "0.2.37"
  sha256 "ec7a61fa9a642acb3aa22c11493272befbb3a891403166f75e270005fdbd1917"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/code-v0.2.37/tastedev-code-0.2.37-macos-arm64.dmg"
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
