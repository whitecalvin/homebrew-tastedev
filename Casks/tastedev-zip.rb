# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-zip" do
  version "0.2.42"
  sha256 "e878b772573a6e6aa0ee8e08a559a57bb35848d6bfda8b8f4bd872c55adbb67e"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/zip-v0.2.42/tastedev-zip-0.2.42-macos-arm64.dmg"
  name "TASTEZIP"
  desc "TASTEZIP desktop application"
  homepage "https://tastedev.net/products/zip"

  depends_on arch: :arm64
  depends_on macos: ">= :monterey"

  app "TASTEZIP.app"

  caveats <<~EOS
    This release is ad-hoc signed and is not Apple notarized.
    macOS may require Open Anyway in System Settings > Privacy & Security.
    No quarantine attributes or Gatekeeper settings are changed by this cask.
  EOS
end
