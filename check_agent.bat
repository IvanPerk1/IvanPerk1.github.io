@echo off
chcp 65001 >nul

:: Create output directory and report file
set "reportdir=%LOCALAPPDATA%\WakePC Agent"
if not exist "%reportdir%" mkdir "%reportdir%"
set "report=%reportdir%\diagnostics.txt"

:: Tee helper — all output goes to screen AND file
:: We use a sub-script approach: run ourselves with redirection
if "%~1"=="" (
    "%~f0" run 2>&1 | powershell -Command "$input | ForEach-Object { $_; Add-Content -Path '%report%' -Value $_ }"
    echo.
    echo Report saved to: %report%
    echo.
    pause
    exit /b
)

:: ── HEADER ──
echo.
echo ============================================
echo   WakePC Agent — Full Diagnostics v2.1
echo   %date% %time%
echo ============================================
echo.

:: ── 1. ADMIN CHECK ──
echo [1] Admin privileges:
net session >nul 2>nul
if %errorlevel%==0 (
    echo   OK - Running as Administrator
) else (
    echo   WARN - NOT running as Admin (some checks may be incomplete)
)

:: ── 2. INSTALLED FILES ──
echo.
echo [2] Installed files:
set "installdir=C:\Program Files (x86)\WakePC Agent"
if exist "%installdir%\WakePCAgent.exe" (
    echo   OK - WakePCAgent.exe found
) else (
    echo   FAIL - WakePCAgent.exe NOT FOUND in "%installdir%"
)
if exist "%installdir%\WakePCAgent.dll" (
    echo   OK - WakePCAgent.dll found
) else (
    echo   FAIL - WakePCAgent.dll NOT FOUND
)

:: ── 3. AGENT VERSION ──
echo.
echo [3] Agent version:
powershell -Command "try { $dll = Get-Item '%installdir%\WakePCAgent.dll' -ErrorAction Stop; Write-Host ('  Installed: ' + $dll.VersionInfo.ProductVersion) } catch { Write-Host '  Could not read version (not installed?)' }"

:: ── 4. .NET RUNTIME ──
echo.
echo [4] .NET Desktop Runtime:
powershell -Command "$runtimes = dotnet --list-runtimes 2>&1; $desktop8 = $runtimes | Select-String 'Microsoft.WindowsDesktop.App 8\.'; if ($desktop8) { Write-Host ('  OK - ' + ($desktop8 | Select-Object -First 1).Line.Trim()) } else { $any8 = $runtimes | Select-String 'NETCore.App 8\.'; if ($any8) { Write-Host '  FAIL - .NET 8 Core found but WindowsDesktop.App 8.x MISSING (agent needs it!)' } else { Write-Host '  FAIL - .NET 8 Runtime NOT FOUND (agent will not start!)' } }"

:: ── 5. PROCESS ──
echo.
echo [5] Process:
powershell -Command "$procs = Get-Process WakePCAgent -ErrorAction SilentlyContinue; if ($procs) { $procs | ForEach-Object { Write-Host ('  OK - PID ' + $_.Id + ' | RAM ' + [math]::Round($_.WorkingSet64/1MB,1) + ' MB | Started ' + $_.StartTime.ToString('yyyy-MM-dd HH:mm:ss')) } } else { Write-Host '  FAIL - Agent is NOT running' }"

:: ── 6. PORT 8765 ──
echo.
echo [6] Port 8765:
powershell -Command "$lines = netstat -ano | Select-String ':8765\s'; if ($lines) { foreach ($l in $lines) { $parts = $l.Line.Trim() -split '\s+'; $pid = $parts[-1]; $procName = (Get-Process -Id $pid -ErrorAction SilentlyContinue).ProcessName; Write-Host ('  ' + $l.Line.Trim() + ' [' + $procName + ']') }; $non = $lines | Where-Object { $_ -notmatch 'WakePCAgent' -and $_ -match 'LISTENING' }; if ($non) { Write-Host '  WARN - Port may be used by another process!' } } else { Write-Host '  FAIL - Port 8765 is NOT listening' }"

:: ── 7. API SELF-TEST ──
echo.
echo [7] API response (localhost:8765/status):
powershell -Command "try { $r = Invoke-WebRequest -Uri http://localhost:8765/status -UseBasicParsing -TimeoutSec 5; Write-Host ('  OK - HTTP ' + $r.StatusCode); $json = $r.Content | ConvertFrom-Json; Write-Host ('  IP: ' + $json.ip + ' | MAC: ' + $json.mac) } catch { Write-Host ('  FAIL - ' + $_.Exception.Message) }"

