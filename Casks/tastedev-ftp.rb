# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ftp" do
  version "0.3.10"
  sha256 "53e6db8a0c6345ac2f7e2a9a3e9451c7c754a9d16e0deb0b8df20af49a18717b"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ftp-v0.3.10/tastedev-ftp-0.3.10-macos-arm64.dmg"
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
