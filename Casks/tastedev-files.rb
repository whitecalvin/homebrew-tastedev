# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-files" do
  version "0.2.38"
  sha256 "7f4f9cacb9f3af4fb22871e0ffbba802c7bb2cf117c690c0ddb005d3a5abe10b"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/files-v0.2.38/tastedev-files-0.2.38-macos-arm64.dmg"
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
