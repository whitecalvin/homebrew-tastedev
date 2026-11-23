# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ssh" do
  version "0.3.26"
  sha256 "6aec03ca141504ac5e66e6c96f93dcab6f4ce6142d3fb6f3f50dac297ed2408a"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ssh-v0.3.26/tastedev-ssh-0.3.26-macos-arm64.dmg"
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
