# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-zip" do
  version "0.2.30"
  sha256 "1bb0454f650c53fc43e17cdf28b17b528187c3c253a8e5214765dcf0d7ce9a98"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/zip-v0.2.30/tastedev-zip-0.2.30-macos-arm64.dmg"
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
