# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ftp" do
  version "0.2.58"
  sha256 "ba83e5662de2ab0b16880cfd4fb104ab135c62bf86dac7506e5c63c26775c255"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ftp-v0.2.58/tastedev-ftp-0.2.58-macos-arm64.dmg"
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
