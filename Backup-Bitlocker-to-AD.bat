@echo off
REM IP Address on the internal network to determine if the computer already has network connectivity
REM Customize the IP address to which you want to ping
set IPAddress="10.150.13.11"

REM If regkey exist GOTO END
REG QUERY HKLM\SOFTWARE\BITLOCKER_SCRIPT\ /v "backuped"
IF %errorlevel% EQU 0 GOTO END

REM Wait until internal network will be reachable
:loop
timeout 5
ping -n 1 %IPAddress% | find "TTL=" || GOTO :loop

REM Backup system drive bitlocker key to AD
manage-bde -protectors -get %systemdrive%
for /F "tokens=2 delims=: " %%A in ('manage-bde -protectors -get %systemdrive% -type recoverypassword ^| findstr "       ID:"') do (
	echo %%A
    manage-bde -protectors -adbackup %systemdrive% -id %%A
)

REM Add registry key
REG ADD HKLM\SOFTWARE\BITLOCKER_SCRIPT\ /v "backuped" /t REG_DWORD /d 1
:END
