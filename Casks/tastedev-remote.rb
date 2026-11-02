# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-remote" do
  version "0.2.14"
  sha256 "b8b8a574691f457c5905be4115c4fa65bb328e6b44796b8216a4de265afdfb8c"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/remote-v0.2.14/tastedev-remote-0.2.14-macos-arm64.dmg"
  name "TASTEREMOTE"
  desc "TASTEREMOTE desktop application"
  homepage "https://tastedev.net/products/remote"

  depends_on arch: :arm64
  depends_on macos: ">= :ventura"

  app "TASTEREMOTE.app"

  caveats <<~EOS
    This release is ad-hoc signed and is not Apple notarized.
    macOS may require Open Anyway in System Settings > Privacy & Security.
    No quarantine attributes or Gatekeeper settings are changed by this cask.
  EOS
end
