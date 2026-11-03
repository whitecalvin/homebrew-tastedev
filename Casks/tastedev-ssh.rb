# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ssh" do
  version "0.2.76"
  sha256 "869d22ce46f6aef1999af3b3778fcc47a1ca1cce97ae78c15c2adaec43ca8639"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ssh-v0.2.76/tastedev-ssh-0.2.76-macos-arm64.dmg"
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
