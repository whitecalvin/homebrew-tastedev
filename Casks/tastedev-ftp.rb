# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ftp" do
  version "0.2.57"
  sha256 "6fe98fd3a8e1eefe807dc99bafc0e6f25e83b30a7b19a15860a7a0d245268f71"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ftp-v0.2.57/tastedev-ftp-0.2.57-macos-arm64.dmg"
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
