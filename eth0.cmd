@echo off
setlocal

set NAME="eth0"
netsh interface ipv4 show config name=%NAME%
pause

REM  --> Check for permissions
if "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) else (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%ERRORLEVEL%' NEQ '0' (
  echo Requesting administrative privileges...
  exit /b 0
)

if "x%~1" == "x-172" (
  call :ip172 "%~nx0"
  exit /b %ERRORLEVEL%
)

if "x%~1" == "x-192" (
  call :ip192 "%~nx0"
  exit /b %ERRORLEVEL%
)

:EOF
exit /b 0

:ip172
set NAME="eth0"
set ADDR=172.22.11.52
set ADDR1=192.168.99.52
set ADDR2=192.168.11.52
set MASK=255.255.255.0
set GATEWAY=172.22.11.1
set DNS1=1.2.4.8
set DNS2=8.8.8.8
set DNS3=180.76.76.76
netsh interface ipv4 set address name=%NAME% source=static address=%ADDR% mask=%MASK% gateway=%GATEWAY% gwmetric=0
netsh interface ipv4 add address name=%NAME% address=%ADDR1% mask=%MASK%
netsh interface ipv4 add address name=%NAME% address=%ADDR2% mask=%MASK%
netsh interface ipv4 set dnsservers name=%NAME% source=static address=%DNS1% register=PRIMARY validate=no
netsh interface ipv4 add dnsservers name=%NAME% address=%DNS2% index=2 validate=no
netsh interface ipv4 add dnsservers name=%NAME% address=%DNS3% index=3 validate=no
pause
exit /b 0

:ip192
set NAME="eth0"
set ADDR=192.168.99.52
set ADDR1=172.22.11.52
set ADDR2=192.168.11.52
set MASK=255.255.255.0
set GATEWAY=192.168.99.85
set DNS1=1.2.4.8
set DNS2=8.8.8.8
set DNS3=180.76.76.76
netsh interface ipv4 set address name=%NAME% source=static address=%ADDR% mask=%MASK% gateway=%GATEWAY% gwmetric=0
netsh interface ipv4 add address name=%NAME% address=%ADDR1% mask=%MASK%
netsh interface ipv4 add address name=%NAME% address=%ADDR2% mask=%MASK%
netsh interface ipv4 set dnsservers name=%NAME% source=static address=%DNS1% register=PRIMARY validate=no
netsh interface ipv4 add dnsservers name=%NAME% address=%DNS2% index=2 validate=no
netsh interface ipv4 add dnsservers name=%NAME% address=%DNS3% index=3 validate=no
pause
exit /b 0
