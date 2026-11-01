# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ftp" do
  version "0.2.56"
  sha256 "c03a2fc5f7dca5b6d6e2faaf5994cdebbf3765cb99dec96e272318694135e5b6"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ftp-v0.2.56/tastedev-ftp-0.2.56-macos-arm64.dmg"
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
