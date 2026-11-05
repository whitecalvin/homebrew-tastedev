# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ftp" do
  version "0.2.63"
  sha256 "2d5e251c1958eae2e0180e61341505e46f491a3dea6a421ae9e2f06b4a7f60ae"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ftp-v0.2.63/tastedev-ftp-0.2.63-macos-arm64.dmg"
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
