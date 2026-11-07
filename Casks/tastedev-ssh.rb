# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ssh" do
  version "0.2.81"
  sha256 "5429cacb9f72baa57e4a755ff80d9c750c7258150d9ae3c12cdef6a3fc739f1c"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ssh-v0.2.81/tastedev-ssh-0.2.81-macos-arm64.dmg"
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
