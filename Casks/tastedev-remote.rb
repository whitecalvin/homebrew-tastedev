# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-remote" do
  version "0.3.23"
  sha256 "51020997d659a9c1b2ce00c2c9cb229da6df860e53f4312ad11386659264ebb7"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/remote-v0.3.23/tastedev-remote-0.3.23-macos-arm64.dmg"
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
