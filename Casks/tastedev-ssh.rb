# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ssh" do
  version "0.2.70"
  sha256 "fc086ace63fa4b09116bdc32e72536634d9e5a8adcf0ebc8c07e653b4a31daad"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ssh-v0.2.70/tastedev-ssh-0.2.70-macos-arm64.dmg"
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
