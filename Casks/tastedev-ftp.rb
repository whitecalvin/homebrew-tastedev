# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ftp" do
  version "0.2.66"
  sha256 "91216c0a342db28485345cb2fb3fb02bef90823ac1265eb780d72ec7e9e6e6d6"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ftp-v0.2.66/tastedev-ftp-0.2.66-macos-arm64.dmg"
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
