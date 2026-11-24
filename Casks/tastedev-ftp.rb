# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ftp" do
  version "0.3.12"
  sha256 "b1c757574d9adc0e5e77f306eed7ea6b780e4a8e013eb521386c8665b36a512e"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ftp-v0.3.12/tastedev-ftp-0.3.12-macos-arm64.dmg"
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
