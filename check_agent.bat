@echo off
chcp 65001 >nul

set "reportdir=%LOCALAPPDATA%\WakePC Agent"
if not exist "%reportdir%" mkdir "%reportdir%"
set "report=%reportdir%\diagnostics.txt"
set "installdir=C:\Program Files (x86)\WakePC Agent"

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
    echo   WARN - NOT running as Admin
)

:: ── 2. INSTALLED FILES ──
echo.
echo [2] Installed files:
if exist "%installdir%\WakePCAgent.exe" (
    echo   OK - WakePCAgent.exe found
) else (
    echo   FAIL - WakePCAgent.exe NOT FOUND
)
if exist "%installdir%\WakePCAgent.dll" (
    echo   OK - WakePCAgent.dll found
) else (
    echo   FAIL - WakePCAgent.dll NOT FOUND
)

:: ── 3. AGENT VERSION ──
echo.
echo [3] Agent version:
powershell -Command "try { $dll = Get-Item 'C:\Program Files (x86)\WakePC Agent\WakePCAgent.dll' -EA Stop; Write-Host ('  Installed: ' + $dll.VersionInfo.ProductVersion) } catch { Write-Host '  Could not read version' }"

:: ── 4. .NET RUNTIME ──
echo.
echo [4] .NET Desktop Runtime:
powershell -Command "$r = dotnet --list-runtimes 2>&1; $d = $r | Select-String 'WindowsDesktop.App 8\.'; if ($d) { Write-Host ('  OK - ' + $d[0].Line.Trim()) } else { Write-Host '  FAIL - .NET 8 Desktop Runtime NOT FOUND' }"

:: ── 5. PROCESS ──
echo.
echo [5] Process:
powershell -Command "$p = Get-Process WakePCAgent -EA SilentlyContinue; if ($p) { $p | ForEach-Object { Write-Host ('  OK - PID ' + $_.Id + ' | RAM ' + [math]::Round($_.WorkingSet64/1MB,1) + ' MB | Started ' + $_.StartTime.ToString('yyyy-MM-dd HH:mm:ss')) } } else { Write-Host '  FAIL - Agent is NOT running' }"

:: ── 6. PORT 8765 ──
echo.
echo [6] Port 8765:
powershell -Command "$l = netstat -ano | Select-String ':8765\s'; if ($l) { foreach ($x in $l) { $parts = $x.Line.Trim() -split '\s+'; $pid = $parts[-1]; $pn = (Get-Process -Id $pid -EA SilentlyContinue).ProcessName; Write-Host ('  ' + $x.Line.Trim() + ' [' + $pn + ']') } } else { Write-Host '  FAIL - Port 8765 NOT listening' }"

:: ── 7. API SELF-TEST ──
echo.
echo [7] API response:
powershell -Command "try { $r = Invoke-WebRequest -Uri http://localhost:8765/status -UseBasicParsing -TimeoutSec 5; $j = $r.Content | ConvertFrom-Json; Write-Host ('  OK - IP: ' + $j.ip + ' | MAC: ' + $j.mac) } catch { Write-Host ('  FAIL - ' + $_.Exception.Message) }"

:: ── 8. FIREWALL ──
echo.
echo [8] Firewall rules:
netsh advfirewall firewall show rule name="WakePC Agent - HTTP" >nul 2>nul
if %errorlevel%==0 ( echo   OK - HTTP rule ) else ( echo   FAIL - HTTP rule MISSING )
netsh advfirewall firewall show rule name="WakePC Agent - WoL" >nul 2>nul
if %errorlevel%==0 ( echo   OK - WoL rule ) else ( echo   FAIL - WoL rule MISSING )
powershell -Command "$fw = Get-NetFirewallProfile -EA SilentlyContinue; foreach ($p in $fw) { $s = if ($p.Enabled) {'ON'} else {'OFF'}; Write-Host ('  Firewall ' + $p.Name + ': ' + $s) }"

:: ── 9. URL ACL ──
echo.
echo [9] URL ACL:
powershell -Command "$o = netsh http show urlacl url=http://*:8765/ 2>&1; if ($o -match '8765') { Write-Host '  OK - registered' } else { Write-Host '  FAIL - MISSING' }"

