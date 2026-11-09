# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-files" do
  version "0.2.42"
  sha256 "0c5d38b4e3f9e8532067c34f99948a33c6481cdfc7ef068334e13556e4a79ec8"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/files-v0.2.42/tastedev-files-0.2.42-macos-arm64.dmg"
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
