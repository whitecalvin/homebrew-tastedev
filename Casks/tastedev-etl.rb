# Generated from an existing public DMG; do not edit hashes manually.
cask "tastedev-etl" do
  version "0.2.24"
  sha256 "150d592b91c8fe61b0b0a345e3604dc14c9cc83c9ff4afe6f928c5bbb2896442"

  url "https://github.com/whitecalvin/tastedev-releases/releases/download/etl-v0.2.24/tastedev-etl-0.2.24-macos-arm64.dmg"
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
