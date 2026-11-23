# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ftp" do
  version "0.3.11"
  sha256 "f6e6b9209d15705a60391e1f76f6363e75512c6e84dab94d7c06f46d6f06b289"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ftp-v0.3.11/tastedev-ftp-0.3.11-macos-arm64.dmg"
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
