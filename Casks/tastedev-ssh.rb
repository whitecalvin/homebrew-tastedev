# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ssh" do
  version "0.3.0"
  sha256 "03f67eee0addf35d354f83b9095cc2690df9e0b35aaefd3243b8e193b0b3200e"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ssh-v0.3.0/tastedev-ssh-0.3.0-macos-arm64.dmg"
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
