# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-etl" do
  version "0.2.26"
  sha256 "9747bc7b6fb066b0b8fbcb7add612010a754d59d4f87a95ae2cfb9a9a5d2d99a"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/etl-v0.2.26/tastedev-etl-0.2.26-macos-arm64.dmg"
  name "TASTEETL"
  desc "TASTEETL desktop application"
  homepage "https://tastedev.net/products/etl"

  depends_on arch: :arm64
  depends_on macos: ">= :sonoma"

  app "TASTEETL.app"
  binary "#{appdir}/TASTEETL.app/Contents/MacOS/tasteetl-cli"

  caveats <<~EOS
    This release is ad-hoc signed and is not Apple notarized.
    macOS may require Open Anyway in System Settings > Privacy & Security.
    No quarantine attributes or Gatekeeper settings are changed by this cask.
  EOS
end
