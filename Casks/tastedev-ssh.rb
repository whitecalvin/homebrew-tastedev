# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ssh" do
  version "0.3.6"
  sha256 "1a72a32104810ab2c1fd92e9485c4eca7c50a69b72e4d08c2856bfe13c970dc0"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ssh-v0.3.6/tastedev-ssh-0.3.6-macos-arm64.dmg"
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
