# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-cad" do
  version "0.2.35"
  sha256 "3f1417be06825c2754b6beb9c2e657f93b9498f4486c0b76c396c3d6fb77f5d6"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/cad-v0.2.35/tastedev-cad-0.2.35-macos-arm64.dmg"
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
