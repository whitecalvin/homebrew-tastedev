# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-files" do
  version "0.2.44"
  sha256 "7d1e7224894e621be8168a2a3b96508983e9db27909720fb12666695c1a1cc7b"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/files-v0.2.44/tastedev-files-0.2.44-macos-arm64.dmg"
  name "TASTEFILES"
  desc "TASTEFILES desktop application"
  homepage "https://tastedev.net/products/files"

  depends_on arch: :arm64
  depends_on macos: ">= :monterey"

  app "TASTEFILES.app"

  caveats <<~EOS
    This release is ad-hoc signed and is not Apple notarized.
    macOS may require Open Anyway in System Settings > Privacy & Security.
    No quarantine attributes or Gatekeeper settings are changed by this cask.
  EOS
end
