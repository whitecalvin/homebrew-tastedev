# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-remote" do
  version "0.2.18"
  sha256 "3534b7be4167388bd4f4f02f04b7b099f6ce00bbb62f2d79f739c2e41b585a7b"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/remote-v0.2.18/tastedev-remote-0.2.18-macos-arm64.dmg"
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
