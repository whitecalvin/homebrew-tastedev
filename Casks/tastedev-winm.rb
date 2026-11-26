# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-winm" do
  version "0.1.17"
  sha256 "ed111123e0e47424000e5c6456baf4dee246495c157790d6880cbad895b3098b"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/winm-v0.1.17/tastedev-winm-0.1.17-macos-arm64.dmg"
  name "TASTEWINM"
  desc "TASTEWINM desktop application"
  homepage "https://tastedev.net/products/winm"

  depends_on arch: :arm64
  depends_on macos: ">= :monterey"

  app "TASTEWINM.app"

  caveats <<~EOS
    This release is ad-hoc signed and is not Apple notarized.
    macOS may require Open Anyway in System Settings > Privacy & Security.
    No quarantine attributes or Gatekeeper settings are changed by this cask.
  EOS
end
