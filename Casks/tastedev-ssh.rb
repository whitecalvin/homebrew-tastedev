# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ssh" do
  version "0.3.19"
  sha256 "12ca18cf1ce3291a9b2f0096839bee0445147cb23576df7dbb98e08bb078a6a2"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ssh-v0.3.19/tastedev-ssh-0.3.19-macos-arm64.dmg"
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
