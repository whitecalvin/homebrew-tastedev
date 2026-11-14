# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-remote" do
  version "0.3.12"
  sha256 "bff4f2b9c712138541f2f89c16418e9dbec463db436d24e94889db1857ba7236"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/remote-v0.3.12/tastedev-remote-0.3.12-macos-arm64.dmg"
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
