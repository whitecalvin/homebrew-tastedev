# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-files" do
  version "0.2.54"
  sha256 "e219538840b2748bbf746e38aec55951145b520089130f0827ae2ca2471f9643"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/files-v0.2.54/tastedev-files-0.2.54-macos-arm64.dmg"
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
