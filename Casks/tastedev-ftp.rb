# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ftp" do
  version "0.3.14"
  sha256 "b5a3e9272c94b04812628ceb588b61c8a473414cf5146d1e9402ee98ab5d9926"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ftp-v0.3.14/tastedev-ftp-0.3.14-macos-arm64.dmg"
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
