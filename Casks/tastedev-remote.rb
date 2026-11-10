# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-remote" do
  version "0.3.5"
  sha256 "cccaeb8a69b2b5d51e8ee2abc43d6779cb10806650396f6ade29e797852daa1a"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/remote-v0.3.5/tastedev-remote-0.3.5-macos-arm64.dmg"
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
