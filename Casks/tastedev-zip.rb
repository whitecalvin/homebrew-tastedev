# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-zip" do
  version "0.2.37"
  sha256 "6f11dbf0740b2a077128f3eebdb96108ee3983d3fee5ec3d5b88f21aad265e28"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/zip-v0.2.37/tastedev-zip-0.2.37-macos-arm64.dmg"
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
