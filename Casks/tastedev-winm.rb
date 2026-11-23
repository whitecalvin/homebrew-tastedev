# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-winm" do
  version "0.1.4"
  sha256 "a452c995a755e2d1a359b515e31f6cf1fd0332d37f73fe35b907cc4620b91a3f"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/winm-v0.1.4/tastedev-winm-0.1.4-macos-arm64.dmg"
  name "TASTEWINM"
  desc "TASTEWINM desktop application"
  homepage "https://tastedev.net/products/winm"

  depends_on arch: :arm64
  depends_on macos: ">= :monterey"

  app "TASTEWINM.app"

  caveats <<~EOS
    This release is ad-hoc signed and is not Apple notarized.
    macOS may require Open Anyway in System Settings > Privacy & Security.
    No quarantine attributes or Gatekeeper settings are changed by this cask.
  EOS
end
