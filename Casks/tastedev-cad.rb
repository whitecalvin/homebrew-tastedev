# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-cad" do
  version "0.3.5"
  sha256 "2b3f1f4de67ff4abd43f489db6a4d03604a00ccc2ea5001bd5e7844adae3a740"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/cad-v0.3.5/tastedev-cad-0.3.5-macos-arm64.dmg"
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
