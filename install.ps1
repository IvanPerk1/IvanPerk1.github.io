Write-Host ""
Write-Host "  Wake PC Agent - Installer" -ForegroundColor Cyan
Write-Host "  wakepc.app" -ForegroundColor DarkGray
Write-Host ""

$url = "https://github.com/IvanPerk1/IvanPerk1.github.io/releases/download/v2.2/WakePCAgentSetup.exe"
$output = "$env:USERPROFILE\Desktop\WakePCAgentSetup.exe"

Write-Host "  Downloading WakePCAgentSetup.exe..." -ForegroundColor Yellow

try {
    Invoke-WebRequest -Uri $url -OutFile $output -UseBasicParsing
} catch {
    Write-Host "  Download failed. Check your internet connection." -ForegroundColor Red
    Write-Host ""
    pause
    exit 1
}

Write-Host "  Downloaded to Desktop!" -ForegroundColor Green
Write-Host ""
Write-Host "  Open WakePCAgentSetup.exe on your Desktop to install." -ForegroundColor White
Write-Host ""

explorer.exe "/select,$output"
