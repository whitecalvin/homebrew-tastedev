# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ftp" do
  version "0.2.54"
  sha256 "3ef2f603c7aec51b3f9bc870f31352a8472d614c4a582683e5c41be3cae3e310"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ftp-v0.2.54/tastedev-ftp-0.2.54-macos-arm64.dmg"
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
