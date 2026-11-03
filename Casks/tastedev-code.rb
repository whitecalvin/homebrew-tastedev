# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-code" do
  version "0.2.42"
  sha256 "8268a423ddaaab566a621e406a7fb3d78bb509ee4d588889e4228847900b24ce"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/code-v0.2.42/tastedev-code-0.2.42-macos-arm64.dmg"
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
