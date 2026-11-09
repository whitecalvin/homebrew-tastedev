# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ftp" do
  version "0.3.1"
  sha256 "e4dd4bac24dde2f5027f51cb7ca7ddb9498685f6255d9c75bb65884ea7046efc"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ftp-v0.3.1/tastedev-ftp-0.3.1-macos-arm64.dmg"
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
