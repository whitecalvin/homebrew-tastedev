# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-code" do
  version "0.2.39"
  sha256 "06a0bde8ac5fc4b9176bf0c1bfee2269b604c79c5cd83e33ed493ffe63a8c7b7"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/code-v0.2.39/tastedev-code-0.2.39-macos-arm64.dmg"
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
