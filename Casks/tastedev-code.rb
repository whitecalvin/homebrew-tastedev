# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-code" do
  version "0.2.46"
  sha256 "965cf1c5352e70e02ab26e2816e0db21426103ca29b5d8b6ccce287eff8ba841"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/code-v0.2.46/tastedev-code-0.2.46-macos-arm64.dmg"
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
