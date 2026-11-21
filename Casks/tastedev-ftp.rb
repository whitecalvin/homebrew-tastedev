# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ftp" do
  version "0.3.9"
  sha256 "d0c29fcbebfc0e70a4bac36b8f4f0d816439a1a48529bfe0d26dece6be40a252"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ftp-v0.3.9/tastedev-ftp-0.3.9-macos-arm64.dmg"
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
