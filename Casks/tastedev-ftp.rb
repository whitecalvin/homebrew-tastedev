# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ftp" do
  version "0.2.64"
  sha256 "9794b5f4483666fead8bb33172731bb289ac83309a51d94ada27bab2afe2e724"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ftp-v0.2.64/tastedev-ftp-0.2.64-macos-arm64.dmg"
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
