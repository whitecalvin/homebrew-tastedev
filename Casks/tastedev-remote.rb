# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-remote" do
  version "0.2.22"
  sha256 "f6bad0957a76d35b9d9bb5e08712a9232e191269cf0b02293788fe42f9f364b0"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/remote-v0.2.22/tastedev-remote-0.2.22-macos-arm64.dmg"
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
