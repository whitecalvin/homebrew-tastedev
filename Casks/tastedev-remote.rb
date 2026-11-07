# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-remote" do
  version "0.2.25"
  sha256 "3a1dfafd6ba9c1d14e09cde7923115dcae5b7eac4286ab2ebfb8394b8d5f63c6"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/remote-v0.2.25/tastedev-remote-0.2.25-macos-arm64.dmg"
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
