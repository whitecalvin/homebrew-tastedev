# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-zip" do
  version "0.2.43"
  sha256 "e85537e6afb6d18e86ef94823548f7418fa3bf8d9e3adb7d9db068a4f0ed99f1"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/zip-v0.2.43/tastedev-zip-0.2.43-macos-arm64.dmg"
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
