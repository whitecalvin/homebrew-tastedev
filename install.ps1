[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [string[]]$Product = @(),
    [switch]$All,
    [switch]$Update,
    [switch]$List,
    [switch]$Yes,
    [switch]$Plan
)
$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'
$supportedProducts = @('cad','code','etl','files','ftp','geo','mail','remote','ssh','studio','zip')

function Resolve-TasteDevProduct([string]$Name) {
    $id = $Name.ToLowerInvariant() -replace '^tastedev-', '' -replace '^taste', ''
    if ($id -cnotin $supportedProducts) { throw "No published Windows MSI repository support for '$Name'. Use -List." }
    return $id
}
function Get-TasteDevMsiMetadata([string]$Id, $Releases) {
    $releasesArray = @($Releases)
    if ($releasesArray.Count -ne 1) { throw "No single public update for $Id." }
    $release = $releasesArray[0]
    if ($release.draft -ne $false -or $release.prerelease -ne $false) { throw 'Only published stable releases may be installed.' }
    $tagPattern = '^(?:taste)?' + [regex]::Escape($Id) + '-v(?<version>\d+\.\d+\.\d+)$'
    if ([string]$release.tag_name -cnotmatch $tagPattern) { throw 'Product release tag mismatch.' }
    $version = $Matches.version
    $pattern = '^(?:tastedev-' + [regex]::Escape($Id) + '|taste' + [regex]::Escape($Id) + ')_' + [regex]::Escape($version) + '_windows_x64\.msi$'
    $assets = @($release.assets | Where-Object { [string]$_.name -cmatch $pattern })
    if ($assets.Count -ne 1) { throw "No unique Windows x64 MSI for $Id $version." }
    $asset = $assets[0]
    if ([string]$asset.digest -cnotmatch '^sha256:[a-f0-9]{64}$' -or [long]$asset.size -le 0) { throw 'MSI digest or byte size missing.' }
    $uri = [uri]$asset.browser_download_url
    $github = "https://github.com/whitecalvin/tastedev-releases/releases/download/$($release.tag_name)/$($asset.name)"
    $repository = "https://packages.tastedev.net/windows/$Id/$version/$($asset.name)"
    if ($uri.AbsoluteUri -cne $github -and $uri.AbsoluteUri -cne $repository) { throw 'MSI URL is outside approved product release paths.' }
    return [pscustomobject]@{Id=$Id;Version=$version;Name=[string]$asset.name;Url=$uri.AbsoluteUri;Sha256=([string]$asset.digest).Substring(7);Bytes=[long]$asset.size}
}
function Assert-TasteDevFile([string]$Path, $Metadata) {
    $item = Get-Item -LiteralPath $Path -Force
    if ($item.Attributes -band [IO.FileAttributes]::ReparsePoint) { throw 'Linked installer file.' }
    if ($item.Length -ne $Metadata.Bytes -or (Get-FileHash -LiteralPath $Path -Algorithm SHA256).Hash.ToLowerInvariant() -cne $Metadata.Sha256) { throw 'MSI byte size or SHA256 mismatch.' }
    $signature = Get-AuthenticodeSignature -LiteralPath $Path
    if ($signature.Status -ne 'Valid' -or $signature.SignerCertificate.Subject -notmatch '(?:^|,\s*)O=GXSOFT(?:,|$)') { throw 'MSI Authenticode signature is not a valid GXSOFT signature.' }
}
function Get-TasteDevInstalledVersion([string]$Id) {
    $versions = @()
    foreach ($root in @('HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*','HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*','HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*')) {
        foreach ($entry in @(Get-ItemProperty -Path $root -ErrorAction SilentlyContinue)) {
            if ($entry.DisplayName -match ('^TASTE' + [regex]::Escape($Id) + '(?:\s|$)') -and [string]$entry.DisplayVersion -match '^\d+\.\d+\.\d+$') {
                $versions += [version]$entry.DisplayVersion
            }
        }
    }
    return ($versions | Sort-Object -Descending | Select-Object -First 1)
}
function Assert-TasteDevNotRunning([string]$Id) {
    $busy = @(Get-Process -Name "taste$Id","taste$Id-*" -ErrorAction SilentlyContinue)
    if ($busy.Count) { throw "$Id is running. Save your work, close its instances/services, then retry. No process was terminated." }
}
function Receive-TasteDevMsi($Metadata, [string]$Destination) {
    Add-Type -AssemblyName System.Net.Http
    $handler = [Net.Http.HttpClientHandler]::new()
    $handler.AllowAutoRedirect = $false
    $client = [Net.Http.HttpClient]::new($handler)
    $client.Timeout = [TimeSpan]::FromMinutes(20)
    $uri = [uri]$Metadata.Url
    try {
        for ($redirect = 0; $redirect -le 5; $redirect++) {
            if ($uri.Scheme -cne 'https' -or $uri.UserInfo -or $uri.Port -ne 443 -or $uri.Host -notin @('github.com','packages.tastedev.net','release-assets.githubusercontent.com','objects.githubusercontent.com')) { throw 'Untrusted MSI redirect.' }
            $response = $client.GetAsync($uri, [Net.Http.HttpCompletionOption]::ResponseHeadersRead).GetAwaiter().GetResult()
            try {
                $status = [int]$response.StatusCode
                if ($status -in @(301,302,303,307,308)) {
                    if (-not $response.Headers.Location) { throw 'MSI redirect has no destination.' }
                    $uri = [uri]::new($uri, $response.Headers.Location)
                    continue
                }
                [void]$response.EnsureSuccessStatusCode()
                $inputStream = $response.Content.ReadAsStreamAsync().GetAwaiter().GetResult()
                $outputStream = [IO.File]::Open($Destination, [IO.FileMode]::CreateNew, [IO.FileAccess]::Write, [IO.FileShare]::None)
                try {
                    $buffer = [byte[]]::new(1048576); $total = [long]0
                    while (($read = $inputStream.Read($buffer, 0, $buffer.Length)) -gt 0) {
                        $total += $read
                        if ($total -gt $Metadata.Bytes) { throw 'MSI download exceeded its published byte size.' }
                        $outputStream.Write($buffer, 0, $read)
                    }
                } finally { $outputStream.Dispose(); $inputStream.Dispose() }
                return
            } finally { $response.Dispose() }
        }
        throw 'Too many MSI redirects.'
    } finally { $client.Dispose(); $handler.Dispose() }
}

