@echo off
mode 120, 36
chcp 65001 >nul

REM Set Colors
set p=[38;5;99m
set l=[38;5;240m
set r=[38;5;216m
set g=[38;5;123m
set e=[0m
set ar=[38;5;203m
set do=[38;5;223m
set o=[38;5;229m
set lo=[38;5;230m
set ic=[38;5;231m
set oc=[38;5;253m
set g=[38;5;248m
set mg=[38;5;243m


::Ask for ADMIN permissions inside batch (https://stackoverflow.com/questions/1894967/how-to-request-administrator-access-inside-a-batch-file)
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    TITLE Requesting Admin Previleges
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo                                       %r% _      _  _____   __    _     _  _____  _%l%
    echo                                      %r% \ \  / ^| ^|  ^| ^|   / /\  ^| ^|   ^| ^|  ^| ^|  \ \_/%l%
    echo                                        %r%\_\/  ^|_^|  ^|_^|  /_/--\ ^|_^|__ ^|_^|  ^|_^|   ^|_^|%l%
    echo.
    echo                                                 Requesting Admin Previleges
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"



cls
TITLE Vitality Cleaner
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo                                       %r% _      _  _____   __    _     _  _____  _%l%
echo                                      %r% \ \  / ^| ^|  ^| ^|   / /\  ^| ^|   ^| ^|  ^| ^|  \ \_/%l%
echo                                        %r%\_\/  ^|_^|  ^|_^|  /_/--\ ^|_^|__ ^|_^|  ^|_^|   ^|_^|%l%
echo.
echo                                                          Cleaning...
ipconfig /release >nul 2>&1
ipconfig /renew >nul 2>&1
ipconfig /flushdns >nul 2>&1
del /s /f /q c:\windows\temp\*.* >nul 2>&1
rd /s /q c:\windows\temp >nul 2>&1
md c:\windows\temp >nul 2>&1
del /s /f /q %temp%\*.* >nul 2>&1
rd /s /q %temp% >nul 2>&1
md %temp% >nul 2>&1
del /f /s /q %systemdrive%\*.tmp >nul 2>&1
del /f /s /q %systemdrive%\*._mp >nul 2>&1
del /f /s /q %systemdrive%\*.log >nul 2>&1
del /f /s /q %systemdrive%\*.gid >nul 2>&1
del /f /s /q %systemdrive%\*.chk >nul 2>&1
del /f /s /q %systemdrive%\*.old >nul 2>&1
del /f /s /q %systemdrive%\recycled\*.* >nul 2>&1
del /f /s /q %windir%\*.bak >nul 2>&1
del /f /s /q %windir%\prefetch\*.* >nul 2>&1
rd /s /q %windir%\temp & md %windir%\temp >nul 2>&1
del /f /q %userprofile%\cookies\*.* >nul 2>&1
del /f /q %userprofile%\recent\*.* >nul 2>&1
del /f /s /q “%userprofile%\Local Settings\Temporary Internet Files\*.*” >nul 2>&1
del /f /s /q “%userprofile%\Local Settings\Temp\*.*” >nul 2>&1
del /f /s /q “%userprofile%\recent\*.*” >nul 2>&1
cleanmgr /sagerun:1 >nul 2>&1
exit