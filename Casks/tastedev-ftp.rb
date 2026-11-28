# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ftp" do
  version "0.3.16"
  sha256 "4a3b1339a44a2c997e869dfc69d4dad89b71f5934c7a0aa5f91500cbaedf5d90"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ftp-v0.3.16/tastedev-ftp-0.3.16-macos-arm64.dmg"
  name "TASTEFTP"
  desc "TASTEFTP desktop application"
  homepage "https://tastedev.net/products/ftp"

  depends_on arch: :arm64
  depends_on macos: ">= :monterey"

  app "TASTEFTP.app"

  caveats <<~EOS
    This release is ad-hoc signed and is not Apple notarized.
    macOS may require Open Anyway in System Settings > Privacy & Security.
    No quarantine attributes or Gatekeeper settings are changed by this cask.
  EOS
end
