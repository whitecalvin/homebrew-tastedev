# TASTEDEV Homebrew tap

```sh
brew tap whitecalvin/tastedev
brew install --cask whitecalvin/tastedev/tastedev-files
```

macOS Apple Silicon DMG packages with immutable SHA256 checksums. Browse Casks/ for the current packages.

See https://tastedev.net for product documentation.

## One-line installer

macOS / Linux:

```sh
curl -fsSL https://packages.tastedev.net/install.sh | sh
```

Windows PowerShell:

```powershell
irm https://packages.tastedev.net/install.ps1 | iex
```

Run the same command again to update selected installed products. Use --update --yes (Unix) or -Update -Yes (PowerShell) to update installed products only. Running apps/services must be closed normally first. Homebrew is bootstrapped from its official installer when needed. Linux uses signed APT/RPM repositories; Windows verifies the MSI digest and GXSOFT Authenticode signature. No force-close, reboot, Gatekeeper bypass, or data removal is performed.
