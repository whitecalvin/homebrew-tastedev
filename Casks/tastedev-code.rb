# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-code" do
  version "0.2.44"
  sha256 "018d0cf2616a9848e87992f73ffa0a25a8fd6712708fa8f79c520a4957ba6fb3"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/code-v0.2.44/tastedev-code-0.2.44-macos-arm64.dmg"
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
