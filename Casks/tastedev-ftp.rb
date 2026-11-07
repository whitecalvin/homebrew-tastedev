# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ftp" do
  version "0.2.65"
  sha256 "28964cf59209e0a173e0b0bf99cb39be6c6265aa3b6c96a6c81154722d0ed36f"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ftp-v0.2.65/tastedev-ftp-0.2.65-macos-arm64.dmg"
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
