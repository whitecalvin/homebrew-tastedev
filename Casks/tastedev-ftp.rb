# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ftp" do
  version "0.3.5"
  sha256 "fcccf6eaefe2e6370b4273e236725de8a0c460f39d3b19685f62bfee677212ca"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ftp-v0.3.5/tastedev-ftp-0.3.5-macos-arm64.dmg"
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
