# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ssh" do
  version "0.3.3"
  sha256 "e9ff953cfca5da4428ca03a864e692d145d64edc21dd2f706c54b51a2306dea8"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ssh-v0.3.3/tastedev-ssh-0.3.3-macos-arm64.dmg"
  name "TASTESSH"
  desc "TASTESSH desktop application"
  homepage "https://tastedev.net/products/ssh"

  depends_on arch: :arm64
  depends_on macos: ">= :monterey"

  app "TASTESSH.app"

  caveats <<~EOS
    This release is ad-hoc signed and is not Apple notarized.
    macOS may require Open Anyway in System Settings > Privacy & Security.
    No quarantine attributes or Gatekeeper settings are changed by this cask.
  EOS
end
