# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-cad" do
  version "0.3.4"
  sha256 "41822eab92db0270455d3681fb5f652f92f9914ac8ade1f554790952cc33761c"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/cad-v0.3.4/tastedev-cad-0.3.4-macos-arm64.dmg"
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