:: ── 8. FIREWALL ──
echo.
echo [8] Firewall rules:
netsh advfirewall firewall show rule name="WakePC Agent - HTTP" >nul 2>nul
if %errorlevel%==0 (
    echo   OK - HTTP rule (TCP 8765)
) else (
    echo   FAIL - HTTP firewall rule MISSING
)
netsh advfirewall firewall show rule name="WakePC Agent - WoL" >nul 2>nul
if %errorlevel%==0 (
    echo   OK - WoL rule (UDP 9)
) else (
    echo   FAIL - WoL firewall rule MISSING
)
powershell -Command "$fw = (Get-NetFirewallProfile -Profile Domain,Private,Public -ErrorAction SilentlyContinue); foreach ($p in $fw) { $state = if ($p.Enabled) { 'ON' } else { 'OFF' }; Write-Host ('  Firewall ' + $p.Name + ': ' + $state) }"

:: ── 9. URL ACL ──
echo.
echo [9] URL ACL:
powershell -Command "$out = netsh http show urlacl url=http://*:8765/ 2>&1; if ($out -match '8765') { Write-Host '  OK - URL ACL registered' } else { Write-Host '  FAIL - URL ACL MISSING (HttpListener may fail)' }"

:: ── 10. TASK SCHEDULER ──
echo.
echo [10] Task Scheduler (Autostart):
schtasks /Query /TN "WakePCAgent" >nul 2>nul
if %errorlevel%==0 (
    echo   OK - Task exists
    powershell -Command "$xml = [xml](schtasks /Query /TN 'WakePCAgent' /XML 2>&1); $exec = $xml.Task.Actions.Exec.Command; $runLevel = $xml.Task.Principals.Principal.RunLevel; $triggers = $xml.Task.Triggers; Write-Host ('  Exe path: ' + $exec); if (Test-Path $exec) { Write-Host '  Exe exists: YES' } else { Write-Host '  Exe exists: NO — TASK WILL FAIL!' }; Write-Host ('  Run level: ' + $runLevel); foreach ($t in $triggers.ChildNodes) { Write-Host ('  Trigger: ' + $t.LocalName); $d = $t.Delay; if ($d) { Write-Host ('  Delay: ' + $d) } };"
    powershell -Command "$out = schtasks /Query /TN 'WakePCAgent' /V /FO LIST 2>&1; $lines = $out | Select-String 'Status|Last Run|Result|Состояние|последнего|результат'; foreach ($l in $lines) { Write-Host ('  ' + $l.Line.Trim()) }"
) else (
    echo   FAIL - Autostart task MISSING (agent won't start on boot!)
)

:: ── 11. REGISTRY AUTOSTART (old method) ──
echo.
echo [11] Registry autostart (legacy):
powershell -Command "$val = Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Run' -Name 'WakePCAgent' -ErrorAction SilentlyContinue; if ($val) { Write-Host ('  FOUND (legacy): ' + $val.WakePCAgent); Write-Host '  WARN - Old registry autostart exists. May conflict or run without admin.' } else { Write-Host '  OK - No legacy registry entry (correct)' }"

:: ── 12. NETWORK ──
echo.
echo [12] Network:
powershell -Command "$adapters = Get-NetAdapter | Where-Object { $_.Status -eq 'Up' -and $_.InterfaceDescription -notmatch 'Hyper-V|Virtual|vEthernet|VPN|WAN Miniport|Bluetooth' }; if ($adapters) { foreach ($a in $adapters) { $ip = (Get-NetIPAddress -InterfaceIndex $a.ifIndex -AddressFamily IPv4 -ErrorAction SilentlyContinue).IPAddress; Write-Host ('  ' + $a.Name + ': ' + $a.InterfaceDescription + ' | IP: ' + $ip + ' | MAC: ' + $a.MacAddress) } } else { Write-Host '  FAIL - No active network adapters found!' }"

:: ── 13. ADAPTER POWER SAVING ──
echo.
echo [13] Adapter power management (PnPCapabilities):
powershell -Command "$adapters = Get-NetAdapter | Where-Object { $_.Status -eq 'Up' -and $_.InterfaceDescription -notmatch 'Hyper-V|Virtual|vEthernet|VPN|WAN Miniport|Bluetooth' }; foreach ($a in $adapters) { $pnp = Get-ItemProperty -Path ('HKLM:\SYSTEM\CurrentControlSet\Enum\' + $a.PnPDeviceID) -Name 'PnPCapabilities' -ErrorAction SilentlyContinue; $val = if ($pnp) { $pnp.PnPCapabilities } else { 0 }; $status = if ($val -eq 24) { 'OK (power saving disabled)' } elseif ($val -eq 0) { 'WARN - power saving ENABLED (can crash HTTP server!)' } else { 'WARN - value=' + $val + ' (expected 24)' }; Write-Host ('  ' + $a.Name + ': PnPCapabilities=' + $val + ' — ' + $status) }"

:: ── 14. FAST BOOT ──
echo.
echo [14] Fast Boot:
powershell -Command "$fb = Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power' -Name 'HiberbootEnabled' -ErrorAction SilentlyContinue; if ($fb -eq $null) { Write-Host '  UNKNOWN - Registry key not found' } elseif ($fb.HiberbootEnabled -eq 0) { Write-Host '  OK - Fast Boot DISABLED (correct for WoL)' } else { Write-Host '  WARN - Fast Boot ENABLED (may break WoL after shutdown!)' }"

:: ── 15. WAKE-ON-LAN SETTINGS ──
echo.
echo [15] Wake-on-LAN adapter settings:
powershell -Command "$adapters = Get-NetAdapter | Where-Object { $_.Status -eq 'Up' -and $_.InterfaceDescription -notmatch 'Hyper-V|Virtual|vEthernet|VPN|WAN Miniport|Bluetooth' }; foreach ($a in $adapters) { Write-Host ('  ' + $a.Name + ':'); try { $pm = Get-NetAdapterPowerManagement -Name $a.Name -ErrorAction Stop; Write-Host ('    WakeOnMagicPacket: ' + $pm.WakeOnMagicPacket); Write-Host ('    AllowComputerToTurnOff: ' + $pm.AllowComputerToTurnOffDevice) } catch { $path = 'HKLM:\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}'; $subs = Get-ChildItem $path -ErrorAction SilentlyContinue; foreach ($s in $subs) { $drv = Get-ItemProperty $s.PSPath -Name 'DriverDesc' -ErrorAction SilentlyContinue; if ($drv -and $drv.DriverDesc -eq $a.InterfaceDescription) { $wol = Get-ItemProperty $s.PSPath -Name '*WakeOnMagicPacket' -ErrorAction SilentlyContinue; Write-Host ('    *WakeOnMagicPacket: ' + $(if ($wol) { $wol.'*WakeOnMagicPacket' } else { 'not set' })); break } } } }"

:: ── 16. EVENT LOG (crashes) ──
echo.
echo [16] Recent crashes (Event Log, last 24h):
powershell -Command "$events = Get-WinEvent -FilterHashtable @{LogName='Application'; Level=1,2; StartTime=(Get-Date).AddHours(-24)} -ErrorAction SilentlyContinue | Where-Object { $_.Message -match 'WakePCAgent|WakePC' } | Select-Object -First 5; if ($events) { foreach ($e in $events) { Write-Host ('  ' + $e.TimeCreated.ToString('HH:mm:ss') + ' [' + $e.LevelDisplayName + '] ' + $e.Message.Substring(0, [Math]::Min(200, $e.Message.Length))) } } else { Write-Host '  OK - No WakePC crashes in last 24 hours' }"

:: ── 17. LOG FILE (last 20 on screen) ──
echo.
echo [17] Agent log (last 20 lines):
set "logfile=%LOCALAPPDATA%\WakePC Agent\agent.log"
if exist "%logfile%" (
    echo   Path: %logfile%
    powershell -Command "$size = (Get-Item '%LOCALAPPDATA%\WakePC Agent\agent.log').Length; Write-Host ('  Size: ' + [math]::Round($size/1KB,1) + ' KB')"
    echo.
    powershell -Command "Get-Content '%LOCALAPPDATA%\WakePC Agent\agent.log' -Tail 20"
) else (
    echo   No log file found (agent never ran or old version)
)

:: ── 18. FULL AGENT LOG → REPORT FILE ──
:: (not shown on screen, only appended to diagnostics.txt)
powershell -Command "if (Test-Path '%LOCALAPPDATA%\WakePC Agent\agent.log') { $content = Get-Content '%LOCALAPPDATA%\WakePC Agent\agent.log' -Raw; Add-Content -Path '%report%' -Value \"`n`n========== FULL AGENT LOG ==========`n$content`n========== END LOG ==========\"; }" >nul 2>nul

:: ── SUMMARY ──
echo.
echo ============================================
echo   DONE! Report saved to:
echo   %report%
echo.
echo   Send this file for support:
echo   %reportdir%\diagnostics.txt
echo   (contains all checks + full agent log)
echo ============================================
