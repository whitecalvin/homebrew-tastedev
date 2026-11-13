# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-files" do
  version "0.2.47"
  sha256 "79a917a38928e0b63f9999aef304867e32e9b6ce92f7c0afb32da2435229c852"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/files-v0.2.47/tastedev-files-0.2.47-macos-arm64.dmg"
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
