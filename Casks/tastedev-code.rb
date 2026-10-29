# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-code" do
  version "0.2.38"
  sha256 "84b67cc058d6d44dc4605608ed471ea7acf366512b694c823833817c3c72abf1"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/code-v0.2.38/tastedev-code-0.2.38-macos-arm64.dmg"
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
