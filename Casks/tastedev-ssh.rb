# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ssh" do
  version "0.3.1"
  sha256 "75b1a3d865ccd99a3efb37641e5e7c1ac13861e4a229c823a1de9134fad9cdc7"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ssh-v0.3.1/tastedev-ssh-0.3.1-macos-arm64.dmg"
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