:: ── 10. TASK SCHEDULER ──
echo.
echo [10] Task Scheduler:
schtasks /Query /TN "WakePCAgent" >nul 2>nul
if %errorlevel%==0 (
    echo   OK - Task exists
    powershell -Command "$xml = [xml](schtasks /Query /TN 'WakePCAgent' /XML 2>&1); $exec = $xml.Task.Actions.Exec.Command; $rl = $xml.Task.Principals.Principal.RunLevel; Write-Host ('  Exe: ' + $exec); if (Test-Path $exec) { Write-Host '  Exe exists: YES' } else { Write-Host '  Exe exists: NO — WILL FAIL!' }; Write-Host ('  RunLevel: ' + $rl); foreach ($t in $xml.Task.Triggers.ChildNodes) { Write-Host ('  Trigger: ' + $t.LocalName); if ($t.Delay) { Write-Host ('  Delay: ' + $t.Delay) } }"
    powershell -Command "$o = schtasks /Query /TN 'WakePCAgent' /V /FO LIST 2>&1; $l = $o | Select-String 'Status|Last Run|Result|Состояние|последнего|результат'; foreach ($x in $l) { Write-Host ('  ' + $x.Line.Trim()) }"
) else (
    echo   FAIL - Task MISSING
)

:: ── 11. REGISTRY AUTOSTART ──
echo.
echo [11] Registry autostart:
powershell -Command "$v = Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Run' -Name 'WakePCAgent' -EA SilentlyContinue; if ($v) { Write-Host ('  WARN - Legacy entry: ' + $v.WakePCAgent) } else { Write-Host '  OK - No legacy entry' }"

:: ── 12. NETWORK ──
echo.
echo [12] Network:
powershell -Command "$a = Get-NetAdapter | Where-Object { $_.Status -eq 'Up' -and $_.InterfaceDescription -notmatch 'Hyper-V|Virtual|vEthernet|VPN|WAN Miniport|Bluetooth' }; if ($a) { foreach ($x in $a) { $ip = (Get-NetIPAddress -InterfaceIndex $x.ifIndex -AddressFamily IPv4 -EA SilentlyContinue).IPAddress; Write-Host ('  ' + $x.Name + ': ' + $x.InterfaceDescription + ' | IP: ' + $ip + ' | MAC: ' + $x.MacAddress) } } else { Write-Host '  FAIL - No active adapters' }"

:: ── 13. ADAPTER POWER SAVING ──
echo.
echo [13] Power management:
powershell -Command "$a = Get-NetAdapter | Where-Object { $_.Status -eq 'Up' -and $_.InterfaceDescription -notmatch 'Hyper-V|Virtual|vEthernet|VPN|WAN Miniport|Bluetooth' }; foreach ($x in $a) { $pnp = Get-ItemProperty -Path ('HKLM:\SYSTEM\CurrentControlSet\Enum\' + $x.PnPDeviceID) -Name 'PnPCapabilities' -EA SilentlyContinue; $v = if ($pnp) { $pnp.PnPCapabilities } else { 0 }; $s = if ($v -eq 24) { 'OK - disabled' } else { 'WARN - ENABLED' }; Write-Host ('  ' + $x.Name + ': PnPCap=' + $v + ' ' + $s) }"

:: ── 14. FAST BOOT ──
echo.
echo [14] Fast Boot:
powershell -Command "$fb = Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power' -Name 'HiberbootEnabled' -EA SilentlyContinue; if ($fb -eq $null) { Write-Host '  UNKNOWN' } elseif ($fb.HiberbootEnabled -eq 0) { Write-Host '  OK - Disabled' } else { Write-Host '  WARN - ENABLED' }"

:: ── 15. WAKE-ON-LAN ──
echo.
echo [15] WoL settings:
powershell -Command "$a = Get-NetAdapter | Where-Object { $_.Status -eq 'Up' -and $_.InterfaceDescription -notmatch 'Hyper-V|Virtual|vEthernet|VPN|WAN Miniport|Bluetooth' }; foreach ($x in $a) { Write-Host ('  ' + $x.Name + ':'); try { $pm = Get-NetAdapterPowerManagement -Name $x.Name -EA Stop; Write-Host ('    WakeOnMagicPacket: ' + $pm.WakeOnMagicPacket); Write-Host ('    AllowTurnOff: ' + $pm.AllowComputerToTurnOffDevice) } catch { Write-Host '    (PowerShell cmdlet failed, checking registry)'; $path = 'HKLM:\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}'; Get-ChildItem $path -EA SilentlyContinue | ForEach-Object { $drv = Get-ItemProperty $_.PSPath -Name 'DriverDesc' -EA SilentlyContinue; if ($drv -and $drv.DriverDesc -eq $x.InterfaceDescription) { $wol = Get-ItemProperty $_.PSPath -Name '*WakeOnMagicPacket' -EA SilentlyContinue; Write-Host ('    *WakeOnMagicPacket: ' + $(if ($wol) { $wol.'*WakeOnMagicPacket' } else { 'not set' })) } } } }"

