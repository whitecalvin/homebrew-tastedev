# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-files" do
  version "0.2.41"
  sha256 "d55fde16ba7ef6b0b448d5f819499596e05d72133035925bb630757f1a0c0f47"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/files-v0.2.41/tastedev-files-0.2.41-macos-arm64.dmg"
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
