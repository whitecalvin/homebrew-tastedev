# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ftp" do
  version "0.2.60"
  sha256 "bdfeeb1c0302121e1dda1f95434cbcb64f35b6fc991718cc3017ca048d73370a"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ftp-v0.2.60/tastedev-ftp-0.2.60-macos-arm64.dmg"
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
