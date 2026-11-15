# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ftp" do
  version "0.3.6"
  sha256 "31d28bbf4bb478d177eab9c91547c78c5f78bb9a0d4905c13bc5d6f377952255"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ftp-v0.3.6/tastedev-ftp-0.3.6-macos-arm64.dmg"
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
