# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ssh" do
  version "0.2.82"
  sha256 "030e8eb4d573d8c4c7e14bf51e1557301960283f1ff2eca4e21d6366e4e53ec1"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ssh-v0.2.82/tastedev-ssh-0.2.82-macos-arm64.dmg"
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
