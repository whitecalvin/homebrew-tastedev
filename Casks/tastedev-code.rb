# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-code" do
  version "0.2.40"
  sha256 "86810ac5f005be1397389e58812927ec4203050e2a8872817e46c8bb7644c6b1"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/code-v0.2.40/tastedev-code-0.2.40-macos-arm64.dmg"
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
