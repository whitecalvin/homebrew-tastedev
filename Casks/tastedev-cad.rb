# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-cad" do
  version "0.2.28"
  sha256 "ec58ab43b074ef2697721544691a7abd3aaf8823e6a6548dc10c45ee0bf6c035"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/cad-v0.2.28/tastedev-cad-0.2.28-macos-arm64.dmg"
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