if ($List) { Write-Output "Windows x64: $($supportedProducts -join ' ')"; return }
if ($env:OS -ne 'Windows_NT') { throw 'This script requires Windows.' }
if (-not [Environment]::Is64BitOperatingSystem -or $env:PROCESSOR_ARCHITECTURE -eq 'ARM64' -or $env:PROCESSOR_ARCHITEW6432 -eq 'ARM64') { throw 'Published MSI packages require Windows x64.' }
if ($All) { $Product = $supportedProducts }
if ($Update -and -not $Product.Count) { $Product = $supportedProducts }
if (-not $Product.Count) {
    if ($Yes -or $Plan -or $WhatIfPreference) { throw 'Supply -Product or -All.' }
    Write-Output "Products: $($supportedProducts -join ' ')"
    $Product = (Read-Host 'Choose products (space or comma separated)') -split '[,\s]+' | Where-Object { $_ }
}
$selected = @($Product | ForEach-Object { Resolve-TasteDevProduct $_ } | Select-Object -Unique)
if (-not $selected.Count) { throw 'No products selected.' }
if ($Update) {
    $selected = @($selected | Where-Object { $null -ne (Get-TasteDevInstalledVersion $_) })
    if (-not $selected.Count) { Write-Output 'No installed TASTEDEV products selected for update.'; return }
}
if ($Plan) { Write-Output "Plan only: Windows x64 MSI install/update for $($selected -join ', '); no downloads or system changes."; return }
if (-not $Yes -and -not $WhatIfPreference) {
    if ((Read-Host "Install/update $($selected -join ', ')? [y/N]") -notmatch '^(?i:y|yes)$') { throw 'Installation cancelled.' }
}
# Fetch metadata for the complete selection before downloading or installing.
[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12
$metadata = @($selected | ForEach-Object {
    $id = $_
    try { $response = Invoke-RestMethod -Uri "https://tastedev.net/api/updates/$id" -UseBasicParsing }
    catch {
        if (($All -or $Update) -and $_.Exception.Response -and [int]$_.Exception.Response.StatusCode -eq 404) { Write-Warning "Skipping ${id}: no public release."; return }
        throw
    }
    if (($All -or $Update) -and (@($response).Count -eq 0 -or @($response.assets | Where-Object { $_.name -like '*_windows_x64.msi' }).Count -eq 0)) {
        Write-Warning "Skipping ${id}: no published Windows x64 MSI."
        return
    }
    Get-TasteDevMsiMetadata $id $response
})
if (-not $metadata.Count) { throw 'No published Windows MSI packages in the selection.' }
if (-not $WhatIfPreference) {
    foreach ($item in $metadata) {
        $installed = Get-TasteDevInstalledVersion $item.Id
        if ($null -eq $installed -or $installed -lt [version]$item.Version) { Assert-TasteDevNotRunning $item.Id }
    }
}
foreach ($item in $metadata) {
    if (-not $PSCmdlet.ShouldProcess("$($item.Id) $($item.Version)", 'Download verified MSI and install')) { continue }
    $installed = Get-TasteDevInstalledVersion $item.Id
    if ($null -ne $installed -and $installed -ge [version]$item.Version) {
        Write-Output "$($item.Id) $installed is already installed; keeping the current application."
        continue
    }
    Assert-TasteDevNotRunning $item.Id
    $directory = Join-Path $env:LOCALAPPDATA "TASTEDEV/Installer/$($item.Id)/$($item.Version)/$($item.Sha256)"
    for ($parent=$directory; $parent; $parent=Split-Path $parent -Parent) {
        if ((Test-Path -LiteralPath $parent) -and ((Get-Item -LiteralPath $parent -Force).Attributes -band [IO.FileAttributes]::ReparsePoint)) { throw 'Linked installer cache.' }
    }
    [void][IO.Directory]::CreateDirectory($directory)
    $msi = Join-Path $directory $item.Name
    $log = Join-Path $directory 'msiexec.log'
    if (-not (Test-Path -LiteralPath $msi)) {
        # Keep the MSI suffix so Windows uses the MSI SIP when checking Authenticode.
        $partial = Join-Path $directory ($item.Name + '.' + [guid]::NewGuid().ToString('N') + '.partial.msi')
        Receive-TasteDevMsi $item $partial
        Assert-TasteDevFile $partial $item
        Move-Item -LiteralPath $partial -Destination $msi
    }
    Assert-TasteDevFile $msi $item
    # Downloading may take minutes. Recheck before MSI can replace a running app.
    Assert-TasteDevNotRunning $item.Id
    $arguments = "/i `"$msi`" /passive /norestart REBOOT=ReallySuppress MSIRESTARTMANAGERCONTROL=Disable /L*v `"$log`""
    $process = Start-Process -FilePath (Join-Path $env:SystemRoot 'System32/msiexec.exe') -ArgumentList $arguments -WindowStyle Hidden -Wait -PassThru
    $receipt = [ordered]@{product=$item.Id;version=$item.Version;sha256=$item.Sha256;installerExitCode=$process.ExitCode;log=$log;completedAt=[DateTimeOffset]::UtcNow.ToString('o')}
    $receipt | ConvertTo-Json | Set-Content -LiteralPath (Join-Path $directory 'result.json') -Encoding UTF8
    if ($process.ExitCode -notin @(0,3010)) { throw "MSI installation failed ($($process.ExitCode)). Installer and log retained: $directory" }
    Write-Output "$($item.Id) $($item.Version) installed. Log: $log"
    if ($process.ExitCode -eq 3010) { Write-Output 'Windows reports that a restart is required. No automatic restart was performed.' }
}
