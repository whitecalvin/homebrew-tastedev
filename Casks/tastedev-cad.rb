# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-cad" do
  version "0.2.34"
  sha256 "afd0c0c1f874a7ad85c2e97a295f51dcbc98f0f1c59e1daeee38e945327af50f"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/cad-v0.2.34/tastedev-cad-0.2.34-macos-arm64.dmg"
  name "TASTECAD"
  desc "TASTECAD desktop application"
  homepage "https://tastedev.net/products/cad"

  depends_on arch: :arm64
  depends_on macos: ">= :monterey"

  app "TASTECAD.app"

  caveats <<~EOS
    This release is ad-hoc signed and is not Apple notarized.
    macOS may require Open Anyway in System Settings > Privacy & Security.
    No quarantine attributes or Gatekeeper settings are changed by this cask.
  EOS
end
