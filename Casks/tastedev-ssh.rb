# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ssh" do
  version "0.3.21"
  sha256 "0b721ce6b307143dbd0f606dbc0849d0ce2cf033a817990c34a117bf185f9198"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ssh-v0.3.21/tastedev-ssh-0.3.21-macos-arm64.dmg"
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
