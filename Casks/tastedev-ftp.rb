# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ftp" do
  version "0.3.15"
  sha256 "b7a6ff3e3b1cc15177c3ce738f2b70cf8d7503b74f0a502c111a2459699749c6"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ftp-v0.3.15/tastedev-ftp-0.3.15-macos-arm64.dmg"
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