:: ── 16. EVENT LOG ──
echo.
echo [16] Crashes (24h):
powershell -Command "$ev = Get-WinEvent -FilterHashtable @{LogName='Application'; Level=1,2; StartTime=(Get-Date).AddHours(-24)} -EA SilentlyContinue | Where-Object { $_.Message -match 'WakePCAgent|WakePC' } | Select-Object -First 5; if ($ev) { foreach ($e in $ev) { Write-Host ('  ' + $e.TimeCreated.ToString('HH:mm:ss') + ' ' + $e.Message.Substring(0, [Math]::Min(150, $e.Message.Length))) } } else { Write-Host '  OK - No crashes' }"

:: ── 17. LOG FILE ──
echo.
echo [17] Agent log (last 20 lines):
set "logfile=%LOCALAPPDATA%\WakePC Agent\agent.log"
if exist "%logfile%" (
    powershell -Command "$s = (Get-Item '%LOCALAPPDATA%\WakePC Agent\agent.log').Length; Write-Host ('  Size: ' + [math]::Round($s/1KB,1) + ' KB')"
    echo.
    powershell -Command "Get-Content '%LOCALAPPDATA%\WakePC Agent\agent.log' -Tail 20"
) else (
    echo   No log file found
)

:: ── SAVE REPORT TO FILE ──
echo.
echo ============================================
echo   Saving report...
echo ============================================
powershell -NoProfile -Command "$d = '%reportdir%'; $r = '$d\diagnostics.txt'; $header = 'WakePC Agent Diagnostics - ' + (Get-Date).ToString('yyyy-MM-dd HH:mm:ss') + [Environment]::NewLine; $checks = @(); $checks += '[Diagnostics collected by check_agent.bat v2.1]'; $checks += ''; try { $procs = Get-Process WakePCAgent -EA Stop; $checks += '[5] Process: OK - PID ' + $procs[0].Id } catch { $checks += '[5] Process: FAIL - Not running' }; $l = netstat -ano | Select-String ':8765\s'; if ($l) { $checks += '[6] Port: OK - listening' } else { $checks += '[6] Port: FAIL' }; try { $api = Invoke-WebRequest -Uri http://localhost:8765/status -UseBasicParsing -TimeoutSec 3; $j = $api.Content | ConvertFrom-Json; $checks += '[7] API: OK - IP=' + $j.ip + ' MAC=' + $j.mac } catch { $checks += '[7] API: FAIL' }; $adapters = Get-NetAdapter | Where-Object { $_.Status -eq 'Up' -and $_.InterfaceDescription -notmatch 'Hyper-V|Virtual|vEthernet|VPN|WAN Miniport|Bluetooth' }; foreach ($a in $adapters) { $pnp = Get-ItemProperty -Path ('HKLM:\SYSTEM\CurrentControlSet\Enum\' + $a.PnPDeviceID) -Name 'PnPCapabilities' -EA SilentlyContinue; $v = if ($pnp) { $pnp.PnPCapabilities } else { 0 }; $checks += '[13] ' + $a.Name + ': PnPCap=' + $v }; $logPath = $d + '\agent.log'; $fullLog = ''; if (Test-Path $logPath) { $fullLog = [Environment]::NewLine + '========== FULL AGENT LOG ==========' + [Environment]::NewLine + (Get-Content $logPath -Raw) + [Environment]::NewLine + '========== END LOG ==========' }; $all = $header + ($checks -join [Environment]::NewLine) + $fullLog; Set-Content -Path ($d + '\diagnostics.txt') -Value $all -Encoding UTF8; Write-Host ('  Saved to: ' + $d + '\diagnostics.txt')"

echo.
echo ============================================
echo   DONE! Send this file for support:
echo   %reportdir%\diagnostics.txt
echo ============================================
echo.
pause
