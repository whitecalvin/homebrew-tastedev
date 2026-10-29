# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-remote" do
  version "0.2.4"
  sha256 "df8966c1d9767694eb3a43d28b0b97d1b830396739125dd5ad244ba1ac48f18f"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/remote-v0.2.4/tastedev-remote-0.2.4-macos-arm64.dmg"
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
