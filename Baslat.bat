@echo off
chcp 65001 >nul
title TemizWin Başlatıcı
cd /d "%~dp0"
set "PS1_FILE=%~dp0TemizWin.ps1"

:: Mark-of-the-web internet engelini kaldır (Unblock)
powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "Unblock-File -LiteralPath '%PS1_FILE%' -ErrorAction SilentlyContinue"

:: Yönetici yetkisi kontrolü ve doğrudan yetkili başlatma (UAC)
net session >nul 2>&1
if %errorlevel% neq 0 (
    powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "Start-Process powershell.exe -ArgumentList @('-STA', '-NoProfile', '-ExecutionPolicy', 'Bypass', '-File', ('\"' + $env:PS1_FILE + '\"')) -Verb RunAs"
    exit /b
)

:: Zaten yönetici ise doğrudan başlat
start "" powershell.exe -STA -NoProfile -ExecutionPolicy Bypass -File "%PS1_FILE%"
exit /b
