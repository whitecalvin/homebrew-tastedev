# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ftp" do
  version "0.2.51"
  sha256 "3cdc06487deac5a6c7b7cc2ea76514f0c47aee176450b9fc93f1b16f7c0c2bd9"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ftp-v0.2.51/tastedev-ftp-0.2.51-macos-arm64.dmg"
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
