# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-code" do
  version "0.2.41"
  sha256 "7ffe7f52a5fe2db927f9d6a8d62cf2dabefade101b5fd111aadebfbfc858a973"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/code-v0.2.41/tastedev-code-0.2.41-macos-arm64.dmg"
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
