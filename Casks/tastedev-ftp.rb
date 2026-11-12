# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ftp" do
  version "0.3.4"
  sha256 "12f2c08ce307a83426d963245e40a41e75e9bcf1c26a09d035ef8dd39ed378cf"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ftp-v0.3.4/tastedev-ftp-0.3.4-macos-arm64.dmg"
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
