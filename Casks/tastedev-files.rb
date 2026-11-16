# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-files" do
  version "0.2.49"
  sha256 "be9e6866ab3835be75940f5326de21ad0c61f7a95b0775177f7c4cf1199f386f"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/files-v0.2.49/tastedev-files-0.2.49-macos-arm64.dmg"
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
