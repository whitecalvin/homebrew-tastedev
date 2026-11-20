# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-ssh" do
  version "0.3.22"
  sha256 "94e3b33ee1f04dfefa91c93f57f1bc47fdd9f84b93174f248a011a7b61add85e"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/ssh-v0.3.22/tastedev-ssh-0.3.22-macos-arm64.dmg"
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
