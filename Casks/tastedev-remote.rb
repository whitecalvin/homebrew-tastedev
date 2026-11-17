# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-remote" do
  version "0.3.18"
  sha256 "d8e1552d3bc49ac97063fe099d59e0e5309b9aab3fd2cac7e1e4ab443bd027af"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/remote-v0.3.18/tastedev-remote-0.3.18-macos-arm64.dmg"
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
