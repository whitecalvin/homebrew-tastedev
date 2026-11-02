# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-zip" do
  version "0.2.31"
  sha256 "0ca748490aa0d7b56727bda41d814d58fe8889d44e498abed3e56f2fc5644f0f"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/zip-v0.2.31/tastedev-zip-0.2.31-macos-arm64.dmg"
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
