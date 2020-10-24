`@echo off
echo Administrative permissions required. Detecting permissions ...

net session >nul 2>&1
if %errorLevel% == 0 (
ECHO Okay ...
IF EXIST "C:\ProgramData\chocolatey\bin\chocolatey.exe" (
ECHO Chocolatey is already installed ...
choco upgrade chocolatey chocolatey-core.extension -y
) ELSE (
ECHO Installing Chocolatey ...
@PowerShell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
)
ECHO Checking packages ...
for /F "eol=#" %%G in (packages.txt) do choco upgrade %%G -y
) else (
echo Failure: Current permissions inadequate.
)`