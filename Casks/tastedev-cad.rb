# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-cad" do
  version "0.2.32"
  sha256 "3eb511c75f5a2b1050b1dc04edd50b79fc139c4bd951ff4d4b7486a695a69f08"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/cad-v0.2.32/tastedev-cad-0.2.32-macos-arm64.dmg"
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
