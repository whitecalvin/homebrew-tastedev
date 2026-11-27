# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-remote" do
  version "0.3.27"
  sha256 "ff031a65760edc73092af6d40167ba04c7f7c45c6fa4c119d5fb98701f1939e5"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/remote-v0.3.27/tastedev-remote-0.3.27-macos-arm64.dmg"
  name "TASTEREMOTE"
  desc "TASTEREMOTE desktop application"
  homepage "https://tastedev.net/products/remote"

  depends_on arch: :arm64
  depends_on macos: ">= :ventura"

  app "TASTEREMOTE.app"

  caveats <<~EOS
    This release is ad-hoc signed and is not Apple notarized.
    macOS may require Open Anyway in System Settings > Privacy & Security.
    No quarantine attributes or Gatekeeper settings are changed by this cask.
  EOS
end
