# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-files" do
  version "0.3.1"
  sha256 "7668c59ea20165db4270e82365c276558be873a0e5836e4788ded1da1f6da62b"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/files-v0.3.1/tastedev-files-0.3.1-macos-arm64.dmg"
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
