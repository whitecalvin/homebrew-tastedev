# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ssh" do
  version "0.2.66"
  sha256 "ac406a2f5be8bf9d5390779193c60456655afcd76ab14120f767513630d6cfdd"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ssh-v0.2.66/tastedev-ssh-0.2.66-macos-arm64.dmg"
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
