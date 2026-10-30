# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ftp" do
  version "0.2.52"
  sha256 "3f7d48c5e0755e5dc1bc43ab89e08905f0683437f0c859c99a5aa0ec17dd4752"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ftp-v0.2.52/tastedev-ftp-0.2.52-macos-arm64.dmg"
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
