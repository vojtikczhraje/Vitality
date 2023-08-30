@echo off
setlocal enabledelayedexpansion
mode 120, 36
chcp 65001 >nul
TITLE Vitality

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


:: Check if this batch file has already determined the SystemType
if exist "%temp%\SystemType.txt" (
    set /p SystemType=<"%temp%\SystemType.txt"
    goto :SkipCheck
)

:: Initialize variable
set "SystemType=Unknown"

:: Execute PowerShell command inline and get its output
for /f %%i in ('powershell -NoProfile -ExecutionPolicy Bypass -Command "$enclosure = Get-WmiObject Win32_SystemEnclosure; switch ($enclosure.ChassisTypes) { { $_ -eq 3 } { 'Desktop'; break } { $_ -eq 9 } { 'Laptop'; break } default { 'Unknown' } }"') do (
    set "SystemType=%%i"
)

:: Save the SystemType for future use
echo %SystemType% > "%temp%\SystemType.txt"

:: Relaunch the script
set "batch_file=%~f0"
start "" "%batch_file%"
exit

:SkipCheck


REM Tweaks Page 1
set FPS=false
set Latency=false
set GPU=false
set Task=false
set KBM=false
set CPU=false
set Network=false

REM Tweaks Page 2
set RAM=false
set DISK=false
set Windows=false

REM Recording Settings
set HighQuality=false
set MediumQuality=false
set LowQuality=false

REM Game Settings
set Minecraft=false
set CSGO=false
set Valorant=false
set Fortnite=false
Set COD=false
set Apex=false
set Rust=false

REM Privacy
set PrivacyCleanup=false
set DataCol=false
set SecurityImp=false
set ConfigurePro=false
set PrivacyOverSec=false
set UIForPrivacy=false

set lasttweaks1=true

REM Backup
if exist "C:\Vitality\Backup\Security.reg"  (
    set "Status=Enabled"
) else (
    set "Status=Disabled"
)

if exist "C:\Vitality\Backup\System.reg"  (
    set "Status=Enabled"
) else (
    set "Status=Disabled"
)

if exist "C:\Vitality\Backup\Default.reg"  (
    set "Status=Enabled"
) else (
    set "Status=Disabled"
)

if exist "C:\Vitality\Backup\Security.reg" (
    set "Status=Enabled"
) else (
    set "Status=Disabled"
)

if exist "C:\Vitality\Backup\RestorePoint" (
    set "ResStatus=Enabled"
) else (
    set "ResStatus=Disabled"
)

set "statusc="
if "%status%"=="Disabled" (
    set "statusc=[38;5;203m"
) else (
    set "statusc=[38;5;34m"
)

set "ResStatusc="
if "%ResStatus%"=="Disabled" (
    set "ResStatusc=[38;5;203m"
) else (
    set "ResStatusc=[38;5;34m"
)





REM Create Required Directories 

REM Create Main Directory
cd C:\
mkdir C:\Vitality
cd C:\Vitality
cls

REM Create Sub Directories
cd C:\Vitality\
mkdir C:\Vitality\Info
mkdir C:\VItality\Backup
mkdir C:\VItality\Resources
cls

REM Optimization Counter
if not exist "C:\Vitality\v.bat" echo set "ran_optimizations=0"> v.bat
call v.bat
set "formatted_optimizations=%ran_optimizations%"
if %formatted_optimizations% LSS 10 set "formatted_optimizations= %formatted_optimizations%"

REM Choice Setup
for /f %%A in ('"prompt $H &echo on &for %%B in (1) do rem"') do set BS=%%A


REM Welcome Message

if exist C:\Vitality\Info\welcome1 (
    set welcome1=Welcome back %r%%username%%e%, have a good time using Vitality.
)

if not exist C:\Vitality\Info\welcome1 (
    set welcome1=Welcome to Vitality %r%%username%%e%.
    echo Vitality > C:\Vitality\Info\welcome1
)

if not exist C:\Vitality\Info\welcome2 (
    set welcome2=Are you ready to level up your gaming experience?
    echo Vitality > C:\Vitality\Info\welcome2

) else (
    set welcome2=Let's optimize your Windows even more :P
)


for /F "tokens=* skip=1" %%n in ('WMIC path Win32_VideoController get Name ^| findstr "."') do set GPU_NAME=%%n
echo %GPU_NAME% | find "NVIDIA" && set gpu1=Nvidia >nul 2>&1
echo %GPU_NAME% | find "AMD" && set gpu1=AMD >nul 2>&1
if not defined GPU_NAME set gpu1=NaN


for /F "skip=1 delims=" %%A in ('wmic cpu get name') do (
    set "cpuName=%%A"
    goto :check_brand
)

:check_brand
echo %cpuName% | find "Intel" >nul 2>&1
if %errorlevel%==0 (
    set "cpu1=Intel"
) else (
    set "cpu1=AMD"
)


:Loading
cls
if "%lastpage%"==":Home" goto Home
if "%lastpage%"==":Tweaks" goto Tweaks
if "%lastpage%"==":IngameSettings" goto IngameSettings
if "%lastpage%"==":RecordingSettings" goto RecordingSettings
if "%lastpage%"==":Backup" goto Backup
if "%lastpage%"==":Credits" goto Credits
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
cd "C:\Vitality\Backup"
if not exist "C:\Vitality\Backup\Software.reg" regedit /e "C:\Vitality\Backup\Software.reg" "HKEY_LOCAL_MACHINE\SOFTWARE" >nul 2>&1
if not exist "C:\Vitality\Backup\System.reg" regedit /e "C:\Vitality\Backup\System.reg" "HKEY_LOCAL_MACHINE\SYSTEM" >nul 2>&1
if not exist "C:\Vitality\Backup\Security.reg" regedit /e "C:\Vitality\Backup\Security.reg" "HKEY_LOCAL_MACHINE\SECURITY" >nul 2>&1
if not exist "C:\Vitality\Backup\Default.reg" (
    reg load HKLM\TEMP_DEFAULT "C:\Users\Default\NTUSER.DAT" >nul 2>&1
    reg export "HKLM\TEMP_DEFAULT" "C:\Vitality\Backup\Default.reg" /y >nul 2>&1
    reg unload HKLM\TEMP_DEFAULT >nul 2>&1
)

echo reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v "SystemRestorePointCreationFrequency" /t REG_DWORD /d 0 /f >nul 2>&1
echo powershell -ExecutionPolicy Unrestricted -NoProfile Enable-ComputerRestore -Drive 'C:\', 'D:\', 'E:\', 'F:\', 'G:\' >nul 2>&1
echo powershell -ExecutionPolicy Unrestricted -NoProfile Checkpoint-Computer -Description 'Vitality' >nul 2>&1

if not exist C:\Vitality\Backup\RestorePoint (
    echo Vitality > "C:\Vitality\Backup\RestorePoint"
    echo @echo off > "C:\Vitality\Backup\RestorePoint.bat"
    echo reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v "SystemRestorePointCreationFrequency" /t REG_DWORD /d 0 /f >> "C:\Vitality\Backup\RestorePoint.bat"
    echo powershell -ExecutionPolicy Unrestricted -NoProfile Enable-ComputerRestore -Drive 'C:\', 'D:\', 'E:\', 'F:\', 'G:\' >> "C:\Vitality\Backup\RestorePoint.bat"
    echo powershell -ExecutionPolicy Unrestricted -NoProfile Checkpoint-Computer -Description 'Vitality' >> "C:\Vitality\Backup\RestorePoint.bat"
    echo exit >> "C:\Vitality\Backup\RestorePoint.bat"
    start /min "" "C:\Vitality\Backup\RestorePoint.bat"
)

Ping www.google.nl -n 1 -w 1000 >nul
if %errorlevel% neq 0 (
echo %e%                                   No %r%Internet Connection%e%, press C to continue anyway
choice /c:"CQ" /n /m "%l%                                              [ %r%C%l% ] Continue  [ %r%Q%l% ] Quit %r%" & if !errorlevel! equ 2 exit /b
)

REM OS informations
set "OSVersion=Unknown"
systeminfo > temp.txt 2>nul
for /f "delims=" %%i in ('findstr /B /C:"OS Name" temp.txt') do set "OSInfo=%%i"
call :checkOS
:checkOS
if "%OSInfo%"=="OS Name:                   Microsoft Windows 8.1" set "OSVersion=Windows 8.1"
if "%OSInfo%"=="OS Name:                   Microsoft Windows 10 Home" set "OSVersion=Windows 10"
if "%OSInfo%"=="OS Name:                   Microsoft Windows 10 Pro" set "OSVersion=Windows 10"
if "%OSInfo%"=="OS Name:                   Microsoft Windows 10 Enterprise" set "OSVersion=Windows 10 LTSC"
if "%OSInfo%"=="OS Name:                   Microsoft Windows 11 Home" set "OSVersion=Windows 11"
if "%OSInfo%"=="OS Name:                   Microsoft Windows 11 Pro" set "OSVersion=Windows 11"




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




:Home
set lastpage=:Home
cls
echo.                                
echo     %l%┌─────────────────────────────┐                       
echo     │ %r%W%l% = %e%Up%l%       %r%D%l% = %e%Right%l%      │           %r% _      _  _____   __    _     _  _____  _%l%    
echo     │ %r%S%l% = %e%Down%l%     %r%A%l% = %e%Left%l%       │          %r% \ \  / ^| ^|  ^| ^|   / /\  ^| ^|   ^| ^|  ^| ^|  \ \_/%l%      %r%▲%e% Pages  [%r%1%e%/1]%l%
echo     │ %r%X%l% = %e%Apply%l%                   │            %r%\_\/  ^|_^|  ^|_^|  /_/--\ ^|_^|__ ^|_^|  ^|_^|   ^|_^|%l% 
echo.    │ It's not that hard is it?   │
echo     └─────────────────────────────┘                                                        
echo     %l%┌─────────────────────────────┐         %r%▲%e% %welcome1% %l%
echo     ^│                             ^│          %l%%welcome2%%l% %l%%welcome3%%l%
echo     ^│                             ^│
echo     ^│            %r%Home%l%             ^│
echo     ^│                             ^│       ┌───────────────────────────────────────────────────────────────────┐
echo     ^│                             ^│       │ %ar%▼ %ar%Disclaimers%l%                                                     │
echo     ^│           Tweaks            ^│       │                                                                   │
echo     ^│                             ^│       │ %ar%•%e% Use at Your Own Risk. %l%                                          │
echo     ^│                             ^│       │                                                                   │
echo     ^│       Ingame Settings       ^│       │ %ar%•%e% Not guaranteed to be compatible with all configurations. %l%       │
echo     ^│                             ^│       │                                                                   │
echo     ^│                             ^│       │ %ar%•%e% Create a full system backup before applying any tweaks. %l%        │
echo     ^│      Recording Settings     ^│       │                                                                   │
echo     ^│                             ^│       │ %ar%•%e% Disable antivirus to avoid conflicts. %l%                          │
echo     ^│                             ^│       │                                                                   │
echo     ^│           Privacy           ^│       │ %ar%•%e% Understand the implications of each tweak before applying it. %l%  │
echo     ^│                             ^│       └───────────────────────────────────────────────────────────────────┘
echo     ^│                             ^│
echo     ^│           Backup            ^│		  
echo     ^│                             ^│        %e%Applied Optimizations: %r%%formatted_optimizations%%l%         %e%Status of Backup: %statusc%%Status%%l%
echo     ^│                             ^│
echo     ^│           Credits           ^│
echo     ^│                             ^│        %e%Operating System: %r%%OSVersion%%l%      %e%System Type: %r%%SystemType%%l%
echo     ^│                             ^│
echo     └─────────────────────────────┘
choice /c:WS /n /m " "
set MenuItem=%errorlevel%

if "%MenuItem%"=="1" goto Credits
if "%MenuItem%"=="2" (
    if "%lasttweaks1%"=="true" (
        goto :lasttweaks1
    ) else (
        goto :lasttweaks2
    )



) 


pause > nul
exit

:Tweaks 
set lastpage=:Tweaks
set lasttweaks1=true
set lasttweaks2=false
:lasttweaks1


set "FPSc="
if "%FPS%"=="false" (
    set "FPSc=[38;5;203m"
) else (
    set "FPSc=[38;5;34m"
)

set "Latencyc="
if "%Latency%"=="false" (
    set "Latencyc=[38;5;203m"
) else (
    set "Latencyc=[38;5;34m"
)

set "Networkc="
if "%Network%"=="false" (
    set "Networkc=[38;5;203m"
) else (
    set "Networkc=[38;5;34m"
)

set "KBMc="
if "%KBM%"=="false" (
    set "KBMc=[38;5;203m"
) else (
    set "KBMc=[38;5;34m"
)

set "Taskc="
if "%Task%"=="false" (
    set "Taskc=[38;5;203m"
) else (
    set "Taskc=[38;5;34m"
)

set "Taskc="
if "%Task%"=="false" (
    set "Taskc=[38;5;203m"
) else (
    set "Taskc=[38;5;34m"
)

set "GPUc="
if "%GPU%"=="false" (
    set "GPUc=[38;5;203m"
) else (
    set "GPUc=[38;5;34m"
)

set "CPUc="
if "%CPU%"=="false" (
    set "CPUc=[38;5;203m"
) else (
    set "CPUc=[38;5;34m"
)



cls
echo.                                
echo     %l%┌─────────────────────────────┐                       
echo     │ %r%W%l% = %e%Up%l%       %r%D%l% = %e%Right%l%      │           %r% _      _  _____   __    _     _  _____  _%l%    
echo     │ %r%S%l% = %e%Down%l%     %r%A%l% = %e%Left%l%       │          %r% \ \  / ^| ^|  ^| ^|   / /\  ^| ^|   ^| ^|  ^| ^|  \ \_/%l%      %r%▲%e% Pages  [%r%1%e%/2]%l%
echo     │ %r%X%l% = %e%Apply%l%                   │            %r%\_\/  ^|_^|  ^|_^|  /_/--\ ^|_^|__ ^|_^|  ^|_^|   ^|_^|%l%   Use %r%D%l% to go on new page
echo.    │ It's not that hard is it?   │
echo     └─────────────────────────────┘                                                        
echo     %l%┌─────────────────────────────┐         %r%▲%e% Instruction: Press %r%0-5%e% and the button will turn green%l%
echo     ^│                             ^│  Everything that's %r%green%l% means that will be optimized once you press %r%X%l%
echo     ^│                             ^│          
echo     ^│            Home             ^│
echo     ^│                             ^│     %e%[%r% 0 %e%]  %r%•%e%  FPS and Input Delay %l%                        %FPSc%▼%l%        
echo     ^│                             ^│             Enhance FPS and Reduce Input Delay for Better Gaming. 
echo     ^│           %r%Tweaks%l%            ^│
echo     ^│                             ^│     %e%[%r% 1 %e%]  %r%•%e%  Latency %l%                                    %Latencyc%▼%l%
echo     ^│                             ^│             Significantly Minimize Computer Latency for Enhanced Performance.
echo     ^│       Ingame Settings       ^│      
echo     ^│                             ^│     %e%[%r% 2 %e%]  %r%•%e%  Network %l%                                    %Networkc%▼%l%     
echo     ^│                             ^│             Optimize Internet Performance Effectively.
echo     ^│      Recording Settings     ^│    
echo     ^│                             ^│     %e%[%r% 3 %e%]  %r%•%e%  KBM %l%                                        %KBMc%▼%l%       
echo     ^│                             ^│             Enhance Keyboard and Mouse Functionality with Tweaks.
echo     ^│           Privacy           ^│      
echo     ^│                             ^│     %e%[%r% 4 %e%]  %r%•%e%  Task Scheduler %l%                             %Taskc%▼%l% 
echo     ^│                             ^│             Optimize Performance by Disabling Unnecessary Task Scheduler Tasks.
echo     ^│           Backup            ^│
echo     ^│                             ^│     %e%[%r% 5 %e%]  %r%•%e%  GPU Tweaks                                  %GPUc%▼%l%
echo     ^│                             ^│             Unlock Peak GPU Performance with our tweaks
echo     ^│           Credits           ^│  
echo     ^│                             ^│          
echo     ^│                             ^│
echo     └─────────────────────────────┘                                %l%┌───────────────┐
echo                                                                    %l%│   %e%Apply [%r%X%e%]%l%   │
echo                                                                    └───────────────┘
choice /c:WS012345DAX /n /m " "                                           
set MenuItem=%errorlevel%
if "%MenuItem%"=="1" goto Home
if "%MenuItem%"=="2" goto IngameSettings
if "%MenuItem%"=="3" (
    if "%FPS%"=="false" (
        set "FPS=true"
    ) else (
        set "FPS=false"
    )
) && goto Tweaks

if "%MenuItem%"=="4" (
    if "%Latency%"=="false" (
        set "Latency=true"
    ) else (
        set "Latency=false"
    )
) && goto Tweaks

if "%MenuItem%"=="5" (
    if "%Network%"=="false" (
        set "Network=true"
    ) else (
        set "Network=false"
    )
) && goto Tweaks

if "%MenuItem%"=="6" (
    if "%KBM%"=="false" (
        set "KBM=true"
    ) else (
        set "KBM=false"
    )
) && goto Tweaks

if "%MenuItem%"=="7" (
    if "%Task%"=="false" (
        set "Task=true"
    ) else (
        set "Task=false"
    )
) && goto Tweaks

if "%MenuItem%"=="8" (
    if "%GPU%"=="false" (
        set "GPU=true"
    ) else (
        set "GPU=false"
    )
) && goto Tweaks


if "%MenuItem%"=="9" goto Tweaks2
if "%MenuItem%"=="10" goto Tweaks2
if "%MenuItem%"=="11" goto TweaksProceed















:Tweaks2 
set lastpage=:Tweaks2

set lasttweaks2=true
set lasttweaks1=false
:lasttweaks2

set "RAMc="
if "%RAM%"=="false" (
    set "RAMc=[38;5;203m"
) else (
    set "RAMc=[38;5;34m"
)

set "DISKc="
if "%DISK%"=="false" (
    set "DISKc=[38;5;203m"
) else (
    set "DISKc=[38;5;34m"
)

set "Windowsc="
if "%Windows%"=="false" (
    set "Windowsc=[38;5;203m"
) else (
    set "Windowsc=[38;5;34m"
)

set "CPUc="
if "%CPU%"=="false" (
    set "CPUc=[38;5;203m"
) else (
    set "CPUc=[38;5;34m"
)





cls
echo.                                
echo     %l%┌─────────────────────────────┐                       
echo     │ %r%W%l% = %e%Up%l%       %r%D%l% = %e%Right%l%      │           %r% _      _  _____   __    _     _  _____  _%l%    
echo     │ %r%S%l% = %e%Down%l%     %r%A%l% = %e%Left%l%       │          %r% \ \  / ^| ^|  ^| ^|   / /\  ^| ^|   ^| ^|  ^| ^|  \ \_/%l%      %r%▲%e% Pages  [%r%2%e%/2]%l%
echo     │ %r%X%l% = %e%Apply%l%                   │            %r%\_\/  ^|_^|  ^|_^|  /_/--\ ^|_^|__ ^|_^|  ^|_^|   ^|_^|%l% Use %r%A%l% to go on previous page
echo.    │ It's not that hard is it?   │
echo     └─────────────────────────────┘                                                        
echo     %l%┌─────────────────────────────┐         %r%▲%e% Instruction: Press %r%6-9%e% and the button will turn green%l%
echo     ^│                             ^│  Everything that's %r%green%l% means that will be optimized once you press %r%X%l%
echo     ^│                             ^│          
echo     ^│            Home             ^│
echo     ^│                             ^│     %e%[%r% 6 %e%]  %r%•%e%  RAM  %l%                                       %RAMc%▼%l%        
echo     ^│                             ^│             Unlock Top-notch Performance with RAM Optimization.
echo     ^│           %r%Tweaks%l%            ^│
echo     ^│                             ^│     %e%[%r% 7 %e%]  %r%•%e%  DISK %l%                                       %DISKc%▼%l%      
echo     ^│                             ^│             Achieve Optimal Disk Performance with our tweaks.
echo     ^│       Ingame Settings       ^│       
echo     ^│                             ^│     %e%[%r% 8 %e%]  %r%•%e%  Windows %l%                                    %Windowsc%▼%l%      
echo     ^│                             ^│             Enhance Your Windows Experience with These Superior Settings.
echo     ^│      Recording Settings     ^│             
echo     ^│                             ^│     %e%[%r% 9 %e%]  %r%•%e%  CPU Tweaks %l%                                 %CPUc%▼%l%             
echo     ^│                             ^│             Unlock Peak CPU Performance with our tweaks.
echo     ^│           Privacy           ^│                
echo     ^│                             ^│                   
echo     ^│                             ^│       
echo     ^│           Backup            ^│           
echo     ^│                             ^│             
echo     ^│                             ^│
echo     ^│           Credits           ^│           
echo     ^│                             ^│             
echo     ^│                             ^│
echo     └─────────────────────────────┘                                %l%┌───────────────┐
echo                                                                    %l%│   %e%Apply [%r%X%e%]%l%   │
echo                                                                    └───────────────┘
choice /c:WS6789ADX /n /m " "                                           
set MenuItem=%errorlevel%
if "%MenuItem%"=="1" goto Home
if "%MenuItem%"=="2" goto IngameSettings
if "%MenuItem%"=="3" (
    if "%RAM%"=="false" (
        set "RAM=true"
    ) else (
        set "RAM=false"
    )
) && goto Tweaks2

if "%MenuItem%"=="4" (
    if "%DISK%"=="false" (
        set "DISK=true"
    ) else (
        set "DISK=false"
    )
) && goto Tweaks2

if "%MenuItem%"=="5" (
    if "%Windows%"=="false" (
        set "Windows=true"
    ) else (
        set "Windows=false"
    )
) && goto Tweaks2

if "%MenuItem%"=="6" (
    if "%CPU%"=="false" (
        set "CPU=true"
    ) else (
        set "CPU=false"
    )
) && goto Tweaks2

if "%MenuItem%"=="7" goto Tweaks
if "%MenuItem%"=="8" goto Tweaks
if "%MenuItem%"=="9" goto TweaksProceed





:IngameSettings



set lastpage=:IngameSettings
cls
set "Minecraftc="
if "%Minecraft%"=="false" (
    set "Minecraftc=[38;5;203m"
) else (
    set "Minecraftc=[38;5;34m"
)

set "CSGOc="
if "%CSGO%"=="false" (
    set "CSGOc=[38;5;203m"
) else (
    set "CSGOc=[38;5;34m"
)

set "Rustc="
if "%Rust%"=="false" (
    set "Rustc=[38;5;203m"
) else (
    set "Rustc=[38;5;34m"
)

set "Valorantc="
if "%Valorant%"=="false" (
    set "Valorantc=[38;5;203m"
) else (
    set "Valorantc=[38;5;34m"
)

set "Fortnitec="
if "%Fortnite%"=="false" (
    set "Fortnitec=[38;5;203m"
) else (
    set "Fortnitec=[38;5;34m"
)

set "CODc="
if "%COD%"=="false" (
    set "CODc=[38;5;203m"
) else (
    set "CODc=[38;5;34m"
)

set "Apexc="
if "%Apex%"=="false" (
    set "Apexc=[38;5;203m"
) else (
    set "Apexc=[38;5;34m"
)

cls
echo.                                
echo     %l%┌─────────────────────────────┐                       
echo     │ %r%W%l% = %e%Up%l%       %r%D%l% = %e%Right%l%      │           %r% _      _  _____   __    _     _  _____  _%l%    
echo     │ %r%S%l% = %e%Down%l%     %r%A%l% = %e%Left%l%       │          %r% \ \  / ^| ^|  ^| ^|   / /\  ^| ^|   ^| ^|  ^| ^|  \ \_/%l%      %r%▲%e% Pages  [%r%1%e%/1]%l%      
echo     │ %r%X%l% = %e%Apply%l%                   │            %r%\_\/  ^|_^|  ^|_^|  /_/--\ ^|_^|__ ^|_^|  ^|_^|   ^|_^|%l%  
echo.    │ It's not that hard is it?   │
echo     └─────────────────────────────┘                                                        
echo     %l%┌─────────────────────────────┐         %r%▲%e% Instruction: Press %r%6-9%e% and the button will turn green%l%
echo     ^│                             ^│  Everything that's %r%green%l% means that will be optimized once you press %r%X%l%
echo     ^│                             ^│   
echo     ^│            Home             ^│         
echo     ^│                             ^│     %e%[%r% 1 %e%]  %r%•%e%  Minecraft  %l%                                 %Minecraftc%▼%l% 
echo     ^│                             ^│             Currently only for 1.8.9
echo     ^│           Tweaks            ^│         
echo     ^│                             ^│     
echo     ^│                             ^│          
echo     ^│       %r%Ingame Settings%l%       ^│            
echo     ^│                             ^│               
echo     ^│                             ^│                       
echo     ^│      Recording Settings     ^│   
echo     ^│                             ^│ 
echo     ^│                             ^│   
echo     ^│           Privacy           ^│              
echo     ^│                             ^│     
echo     ^│                             ^│       
echo     ^│           Backup            ^│         
echo     ^│                             ^│    
echo     ^│                             ^│
echo     ^│           Credits           ^│  
echo     ^│                             ^│    
echo     ^│                             ^│
echo     └─────────────────────────────┘                                
echo.                                                                    
echo.                                                                   
choice /c:WS1 /n /m " "                                           
set MenuItem=%errorlevel%
if "%MenuItem%"=="1" (
    if "%lasttweaks1%"=="true" (
        goto :lasttweaks1
    ) else (
        goto :lasttweaks2
    )
) 

if "%MenuItem%"=="2" goto RecordingSettings
if "%MenuItem%"=="3" (
    if "%Minecraft%"=="false" (
        set "Minecraft=True"
    ) else (
        set "Minecraft=false"
    )
) && goto IngameSettings




:RecordingSettings
set lastpage=:RecordingSettings

set "HighQualityc="
if "%HighQuality%"=="false" (
    set "HighQualityc=[38;5;203m"
) else (
    set "HighQualityc=[38;5;34m"
)

set "MediumQualityc="
if "%MediumQuality%"=="false" (
    set "MediumQualityc=[38;5;203m"
) else (
    set "MediumQualityc=[38;5;34m"
)

set "LowQualityc="
if "%LowQuality%"=="false" (
    set "LowQualityc=[38;5;203m"
) else (
    set "LowQualityc=[38;5;34m"
)

if "%gpu1%"=="Nvidia" set encoder=Nvidia
if "%gpu1%"=="AMD" set encoder=AMD
if "%gpu1%"=="NaN" set encoder=CPU


cls
echo.                                
echo     %l%┌─────────────────────────────┐                       
echo     │ %r%W%l% = %e%Up%l%       %r%D%l% = %e%Right%l%      │           %r% _      _  _____   __    _     _  _____  _%l%    
echo     │ %r%S%l% = %e%Down%l%     %r%A%l% = %e%Left%l%       │          %r% \ \  / ^| ^|  ^| ^|   / /\  ^| ^|   ^| ^|  ^| ^|  \ \_/%l%      %r%▲%e% Pages  [%r%1%e%/1]%l%
echo     │ %r%X%l% = %e%Apply%l%                   │            %r%\_\/  ^|_^|  ^|_^|  /_/--\ ^|_^|__ ^|_^|  ^|_^|   ^|_^|%l% (Renders are from HoneCtrl)
echo.    │ It's not that hard is it?   │
echo     └─────────────────────────────┘                                                        
echo     %l%┌─────────────────────────────┐         %r%▲%e% Instruction: Press %r%1-3%e% and the button will turn green%l%
echo     ^│                             ^│  Everything that's %r%green%l% means that will be optimized once you press %r%X%l%
echo     ^│                             ^│
echo     ^│            Home             ^│         
echo     ^│                             ^│     %e%[%r% 1 %e%]  %r%•%e%  High Quality%l%                                %HighQualityc%▼%l%        
echo     ^│                             ^│         These recording settings are suitable for short videos however,
echo     ^│           Tweaks            ^│         they may not be optimal for longer videos due to higher storage usage.
echo     ^│                             ^│                  
echo     ^│                             ^│       
echo     ^│       Ingame Settings       ^│              
echo     ^│                             ^│     %e%[%r% 2 %e%]  %r%•%e%  Medium Quality%l%                              %MediumQualityc%▼%l%             
echo     ^│                             ^│         These recording settings are well-suited for both short and long videos,
echo     ^│      %r%Recording Settings%l%     ^│         striking the perfect balance with medium storage usage while maintaining 
echo     ^│                             ^│         optimal performance.              
echo     ^│                             ^│       
echo     ^│           Privacy           ^│              
echo     ^│                             ^│                   
echo     ^│                             ^│     %e%[%r% 3 %e%]  %r%•%e%  Low Quality%l%                                 %LowQualityc%▼%l%       
echo     ^│           Backup            ^│         While these recording settings offer exceptionally low storage usage,
echo     ^│                             ^│         it's worth noting that. they may result in subpar video quality. 
echo     ^│                             ^│         Consider utilizing these settings as a last resort when all other 
echo     ^│           Credits           ^│         options are unavailable.
echo     ^│                             ^│          
echo     ^│                             ^│
echo     └─────────────────────────────┘                                %l%┌───────────────┐
echo                                                                    %l%│   %e%Apply [%r%X%e%]%l%   │
echo                                                                    └───────────────┘
choice /c:WS123X /n /m " "                                           
set MenuItem=%errorlevel%
if "%MenuItem%"=="1" goto IngameSettings
if "%MenuItem%"=="2" goto Privacy
if "%MenuItem%"=="3" (
    if "%HighQuality%"=="false" (
        set "HighQuality=true"
        set "MediumQuality=false"
        set "LowQuality=false"
    ) else (
        set "HighQuality=false"
    )
) && goto RecordingSettings

if "%MenuItem%"=="4" (
    if "%MediumQuality%"=="false" (
        set "HighQuality=false"
        set "MediumQuality=true"
        set "LowQuality=false"
    ) else (
        set "MediumQuality=false"
    )
) && goto RecordingSettings

if "%MenuItem%"=="5" (
    if "%LowQuality%"=="false" (
        set "HighQuality=false"
        set "MediumQuality=false"
        set "LowQuality=True"
    ) else (
        set "LowQuality=false"
    )
) && goto RecordingSettings

if "%MenuItem%"=="6" goto TweaksProceed











:Privacy
cls
set lastpage=:Privacy


set "PrivacyCleanupc="
if "%PrivacyCleanup%"=="false" (
    set "PrivacyCleanupc=[38;5;203m"
) else (
    set "PrivacyCleanupc=[38;5;34m"
)

set "DataColc="
if "%DataCol%"=="false" (
    set "DataColc=[38;5;203m"
) else (
    set "DataColc=[38;5;34m"
)

set "SecurityImpc="
if "%SecurityImp%"=="false" (
    set "SecurityImpc=[38;5;203m"
) else (
    set "SecurityImpc=[38;5;34m"
)

set "ConfigureProc="
if "%ConfigurePro%"=="false" (
    set "ConfigureProc=[38;5;203m"
) else (
    set "ConfigureProc=[38;5;34m"
)

set "PrivacyOverSecc="
if "%PrivacyOverSec%"=="false" (
    set "PrivacyOverSecc=[38;5;203m"
) else (
    set "PrivacyOverSecc=[38;5;34m"
)

set "UIForPrivacyc="
if "%UIForPrivacy%"=="false" (
    set "UIForPrivacyc=[38;5;203m"
) else (
    set "UIForPrivacyc=[38;5;34m"
)






echo.                                
echo     %l%┌─────────────────────────────┐                       
echo     │ %r%W%l% = %e%Up%l%       %r%D%l% = %e%Right%l%      │           %r% _      _  _____   __    _     _  _____  _%l%    
echo     │ %r%S%l% = %e%Down%l%     %r%A%l% = %e%Left%l%       │          %r% \ \  / ^| ^|  ^| ^|   / /\  ^| ^|   ^| ^|  ^| ^|  \ \_/%l%      %r%▲%e% Pages  [%r%1%e%/1]%l%
echo     │ %r%X%l% = %e%Apply%l%                   │            %r%\_\/  ^|_^|  ^|_^|  /_/--\ ^|_^|__ ^|_^|  ^|_^|   ^|_^|%l% 
echo.    │ It's not that hard is it?   │
echo     └─────────────────────────────┘                                                        
echo     %l%┌─────────────────────────────┐         %r%▲%e% Instruction: Press %r%1-6%e% and the button will turn green%l%
echo     ^│                             ^│  Everything that's %r%green%l% means that will be optimized once you press %r%X%l%
echo     ^│                             ^│
echo     ^│            Home             ^│         
echo     ^│                             ^│     %e%[%r% 1 %e%]  %r%•%e%  Privacy Cleanup%l%                             %PrivacyCleanupc%▼%l% 
echo     ^│                             ^│         Audit and remove unnecessary data, ensuring compliance and security.
echo     ^│           Tweaks            ^│        
echo     ^│                             ^│     %e%[%r% 2 %e%]  %r%•%e%  Data Collection%l%                             %DataColc%▼%l%          
echo     ^│                             ^│         Deletes Microsoft Gathered Informations About You.
echo     ^│       Ingame Settings       ^│              
echo     ^│                             ^│     %e%[%r% 3 %e%]  %r%•%e%  Security Improvements%l%                       %SecurityImpc%▼%l%  
echo     ^│                             ^│         Strengthen systems with updates, encryption, and regular assessments.
echo     ^│      Recording Settings     ^│          
echo     ^│                             ^│     %e%[%r% 4 %e%]  %r%•%e%  Configure Programs%l%                          %ConfigureProc%▼%l%
echo     ^│                             ^│         Removes data collection from 3rd party programs. (Visual Studio)
echo     ^│           %r%Privacy%l%           ^│              
echo     ^│                             ^│     %e%[%r% 5 %e%]  %r%•%e%  Privacy Over Security%l%                       %PrivacyOverSecc%▼%l%                   
echo     ^│                             ^│         Disables Windows Defender and automatic updates.  
echo     ^│           Backup            ^│         
echo     ^│                             ^│     %e%[%r% 6 %e%]  %r%•%e%  UI For Privacy%l%                              %UIForPrivacyc%▼%l%    
echo     ^│                             ^│         Elevate Your Windows 10 UI Experience by Disabling Annoying Elements.
echo     ^│           Credits           ^│        
echo     ^│                             ^│          
echo     ^│                             ^│
echo     └─────────────────────────────┘                                %l%┌───────────────┐
echo                                                                    %l%│   %e%Apply [%r%X%e%]%l%   │
echo                                                                    └───────────────┘
choice /c:WS123456X /n /m " "                                           
set MenuItem=%errorlevel%
if "%MenuItem%"=="1" goto RecordingSettings
if "%MenuItem%"=="2" goto Backup
if "%MenuItem%"=="3" (
    if "%PrivacyCleanup%"=="false" (
        set "PrivacyCleanup=true"
    ) else (
        set "PrivacyCleanup=false"
    )
) && goto Privacy

if "%MenuItem%"=="4" (
    if "%DataCol%"=="false" (
        set "DataCol=true"
    ) else (
        set "DataCol=false"
    )
) && goto Privacy

if "%MenuItem%"=="5" (
    if "%SecurityImp%"=="false" (
        set "SecurityImp=true"
    ) else (
        set "SecurityImp=false"
    )
) && goto Privacy

if "%MenuItem%"=="6" (
    if "%ConfigurePro%"=="false" (
        set "ConfigurePro=true"
         set "goToTweaks=true"
    ) else (
        set "ConfigurePro=false"
    )
) && goto Privacy

if "%MenuItem%"=="7" (
    if "%PrivacyOverSec%"=="false" (
        set "PrivacyOverSec=true"
    ) else (
        set "PrivacyOverSec=false"
    )
) && goto Privacy

if "%MenuItem%"=="8" (
    if "%UIForPrivacy%"=="false" (
        set "UIForPrivacy=true"
    ) else (
        set "UIForPrivacy=false"
    )
) && goto Privacy

if "%MenuItem%"=="9" goto TweaksProceed









:Backup
set lastpage=:Backup
set "SecurityStatus=Disabled"
set "SystemStatus=Disabled"
set "DefaultStatus=Disabled"

set "EnabledCount=0"
set "DisabledCount=0"

if exist "C:\Vitality\Backup\Security.reg"  (
    set "SecurityStatus=Enabled"
    set /a "EnabledCount+=1"
) else (
    set /a "DisabledCount+=1"
)

if exist "C:\Vitality\Backup\System.reg"  (
    set "SystemStatus=Enabled"
    set /a "EnabledCount+=1"
) else (
    set /a "DisabledCount+=1"
)

if exist "C:\Vitality\Backup\Default.reg"  (
    set "DefaultStatus=Enabled"
    set /a "EnabledCount+=1"
) else (
    set /a "DisabledCount+=1"
)


if %DisabledCount% gtr 0 (
    if %EnabledCount% gtr 0 (
        set "Status=Partially Enabled"
        set "statusc=[38;5;216m"
    ) else (
        set "Status=Disabled"
        set "statusc=[38;5;203m"
    )
)

set "ResStatusc="
if "%ResStatus%"=="Disabled" (
    set "ResStatusc=[38;5;203m"
) else (
    set "ResStatusc=[38;5;34m"
)

cls
echo.                                
echo     %l%┌─────────────────────────────┐                       
echo     │ %r%W%l% = %e%Up%l%       %r%D%l% = %e%Right%l%      │           %r% _      _  _____   __    _     _  _____  _%l%    
echo     │ %r%S%l% = %e%Down%l%     %r%A%l% = %e%Left%l%       │          %r% \ \  / ^| ^|  ^| ^|   / /\  ^| ^|   ^| ^|  ^| ^|  \ \_/%l%      %r%▲%e% Pages  [%r%1%e%/1]%l%
echo     │ %r%X%l% = %e%Apply%l%                   │            %r%\_\/  ^|_^|  ^|_^|  /_/--\ ^|_^|__ ^|_^|  ^|_^|   ^|_^|%l%   
echo.    │ It's not that hard is it?   │
echo     └─────────────────────────────┘                                                        
echo     %l%┌─────────────────────────────┐         %r%▲%e% Instruction:%l%
echo     ^│                             ^│  Backup should be %r%"Enabled"%l% if not create one yourself
echo     ^│                             ^│                                                         [%statusc%%Status%%l%]
echo     ^│            Home             ^│ 
echo     ^│                             ^│     %e%[%r% 1 %e%]  %r%•%e%  Software%l%                                      %statusc%▼%l%
echo     ^│                             ^│          HKEY_LOCAL_MACHINE\SOFTWARE 
echo     ^│           Tweaks            ^│      
echo     ^│                             ^│ 
echo     ^│                             ^│     %e%[%r% 2 %e%]  %r%•%e%  System%l%                                        %statusc%▼%l%
echo     ^│       Ingame Settings       ^│          HKEY_LOCAL_MACHINE\SYSTEM
echo     ^│                             ^│
echo     ^│                             ^│
echo     ^│      Recording Settings     ^│     %e%[%r% 3 %e%]  %r%•%e%  Default%l%                                       %statusc%▼%l%
echo     ^│                             ^│          HKEY_USERS\.DEFAULT
echo     ^│                             ^│
echo     ^│           Privacy           ^│
echo     ^│                             ^│     %e%[%r% 4 %e%]  %r%•%e%  Security%l%                                      %statusc%▼%l%
echo     ^│                             ^│          HKEY_LOCAL_MACHINE\SECURITY
echo     ^│           %r%Backup%l%            ^│ 
echo     ^│                             ^│
echo     ^│                             ^│     %e%[%r% 5 %e%]  %r%•%e%  Restore Point%l%                                 %ResStatusc%▼%l%
echo     ^│           Credits           ^│         Name of Restore Point is %r%"Vitality"%l%
echo     ^│                             ^│          
echo     ^│                             ^│
echo     └─────────────────────────────┘                                
echo.
echo.
choice /c:WS /n /m " "                                           
set MenuItem=%errorlevel%
if "%MenuItem%"=="1" goto Privacy
if "%MenuItem%"=="2" goto Credits









:Credits
set lastpage=:Credits
cls
echo.                                
echo     %l%┌─────────────────────────────┐                       
echo     │ %r%W%l% = %e%Up%l%       %r%D%l% = %e%Right%l%      │           %r% _      _  _____   __    _     _  _____  _%l%    
echo     │ %r%S%l% = %e%Down%l%     %r%A%l% = %e%Left%l%       │          %r% \ \  / ^| ^|  ^| ^|   / /\  ^| ^|   ^| ^|  ^| ^|  \ \_/%l%      %r%▲%e% Pages  [%r%1%e%/1]%l%
echo     │ %r%X%l% = %e%Apply%l%                   │            %r%\_\/  ^|_^|  ^|_^|  /_/--\ ^|_^|__ ^|_^|  ^|_^|   ^|_^|%l%  
echo.    │ It's not that hard is it?   │
echo     └─────────────────────────────┘                                                        
echo     %l%┌─────────────────────────────┐         %r%▲%e% Credits:%l% 
echo     ^│                             ^│       
echo     ^│                             ^│ 
echo     ^│            Home             ^│         %r%Founders:%e% vojtikczhraje, Pigeonlinon%l% 
echo     ^│                             ^│
echo     ^│                             ^│ 
echo     ^│           Tweaks            ^│         %do%Design:%e% Karma, Pigeonlinon%l%
echo     ^│                             ^│
echo     ^│                             ^│          
echo     ^│       Ingame Settings       ^│         %o%Functionality:%e% vojtikczhraje, HoneCtrl, EchoX%l%
echo     ^│                             ^│
echo     ^│                             ^│
echo     ^│      Recording Settings     ^│         %lo%Tweaks:%e% vojtikczhraje, Karma, Amitxv, sppdl, HoneCtrl%l% 
echo     ^│                             ^│                  
echo     ^│                             ^│         
echo     ^│           Privacy           ^│         %ic%IngameSettings:%e% under construction...%l% 
echo     ^│                             ^│
echo     ^│                             ^│  
echo     ^│           Backup            ^│         %oc%Recording Settings:%e% vojtikczhraje, HoneCtrl%l%
echo     ^│                             ^│
echo     ^│                             ^│          
echo     ^│           %r%Credits%l%           ^│         %g%Privacy:%e% privacy.sexy%l%
echo     ^│                             ^│
echo     ^│                             ^│
echo     └─────────────────────────────┘         %mg%Backup:%e% vojtikczhraje, HoneCtrl%l% 
echo.
echo.
choice /c:WS /n /m " "                                           
set MenuItem=%errorlevel%
if "%MenuItem%"=="1" goto Backup
if "%MenuItem%"=="2" goto Home






:TweaksProceed
cls
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

if "%FPS%"=="false" goto skippingfps
echo                                            Applying FPS and Input Delay Tweaks
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "VisualFXSetting" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\AnimateMinMax" /v "DefaultApplied" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\ComboBoxAnimation" /v "DefaultApplied" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\ControlAnimations" /v "DefaultApplied" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\CursorShadow" /v "DefaultApplied" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\DragFullWindows" /v "DefaultApplied" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\DropShadow" /v "DefaultApplied" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\DWMAeroPeekEnabled" /v "DefaultApplied" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\DWMEnabled" /v "DefaultApplied" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\DWMSaveThumbnailEnabled" /v "DefaultApplied" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\FontSmoothing" /v "DefaultApplied" /t REG_SZ /d "1" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\ListBoxSmoothScrolling" /v "DefaultApplied" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\ListviewAlphaSelect" /v "DefaultApplied" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\ListviewShadow" /v "DefaultApplied" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\MenuAnimation" /v "DefaultApplied" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\SelectionFade" /v "DefaultApplied" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\TaskbarAnimations" /v "DefaultApplied" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\ThumbnailsOrIcon" /v "DefaultApplied" /t REG_SZ /d "1" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\TooltipAnimation" /v "DefaultApplied" /t REG_SZ /d "0" /f >nul 2>&1

rem Set IRQ priority values
reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v IRQ8Priority /t REG_DWORD /d 1 /f >nul 2>&1
reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v IRQ14Priority /t REG_DWORD /d 1 /f >nul 2>&1
reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v IRQ15Priority /t REG_DWORD /d 1 /f >nul 2>&1

rem Configure LatencyLogger Autologger
reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\Autologger\LatencyLogger" /v Start /t REG_DWORD /d 1 /f >nul 2>&1

rem Disable telemetry data collection
reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul 2>&1

rem Configure power settings
reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power" /v ExitLatency /t REG_DWORD /d 1 /f >nul 2>&1
reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power" /v ExitLatencyCheckEnabled /t REG_DWORD /d 1 /f >nul 2>&1
reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power" /v Latency /t REG_DWORD /d 1 /f >nul 2>&1

rem Configure memory management settings
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "ClearPageFileAtShutdown" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "DisablePagingExecutive" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "NonPagedPoolQuota" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "NonPagedPoolSize" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "PagedPoolQuota" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "PagedPoolSize" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "PagingFiles" /t REG_MULTI_SZ /d "c:\pagefile.sys 8000 8000" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "SecondLevelDataCache" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "SessionPoolSize" /t REG_DWORD /d "48" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "SessionViewSize" /t REG_DWORD /d "96" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "SystemPages" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "PhysicalAddressExtension" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettings" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "EnableCfg" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverride" /t REG_DWORD /d "3" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverrideMask" /t REG_DWORD /d "3" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "DisablePageCombining" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "MoveImages" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "IoPageLockLimit" /t REG_DWORD /d "134217728" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "ExistingPageFiles" /t REG_MULTI_SZ /d "\??\C:\pagefile.sys" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "BootId" /t REG_DWORD /d "92" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "BaseTime" /t REG_DWORD /d "672778600" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "SfTracingState" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnablePrefetcher" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnableBootTrace" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\StoreParameters" /f >nul 2>&1
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "AltTabSettings" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "HoverSelectDesktops" /t REG_DWORD /d "0" /f >nul 2>&1

REM Disable GameDVR and related settings
Reg add "HKEY_CURRENT_USER\System\GameConfigStore" /V "GameDVR_Enabled" /T REG_DWORD /d 0 /F
Reg add "HKEY_CURRENT_USER\System\GameConfigStore" /V "GameDVR_FSEBehaviorMode" /T REG_DWORD /d 2 /F
Reg add "HKEY_CURRENT_USER\System\GameConfigStore" /V "GameDVR_HonorUserFSEBehaviorMod"e /T REG_DWORD /d 0 /F
Reg add "HKEY_CURRENT_USER\System\GameConfigStore" /V "GameDVR_DXGIHonorFSEWindowsCompatible" /T REG_DWORD /d 0 /F
Reg add "HKEY_CURRENT_USER\System\GameConfigStore" /V "GameDVR_EFSEFeatureFlags /T REG_DWORD" /d 0  /F

Rem Configure Windows Services
reg add "HKLM\SYSTEM\CurrentControlSet\Services\AarSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\AJRouter" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\ALG" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\AppIDSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Appinfo" /v "Start" /t REG_DWORD /d "3" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\AppMgmt" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\AppReadiness" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\AppVClient" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\AssignedAccessManagerSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\AudioEndpointBuilder" /v "Start" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Audiosrv" /v "Start" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\autotimesvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\AxInstSV" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BcastDVRUserService" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BFE" /v "Start" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BITS" /v "Start" /t REG_DWORD /d "3" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BluetoothUserService" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BrokerInfrastructure" /v "Start" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BTAGService" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BthAvctpSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\bthserv" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\camsvc" /v "Start" /t REG_DWORD /d "3" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\CaptureService" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\cbdhsvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\CDPSvc" /v "Start" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\CDPUserSvc" /v "Start" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\CertPropSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\ClipSVC" /v "Start" /t REG_DWORD /d "3" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\COMSysApp" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\ConsentUxUserSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\CoreMessagingRegistrar" /v "Start" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\CredentialEnrollmentManagerUserSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\CryptSvc" /v "Start" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\CscService" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DcomLaunch" /v "Start" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\defragsvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DeviceAssociationBrokerSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DeviceAssociationService" /v "Start" /t REG_DWORD /d "3" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DeviceInstall" /v "Start" /t REG_DWORD /d "3" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DevicePickerUserSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DevicesFlowUserSvc" /v "Start" /t REG_DWORD /d "3" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DevQueryBroker" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dhcp" /v "Start" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\diagnosticshub.standardcollector.service" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\diagsvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DispBrokerDesktopSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DisplayEnhancementService" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DmEnrollmentSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\dmwappushservice" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache" /v "Start" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DoSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\dot3svc" /v "Start" /t REG_DWORD /d "3" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DPS" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DsmSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DsSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DusmSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Eaphost" /v "Start" /t REG_DWORD /d "3" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\EFS" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\embeddedmode" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\EntAppSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\EventLog" /v "Start" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\EventSystem" /v "Start" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\fdPHost" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\FDResPub" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\fhsvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\FontCache" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\FontCache3.0.0.0" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\FrameServer" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\gpsvc" /v "Start" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\GraphicsPerfSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\hidserv" /v "Start" /t REG_DWORD /d "3" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\HvHost" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\icssvc" /v "Start" /t REG_DWORD /d "3" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\IKEEXT" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\InstallService" /v "Start" /t REG_DWORD /d "3" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\iphlpsvc" /v "Start" /t REG_DWORD /d "2" /f >nul 2>&1 
reg add "HKLM\SYSTEM\CurrentControlSet\Services\IpxlatCfgSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\KeyIso" /v "Start" /t REG_DWORD /d "3" /f >nul 2>&1 
reg add "HKLM\SYSTEM\CurrentControlSet\Services\KtmRm" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LicenseManager" /v "Start" /t REG_DWORD /d "3" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\lltdsvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\lmhosts" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LSM" /v "Start" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LxpSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\MapsBroker" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\MessagingService" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\mpssvc" /v "Start" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\MSDTC" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\MSiSCSI" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\msiserver" /v "Start" /t REG_DWORD /d "3" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\NaturalAuthentication" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\NcaSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\NcbService" /v "Start" /t REG_DWORD /d "3" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\NcdAutoSetup" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Netlogon" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Netman" /v "Start" /t REG_DWORD /d "3" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\netprofm" /v "Start" /t REG_DWORD /d "3" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\NetSetupSvc" /v "Start" /t REG_DWORD /d "3" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\NetTcpPortSharing" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv" /v "Start" /t REG_DWORD /d "3" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\W32Time" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WinRM" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SDRSVC" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WbioSrvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Wecsvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
net pause DiagTrack >nul 2>&1
net pause DialogBlockingService >nul 2>&1
net pause MsKeyboardFilter >nul 2>&1
net pause NetMsmqActivator  >nul 2>&1
net pause PcaSvc  >nul 2>&1
net pause SEMgrSvc  >nul 2>&1
net pause ShellHWDetection >nul 2>&1
net pause shpamsvc  >nul 2>&1
net pause SysMain >nul 2>&1
net pause Themes >nul 2>&1
net pause TrkWks  >nul 2>&1
net pause tzautoupdate >nul 2>&1
net pause uhssvc >nul 2>&1
net pause W3SVC >nul 2>&1
net pause OneSyncSvc >nul 2>&1
net pause WdiSystemHost  >nul 2>&1
net pause WdiServiceHost  >nul 2>&1
net pause SCardSvr  >nul 2>&1
net pause ScDeviceEnum  >nul 2>&1
net pause SCPolicySvc >nul 2>&1
net pause SensorDataService  >nul 2>&1
net pause SensrSvc  >nul 2>&1
net pause Beep >nul 2>&1
net pause cdfs  >nul 2>&1
net pause cdrom  >nul 2>&1
net pause cnghwassist  >nul 2>&1
net pause GpuEnergyDrv  >nul 2>&1
net pause Telemetry  >nul 2>&1
net pause VerifierExt >nul 2>&1
sc config "DiagTrack" start= disabled  >nul 2>&1
sc config "DialogBlockingService" start= disabled  >nul 2>&1
sc config "MsKeyboardFilter" start= disabled  >nul 2>&1
sc config "NetMsmqActivator" start= disabled  >nul 2>&1
sc config "PcaSvc" start= disabled >nul 2>&1
sc config "SEMgrSvc" start= disabled  >nul 2>&1
sc config "ShellHWDetection" start= disabled  >nul 2>&1
sc config "shpamsvc" start= disabled >nul 2>&1
sc config "SysMain" start= disabled  >nul 2>&1
sc config "Themes" start= disabled  >nul 2>&1
sc config "TrkWks" start= disabled  >nul 2>&1
sc config "tzautoupdate" start= disabled  >nul 2>&1
sc config "uhssvc" start= disabled >nul 2>&1
sc config "W3SVC" start= disabled >nul 2>&1
sc config "OneSyncSvc" start= disabled  >nul 2>&1
sc config "WdiSystemHost" start= disabled  >nul 2>&1
sc config "WdiServiceHost" start= disabled  >nul 2>&1
sc config "SCardSvr" start= disabled  >nul 2>&1
sc config "ScDeviceEnum" start= disabled  >nul 2>&1
sc config "SensorDataService" start= disabled  >nul 2>&1
sc config "SensrSvc" start= disabled  >nul 2>&1
sc config "Beep" start= disabled  >nul 2>&1
sc config "cdfs" start= disabled  >nul 2>&1
sc config "cdrom" start= disabled  >nul 2>&1
sc config "cnghwassist" start= disabled >nul 2>&1
sc config "GpuEnergyDrv" start= disabled  >nul 2>&1
sc config "Telemetry" start= disabled  >nul 2>&1
sc config "VerifierExt" start= disabled  >nul 2>&1

rem Set CPU priority for csrss.exe
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\csrss.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "4" /f >nul 2>&1

rem Set I/O priority for csrss.exe
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\csrss.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d "3" /f >nul 2>&1

rem Disable Windows Defender service
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WinDefend" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

rem Disable Security Health Service
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SecurityHealthService" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

rem Disable Windows Defender Network Inspection service
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WdNisSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

rem Disable Windows Defender Advanced Threat Protection service
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Sense" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

rem Disable Windows Security Center service
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\wscsvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

rem Disable Windows Defender features
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableRoutinelyTakingAction" /t REG_DWORD /d "1" /f >nul 2>&1

rem Disable Windows Defender service keep-alive
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "ServiceKeepAlive" /t REG_DWORD /d "0" /f >nul 2>&1

rem Disable Windows Defender Real-Time Protection features
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableBehaviorMonitoring" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableIOAVProtection" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableOnAccessProtection" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRealtimeMonitoring" /t REG_DWORD /d "1" /f >nul 2>&1

rem Disable enhanced notifications from Windows Defender
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Reporting" /v "DisableEnhancedNotifications" /t REG_DWORD /d "1" /f >nul 2>&1

rem Disable notifications from Windows Defender Security Center
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Notifications" /v "DisableNotifications" /t REG_DWORD /d "1" /f >nul 2>&1

rem Disable push notifications for applications
Reg.exe add "HKCU\Software\Policies\Microsoft\Windows\CurrentVersion\PushNotifications" /v "NoToastApplicationNotification" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\Software\Policies\Microsoft\Windows\CurrentVersion\PushNotifications" /v "NoToastApplicationNotificationOnLockScreen" /t REG_DWORD /d "1" /f >nul 2>&1

rem Disable driver searching for Windows Update
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\DriverSearching" /v "SearchOrderConfig" /t REG_DWORD /d "0" /f >nul 2>&1

rem Disable background access for applications
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v "GlobalUserDisabled" /t REG_DWORD /d "1" /f >nul 2>&1

rem Disable Cortana background process
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "BackgroundAppGlobalToggle" /t REG_DWORD /d "0" /f >nul 2>&1

rem Disable Game DVR
Reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v "value" /t REG_DWORD /d "0" /f >nul 2>&1

rem Disable Microsoft Edge pre-launching and preloading
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Main" /v "AllowPrelaunch" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\MicrosoftEdge\TabPreloader" /v "AllowTabPreloading" /t REG_DWORD /d "0" /f >nul 2>&1

rem Disable hibernation
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HibernateEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HibernateEnabledDefault" /t REG_DWORD /d "0" /f >nul 2>&1

rem Set MapsBroker service startup type to "Disabled"
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\MapsBroker" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

rem Disable Windows Notifications Center
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "DisableNotificationCenter" /t REG_DWORD /d "1" /f >nul 2>&1

rem Disable transparency in themes
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "EnableTransparency" /t REG_DWORD /d "0" /f >nul 2>&1

rem Disable Xbox services
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\XblGameSave" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\XboxNetApiSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\XboxGipSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\XblAuthManager" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

rem Disable virtualization-based security
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v "EnableVirtualizationBasedSecurity" /t REG_DWORD /d "0" /f >nul 2>&1

rem Disable automatic maintenance
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v "MaintenanceDisabled" /t REG_DWORD /d "1" /f >nul 2>&1

rem Set Multimedia Class Scheduler Service (MMCSS) startup type to "Disabled"
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\MMCSS" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

rem Disable DmaRemappingCompatible 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\pci\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\rt640x64\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\storahci\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\USBXHCI\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "SystemUsesLightTheme" /t REG_DWORD /d 0 /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d 0 /f

rem Configure task scheduling for games
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Affinity" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Background Only" /t REG_SZ /d "False" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Clock Rate" /t REG_DWORD /d "10000" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d "8" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d "6" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Latency Sensitive" /t REG_SZ /d "True" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control" /v "SvcHostSplitThresholdInKB" /t REG_DWORD /d "67108864" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /t REG_SZ /d "2000" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d "4294967295" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "Affinity" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "Background Only" /t REG_SZ /d "True" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "Clock Rate" /t REG_DWORD /d "10000" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "GPU Priority" /t REG_DWORD /d "8" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "Priority" /t REG_DWORD /d "6" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "Scheduling Category" /t REG_SZ /d "Medium" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "SFIO Priority" /t REG_SZ /d "Normal" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Capture" /v "Affinity" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Capture" /v "Background Only" /t REG_SZ /d "True" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Capture" /v "Clock Rate" /t REG_DWORD /d "10000" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Capture" /v "GPU Priority" /t REG_DWORD /d "8" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Capture" /v "Priority" /t REG_DWORD /d "5" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Capture" /v "Scheduling Category" /t REG_SZ /d "Medium" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Capture" /v "SFIO Priority" /t REG_SZ /d "Normal" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\DisplayPostProcessing" /v "Affinity" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\DisplayPostProcessing" /v "Background Only" /t REG_SZ /d "True" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\DisplayPostProcessing" /v "BackgroundPriority" /t REG_DWORD /d "8" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\DisplayPostProcessing" /v "Clock Rate" /t REG_DWORD /d "10000" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\DisplayPostProcessing" /v "GPU Priority" /t REG_DWORD /d "8" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\DisplayPostProcessing" /v "Priority" /t REG_DWORD /d "8" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\DisplayPostProcessing" /v "Scheduling Category" /t REG_SZ /d "High" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\DisplayPostProcessing" /v "SFIO Priority" /t REG_SZ /d "Normal" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Distribution" /v "Affinity" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Distribution" /v "Background Only" /t REG_SZ /d "True" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Distribution" /v "Clock Rate" /t REG_DWORD /d "10000" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Distribution" /v "GPU Priority" /t REG_DWORD /d "8" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Distribution" /v "Priority" /t REG_DWORD /d "4" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Distribution" /v "Scheduling Category" /t REG_SZ /d "Medium" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Distribution" /v "SFIO Priority" /t REG_SZ /d "Normal" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Playback" /v "Affinity" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Playback" /v "Background Only" /t REG_SZ /d "False" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Playback" /v "BackgroundPriority" /t REG_DWORD /d "4" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Playback" /v "Clock Rate" /t REG_DWORD /d "10000" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Playback" /v "GPU Priority" /t REG_DWORD /d "8" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Playback" /v "Priority" /t REG_DWORD /d "3" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Playback" /v "Scheduling Category" /t REG_SZ /d "Medium" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Playback" /v "SFIO Priority" /t REG_SZ /d "Normal" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Pro Audio" /v "Affinity" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Pro Audio" /v "Background Only" /t REG_SZ /d "False" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Pro Audio" /v "Clock Rate" /t REG_DWORD /d "10000" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Pro Audio" /v "GPU Priority" /t REG_DWORD /d "8" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Pro Audio" /v "Priority" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Pro Audio" /v "Scheduling Category" /t REG_SZ /d "High" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Pro Audio" /v "SFIO Priority" /t REG_SZ /d "Normal" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Window Manager" /v "Affinity" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Window Manager" /v "Background Only" /t REG_SZ /d "True" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Window Manager" /v "Clock Rate" /t REG_DWORD /d "10000" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Window Manager" /v "GPU Priority" /t REG_DWORD /d "8" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Window Manager" /v "Priority" /t REG_DWORD /d "5" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Window Manager" /v "Scheduling Category" /t REG_SZ /d "Medium" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Window Manager" /v "SFIO Priority" /t REG_SZ /d "Normal" /f >nul 2>&1

REM Disable power throttling
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v "PowerThrottlingOff" /t REG_DWORD /d "1" /f >nul 2>&1

REM Disable Game Mode default profile
Reg.exe add "HKCU\System\GameConfigStore" /v "Win32_AutoGameModeDefaultProfile" /t REG_BINARY /d "01000100000000000000000000000000000000000000000000000000000000000000000000000000" /f >nul 2>&1

REM Disable Game Mode related processes
Reg.exe add "HKCU\System\GameConfigStore" /v "Win32_GameModeRelatedProcesses" /t REG_BINARY /d "010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" /f >nul 2>&1

REM Disable various desktop settings
Reg.exe add "HKCU\System\GameConfigStore" /v "GameDVR_HonorUserFSEBehaviorMode" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKCU\System\GameConfigStore" /v "GameDVR_DXGIHonorFSEWindowsCompatible" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Desktop" /v "MenuShowDelay" /t REG_SZ /d "0" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Desktop" /v "WaitToKillAppTimeout" /t REG_SZ /d "5000" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Desktop" /v "HungAppTimeout" /t REG_SZ /d "4000" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Desktop" /v "AutoEndTasks" /t REG_SZ /d "1" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Desktop" /v "LowLevelHooksTimeout" /t REG_DWORD /d "4096" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Desktop" /v "WaitToKillServiceTimeout" /t REG_DWORD /d "8192" /f >nul 2>&1

REM Modify power settings
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\943c8cb6-6f93-4227-ad87-e9a3feec08d1" /v "Attributes" /t REG_DWORD /d "2" /f >nul 2>&1

REM Modify power scheme settings
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\2a737441-1930-4402-8d77-b2bebba308a3\d4e98f31-5ffe-4ce1-be31-1b38b384c009\DefaultPowerSchemeValues\381b4222-f694-41f0-9685-ff5bb260df2e" /v "ACSettingIndex" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\2a737441-1930-4402-8d77-b2bebba308a3\d4e98f31-5ffe-4ce1-be31-1b38b384c009\DefaultPowerSchemeValues\381b4222-f694-41f0-9685-ff5bb260df2e" /v "DCSettingIndex" /t REG_DWORD /d "0" /f >nul 2>&1

rem Set ACSettingIndex to 0 for specific power scheme
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\2a737441-1930-4402-8d77-b2bebba308a3\d4e98f31-5ffe-4ce1-be31-1b38b384c009\DefaultPowerSchemeValues\8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c" /v "ACSettingIndex" /t REG_DWORD /d "0" /f >nul 2>&1

rem Set ACSettingIndex to 0 for another power scheme
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\3b04d4fd-1cc7-4f23-ab1c-d1337819c4bb\DefaultPowerSchemeValues\381b4222-f694-41f0-9685-ff5bb260df2e" /v "ACSettingIndex" /t REG_DWORD /d "0" /f >nul 2>&1

rem Set DCSettingIndex to 0 for the same power scheme
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\3b04d4fd-1cc7-4f23-ab1c-d1337819c4bb\DefaultPowerSchemeValues\381b4222-f694-41f0-9685-ff5bb260df2e" /v "DCSettingIndex" /t REG_DWORD /d "0" /f >nul 2>&1

rem Set ACSettingIndex to 0 for the same power scheme again
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\3b04d4fd-1cc7-4f23-ab1c-d1337819c4bb\DefaultPowerSchemeValues\8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c" /v "ACSettingIndex" /t REG_DWORD /d "0" /f >nul 2>&1

rem Disable TrackNblOwner in NDIS Parameters
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\NDIS\Parameters" /v "TrackNblOwner" /t REG_DWORD /d "0" /f >nul 2>&1

rem Enable NoLazyMode in Multimedia SystemProfile
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NoLazyMode" /t REG_DWORD /d "1" /f >nul 2>&1

rem Enable Latency Sensitive for DisplayPostProcessing task
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\DisplayPostProcessing" /v "Latency Sensitive" /t REG_SZ /d "True" /f >nul 2>&1

rem Set Attributes to 2 for a specific power setting
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\943c8cb6-6f93-4227-ad87-e9a3feec08d1" /v "Attributes" /t REG_SZ /d "2" /f >nul 2>&1

rem Disable SilentInstalledAppsEnabled in ContentDeliveryManager
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d "0" /f >nul 2>&1

rem Disable SoftLandingEnabled in ContentDeliveryManager
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SoftLandingEnabled" /t REG_DWORD /d "0" /f >nul 2>&1

rem Disable RotatingLockScreenOverlayEnabled in ContentDeliveryManager
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenOverlayEnabled" /t REG_DWORD /d "0" /f >nul 2>&1

rem Disable SystemPaneSuggestionsEnabled in ContentDeliveryManager
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d "0" /f >nul 2>&1

rem Disable ShowSyncProviderNotifications in Explorer Advanced settings
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSyncProviderNotifications" /t REG_DWORD /d "0" /f >nul 2>&1

rem Disable RotatingLockScreenEnabled in ContentDeliveryManager
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenEnabled" /t REG_DWORD /d "0" /f >nul 2>&1

rem Disable SubscribedContent-310093Enabled in ContentDeliveryManager
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-310093Enabled" /t REG_DWORD /d "0" /f >nul 2>&1

rem Disable Flags for various Accessibility settings
Reg.exe add "HKCU\Control Panel\Accessibility\MouseKeys" /v "Flags" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Accessibility\StickyKeys" /v "Flags" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Accessibility\Keyboard Response" /v "Flags" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Accessibility\ToggleKeys" /v "Flags" /t REG_DWORD /d "0" /f >nul 2>&1


REM Disable commercial data pipeline.
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /F /V "AllowCommercialDataPipeline" /T REG_DWORD /d 0  >nul 2>&1

REM Disable desktop analytics processing.
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /F /V "AllowDesktopAnalyticsProcessing" /T REG_DWORD /d 0  >nul 2>&1

REM Disable device name in telemetry.
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /F /V "AllowDeviceNameInTelemetry" /T REG_DWORD /d 0  >nul 2>&1

REM Disable telemetry data collection.
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /F /V "AllowTelemetry" /T REG_DWORD /d 0  >nul 2>&1

REM Disable update compliance processing.
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /F /V "AllowUpdateComplianceProcessing" /T REG_DWORD /d 0  >nul 2>&1

REM Disable Windows Update for Business cloud processing.
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /F /V "AllowWUfBCloudProcessing" /T REG_DWORD /d 0  >nul 2>&1

REM Disable enterprise authentication proxy.
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /F /V "DisableEnterpriseAuthProxy" /T REG_DWORD /d 1  >nul 2>&1


REM Disable Microsoft Edge data opt-in.
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /F /V "MicrosoftEdgeDataOptIn" /T REG_DWORD /d 0  >nul 2>&1

REM Disable telemetry opt-in change notification.
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /F /V "DisableTelemetryOptInChangeNotification" /T REG_DWORD /d 1  >nul 2>&1

REM Disable telemetry opt-in settings UX.
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /F /V "DisableTelemetryOptInSettingsUx" /T REG_DWORD /d 1  >nul 2>&1

REM Disable Diagnostic Data Viewer.
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /F /V "DisableDiagnosticDataViewer" /T REG_DWORD /d 1  >nul 2>&1

REM Disable configuration flighting.
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /F /V "EnableConfigFlighting" /T REG_DWORD /d 0  >nul 2>&1

REM Do not show feedback notifications.
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /F /V "DoNotShowFeedbackNotifications" /T REG_DWORD /d 1  >nul 2>&1

REM Limit enhanced diagnostic data for Windows Analytics.
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /F /V "LimitEnhancedDiagnosticDataWindowsAnalytics" /T REG_DWORD /d 0  >nul 2>&1

REM Deny location access for specific capabilities.
Reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" /F /V "Value" /T REG_SZ /d "Deny" >nul 2>&1

REM Disable location and sensors.
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /F /V "DisableLocation" /T REG_DWORD /d 1  >nul 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /F /V "DisableLocationScripting" /T REG_DWORD /d 1  >nul 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /F /V "DisableSensors" /T REG_DWORD /d 1  >nul 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /F /V "DisableWindowsLocationProvider" /T REG_DWORD /d 1  >nul 2>&1

REM Disable auto download and update of map data.
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Maps" /F /V "AutoDownloadAndUpdateMapData" /T REG_DWORD /d 0  >nul 2>&1

REM Disable untriggered network traffic on Maps settings page.
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Maps" /F /V "AllowUntriggeredNetworkTrafficOnSettingsPage" /T REG_DWORD /d 0  >nul 2>&1

REM Deny capability access for specific apps.
Reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics" /F /V "Value" /T REG_SZ /d "Deny"  >nul 2>&1
Reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appointments" /F /V "Value" /T REG_SZ /d "Deny"  >nul 2>&1
Reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\email" /F /V "Value" /T REG_SZ /d "Deny"  >nul 2>&1
Reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCall" /F /V "Value" /T REG_SZ /d "Deny"  >nul 2>&1
Reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userDataTasks" /F /V "Value" /T REG_SZ /d "Deny"  >nul 2>&1
Reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\chat" /F /V "Value" /T REG_SZ /d "Deny"  >nul 2>&1
Reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\contacts" /F /V "Value" /T REG_SZ /d "Deny"  >nul 2>&1


REM Disable message synchronization.
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Messaging" /F /V "AllowMessageSync" /T REG_DWORD /d 0  >nul 2>&1

REM Disable active help.
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Assistance\Client\1.0" /F /V "NoActiveHelp" /T REG_DWORD /d 1  >nul 2>&1

REM Disable web search in Windows Search.
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /F /V "DisableWebSearch" /T REG_DWORD /d 1  >nul 2>&1

REM Disable removable drive indexing in Windows Search.
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /F /V "DisableRemovableDriveIndexing" /T REG_DWORD /d 1  >nul 2>&1

REM Disable Cortana above lock screen.
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /F /V "AllowCortanaAboveLock" /T REG_DWORD /d 0  >nul 2>&1

REM Disable cloud search.
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /F /V "AllowCloudSearch" /T REG_DWORD /d 0  >nul 2>&1

REM Disable search using location.
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /F /V "AllowSearchToUseLocation" /T REG_DWORD /d 0  >nul 2>&1

REM Disable connected search using the web.
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /F /V "ConnectedSearchUseWeb" /T REG_DWORD /d 0  >nul 2>&1

REM Disable safe search mode.
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings" /F /V "SafeSearchMode" /T REG_DWORD /d 0  >nul 2>&1

REM Disable device search history.
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\SearchSettings" /F /V "IsDeviceSearchHistoryEnabled" /T REG_DWORD /d 0  >nul 2>&1

REM Disable speech model update.
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Speech" /F /V "AllowSpeechModelUpdate" /T REG_DWORD /d 0  >nul 2>&1

REM Disable application setting sync.
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /F /V "DisableApplicationSettingSync" /T REG_DWORD /d 2  >nul 2>&1

REM Disable app sync setting sync.
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /F /V "DisableAppSyncSettingSync" /T REG_DWORD /d 2  >nul 2>&1

REM Disable web browser setting sync.
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /F /V "DisableWebBrowserSettingSync" /T REG_DWORD /d 2  >nul 2>&1

REM Disable desktop theme setting sync.
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /F /V "DisableDesktopThemeSettingSync" /T REG_DWORD /d 2  >nul 2>&1

REM Disable general setting sync.
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /F /V "DisableSettingSync" /T REG_DWORD /d 2  >nul 2>&1

REM Disable sync on paid network.
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /F /V "DisableSyncOnPaidNetwork" /T REG_DWORD /d 1  >nul 2>&1

REM Disable Windows setting sync.
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /F /V "DisableWindowsSettingSync" /T REG_DWORD /d 2  >nul 2>&1

REM Disable credentials setting sync.
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /F /V "DisableCredentialsSettingSync" /T REG_DWORD /d 2  >nul 2>&1

REM Disable personalization setting sync.
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /F /V "DisablePersonalizationSettingSync" /T REG_DWORD /d 2  >nul 2>&1

REM Disable start layout setting sync.
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /F /V "DisableStartLayoutSettingSync" /T REG_DWORD /d 2  >nul 2>&1

REM Disable subscribed content.
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338389Enabled" /t REG_DWORD /f /d 0  >nul 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-314563Enabled" /t REG_DWORD /f /d 0  >nul 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-310093Enabled" /t REG_DWORD /f /d 0  >nul 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353698Enabled" /t REG_DWORD /f /d 0  >nul 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338393Enabled" /t REG_DWORD /f /d 0  >nul 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353696Enabled" /t REG_DWORD /f /d 0  >nul 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353694Enabled" /t REG_DWORD /f /d 0  >nul 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /f /d 0  >nul 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338387Enabled" /t REG_DWORD /f /d 0  >nul 2>&1

REM Disable silent installed apps.
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /f /d 0  >nul 2>&1

REM Disable system pane suggestions.
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /f /d 0  >nul 2>&1

REM Disable soft landing.
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SoftLandingEnabled" /t REG_DWORD /f /d 0  >nul 2>&1

REM Disable rotating lock screen.
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenEnabled" /t REG_DWORD /f /d 0  >nul 2>&1

REM Disable rotating lock screen overlay.
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenOverlayEnabled" /t REG_DWORD /f /d 0  >nul 2>&1

REM Disable touch input.
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\TabletPC" /F /V "TurnOffTouchInput" /T REG_DWORD /d 1  >nul 2>&1

REM Disable panning.
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\TabletPC" /F /V "TurnOffPanning" /T REG_DWORD /d 1  >nul 2>&1

REM Disable linguistic data collection.
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\TextInput" /F /V "AllowLinguisticDataCollection" /T REG_DWORD /d 0  >nul 2>&1

REM Disable Windows Ink Workspace.
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsInkWorkspace" /F /V "AllowWindowsInkWorkspace" /T REG_DWORD /d 0   >nul 2>&1

REM Set priority of javaw.exe process to "realtime".
wmic process where name="javaw.exe" CALL setpriority "realtime"  >nul 2>&1

REM Set priority of svchost.exe process to "realtime".
wmic process where name="svchost.exe" CALL setpriority "realtime"  >nul 2>&1

REM Disable energy estimation.
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "EnergyEstimationEnabled" /t REG_DWORD /d 0 /f         >nul 2>&1

REM Disable CPU power saving features.
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CsEnabled" /t REG_DWORD /d 0 /f       >nul 2>&1

REM Disable performance calculation of actual utilization.
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "PerfCalculateActualUtilization" /t REG_DWORD /d 0 /f         >nul 2>&1        

REM Disable detailed sleep reliability diagnostics.
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "SleepReliabilityDetailedDiagnostics" /t REG_DWORD /d 0 /f  >nul 2>&1        

REM Disable event processor.
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "EventProcessorEnabled" /t REG_DWORD /d 0 /f    >nul 2>&1      

REM Disable QoS management of idle processors.
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "QosManagesIdleProcessors" /t REG_DWORD /d 0 /f  >nul 2>&1     

REM Disable vsync latency update.
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DisableVsyncLatencyUpdate" /t REG_DWORD /d 1 /f  >nul 2>&1 

REM Disable sensor watchdog.
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DisableSensorWatchdog" /t REG_DWORD /d 1 /f    >nul 2>&1

REM Adjust TdrLevel (Timeout Detection and Recovery) for graphics drivers.
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrLevel" /t REG_DWORD /d 0 /f        >nul 2>&1 

REM Disable TdrDebugMode for graphics drivers.
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDebugMode" /t REG_DWORD /d 0 /f  >nul 2>&1

REM Adjust Cursor Magnetism update interval.
reg.exe add "HKLM\SOFTWARE\Microsoft\Input\Settings\ControllerProcessor\CursorMagnetism" /v "MagnetismUpdateIntervalInMilliseconds" /t REG_DWORD /d 1 /f        >nul 2>&1   

REM Adjust Cursor Speed update interval.
reg.exe add "HKLM\SOFTWARE\Microsoft\Input\Settings\ControllerProcessor\CursorSpeed" /v "CursorUpdateInterval" /t REG_DWORD /d 1 /f   >nul 2>&1

REM Disable location services
reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocation" /t REG_DWORD /d 1 /f          >nul 2>&1      
reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocationScripting" /t REG_DWORD /d 1 /f    >nul 2>&1   
reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableSensors" /t REG_DWORD /d 1 /f           >nul 2>&1      
reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableWindowsLocationProvider" /t REG_DWORD /d 1 /f   >nul 2>&1

REM Disable external DMA under lock for FVE (BitLocker)
reg add "HKLM\SOFTWARE\Policies\Microsoft\FVE" /v "DisableExternalDMAUnderLock" /t REG_DWORD /d "0" /f> nul 2>&1

REM Disable HVCIMAT (Hypervisor Code Integrity) requirement for Device Guard.
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v "HVCIMATRequired" /t REG_DWORD /d "0" /f >nul 2>&1

REM Disable exception chain validation in kernel.
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "DisableExceptionChainValidation" /t REG_DWORD /d "1" /f >nul 2>&1

REM Disable KernelSEHOP (Structured Exception Handling Overwrite Protection) in kernel.
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "KernelSEHOPEnabled" /t REG_DWORD /d "0" /f >nul 2>&1

REM Disable Control Flow Guard (CFG).
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "EnableCfg" /t REG_DWORD /d "0" /f > nul 2>&1

REM Disable Protection Mode.
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "ProtectionMode" /t REG_DWORD /d "0" /f >nul 2>&1

REM Set FeatureSettings and FeatureSettingsOverride for Memory Management.
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettings" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverride" /t REG_DWORD /d "3" /f >nul 2>&1

REM Configure Boot
bcdedit /set useplatformclock No  >nul 2>&1
bcdedit /set useplatformtick No  >nul 2>&1
bcdedit /set disabledynamictick Yes  >nul 2>&1
bcdedit /set forcelegacyplatform No  >nul 2>&1
bcdedit /set tscsyncpolicy Enhanced  >nul 2>&1
bcdedit /set avoidlowmemory 0x8000000  >nul 2>&1
bcdedit /set firstmegabytepolicy UseAll  >nul 2>&1
bcdedit /set nolowmem Yes  >nul 2>&1
bcdedit /set isolatedcontext No  >nul 2>&1
bcdedit /set x2apicpolicy Enable >nul 2>&1
bcdedit /set usephysicaldestination No  >nul 2>&1
bcdedit /set linearaddress57 OptOut  >nul 2>&1
bcdedit /set noumex Yes  >nul 2>&1
bcdedit /set perfmem 0 >nul 2>&1
bcdedit /set clustermodeaddressing 1 >nul 2>&1
bcdedit /set configflags 0  >nul 2>&1
bcdedit /set uselegacyapicmode No >nul 2>&1
bcdedit /set disableelamdrivers Yes >nul 2>&1
bcdedit /set vsmlaunchtype Off >nul 2>&1
bcdedit /set ems No >nul 2>&1
bcdedit /set extendedinput Yes  >nul 2>&1
bcdedit /set highestmode Yes >nul 2>&1
bcdedit /set forcefipscrypto No >nul 2>&1
bcdedit /set sos Yes >nul 2>&1
bcdedit /set pae ForceEnable >nul 2>&1
bcdedit /set debug No >nul 2>&1
bcdedit /set hypervisorlaunchtype Off >nul 2>&1

REM Delete micro code
takeown /f "C:\Windows\System32\mcupdate_GenuineIntel.dll" /r /d y  >nul 2>&1
takeown /f "C:\Windows\System32\mcupdate_AuthenticAMD.dll" /r /d y  >nul 2>&1
del "C:\Windows\System32\mcupdate_GenuineIntel.dll" /s /f /q  >nul 2>&1
del "C:\Windows\System32\mcupdate_AuthenticAMD.dll" /s /f /q  >nul 2>&1

REM Disable Sleep Study.
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "SleepStudyDisabled" /t REG_DWORD /d "1" /f >nul 2>&1

REM Enable preemption in graphics drivers.
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnablePreemption" /f >nul 2>&1

REM Disable Data Execution Prevention (DEP) for Internet Explorer.
reg add "HKLM\SOFTWARE\Policies\Microsoft\Internet Explorer\Main" /v "DEPOff" /t REG_DWORD /d "1" /f >nul 2>&1

REM Disable maintenance tasks.
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v "MaintenanceDisabled" /t REG_DWORD /d "1" /f >nul 2>&1

REM Disable timer distribution.
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "DistributeTimers" /t REG_DWORD /d "0" /f >nul 2>&1

REM Disable paging of executive code.
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "DisablePagingExecutive" /t REG_DWORD /d "1" /f >nul 2>&1

REM Enable contiguous DPI mapping for graphics drivers.
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "DpiMapIommuContiguous" /t REG_DWORD /d "1" /f >nul 2>&1

REM Disable Fault Tolerant Heap.
reg add "HKLM\SOFTWARE\Microsoft\FTH" /v "Enabled" /t REG_DWORD /d "0" /f >nul 2>&1

REM Disable image move.
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "MoveImages" /t REG_DWORD /d "0" /f  >nul 2>&1

REM Set hardware scheduling mode for graphics drivers.
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchedMode" /t REG_DWORD /d "2" /f >nul 2>&1

REM Enable timer distribution.
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "DistributeTimers" /t REG_DWORD /d "1" /f >nul 2>&1

REM Set MenuShowDelay to 0 for faster menus.
reg add "HKCU\Control Panel\Desktop" /v "MenuShowDelay" /t REG_DWORD /d "0" /f >nul 2>&1

REM Set GPU energy driver startup mode.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\GpuEnergyDrv" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\GpuEnergyDr" /v "Start" /t REG_DWORD /d "4" /f  >nul 2>&1

REM Adjust reliability and performance settings.
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Reliability" /v "TimeStampInterval" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Reliability" /v "IoPriority" /t REG_DWORD /d "3" /f >nul 2>&1

REM Modify performance options for specific processes.
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\csrss.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\csrss.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d "3" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d "10" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\I/O System" /v "PassiveIntRealTimeWorkerPriority" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\KernelVelocity" /v "DisableFGBoostDecay" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\dwm.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "4" /f  >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\dwm.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d "3" /f  >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\lsass.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\lsass.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d "0" /f  >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\lsass.exe\PerfOptions" /v "PagePriority" /t REG_DWORD /d "0" /f  >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ntoskrnl.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "4" /f  >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ntoskrnl.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d "3" /f  >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SearchIndexer.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SearchIndexer.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d "0" /f  >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\svchost.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f  >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\TrustedInstaller.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\TrustedInstaller.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d "0" /f  >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\wuauclt.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f  >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\wuauclt.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d "0" /f  >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\audiodg.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\audiodg.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "2" /f  >nul 2>&1
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\dwm.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\dwm.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d "3" /f  >nul 2>&1
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\lsass.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\lsass.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d "0" /f  >nul 2>&1
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\lsass.exe\PerfOptions" /v "PagePriority" /t REG_DWORD /d "0" /f  >nul 2>&1
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ntoskrnl.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "4" /f  >nul 2>&1
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ntoskrnl.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d "3" /f  >nul 2>&1
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SearchIndexer.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f  >nul 2>&1
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SearchIndexer.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d "0" /f  >nul 2>&1
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\TrustedInstaller.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f  >nul 2>&1
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\TrustedInstaller.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d "0" /f  >nul 2>&1
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\wuauclt.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f  >nul 2>&1
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\wuauclt.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d "0" /f >nul 2>&1

REM Disable generic reporting for Windows Defender.
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Reporting" /v "DisableGenericReports" /t REG_DWORD /d "1" /f  >nul 2>&1

REM Disable reporting of infection information for Windows Defender.
reg add "HKLM\SOFTWARE\Policies\Microsoft\MRT" /v "DontReportInfectionInformation" /t REG_DWORD /d "1" /f  >nul 2>&1

REM Configure Windows Defender Spynet settings.
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v "LocalSettingOverrideSpynetReporting" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v "SpynetReporting" /t REG_DWORD /d "0" /f  >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v "SubmitSamplesConsent" /t REG_DWORD /d "2" /f  >nul 2>&1

REM Disable SmartScreen for app installations.
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t REG_DWORD /d "0" /f  >nul 2>&1

REM Disable Phishing Filter in Microsoft Edge.
reg add "HKLM\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter" /v "EnabledV9" /t REG_DWORD /d "0" /f  >nul 2>&1

REM Disable Windows Defender's routine actions.
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableRoutinelyTakingAction" /t REG_DWORD /d "1" /f  >nul 2>&1

REM Disable Windows Defender's service keep-alive mechanism.
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "ServiceKeepAlive" /t REG_DWORD /d "0" /f  >nul 2>&1

REM Disable real-time monitoring of Windows Defender.
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRealtimeMonitoring" /t REG_DWORD /d "1" /f  >nul 2>&1

REM Disable enhanced notifications in Windows Defender reporting.
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Reporting" /v "DisableEnhancedNotifications" /t REG_DWORD /d "1" /f  >nul 2>&1

REM Disable Configure App Install Control in Windows Defender SmartScreen.
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\SmartScreen" /v "ConfigureAppInstallControlEnabled" /t REG_DWORD /d "0" /f  >nul 2>&1

REM Set default actions for various threat severities in Windows Defender.
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Threats" /v "Threats_ThreatSeverityDefaultAction" /t REG_DWORD /d "1" /f  >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Threats\ThreatSeverityDefaultAction" /v "1" /t REG_SZ /d "6" /f  >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Threats\ThreatSeverityDefaultAction" /v "2" /t REG_SZ /d "6" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Threats\ThreatSeverityDefaultAction" /v "4" /t REG_SZ /d "6" /f  >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Threats\ThreatSeverityDefaultAction" /v "5" /t REG_SZ /d "6" /f  >nul 2>&1

REM Suppress notifications from Windows Defender UX Configuration.
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\UX Configuration" /v "Notification_Suppress" /t REG_DWORD /d "1" /f  >nul 2>&1

REM Set CPU priority class for MsMpEng.exe (Windows Defender service).
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MsMpEng.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f >nul 2>&1

REM Set CPU priority class for MsMpEngCP.exe (Windows Defender service companion).
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MsMpEngCP.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f  >nul 2>&1

REM Set startup modes for Windows Defender services.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Sense" /v "Start" /t REG_DWORD /d "4" /f  >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WdNisSvc" /v "Start" /t REG_DWORD /d "4" /f  >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WinDefend" /v "Start" /t REG_DWORD /d "4" /f  >nul 2>&1



REM Disable Game DVR (Screen Recording) feature.
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v "value" /t REG_DWORD /d "0" /f  >nul 2>&1

REM Configure monitor latency tolerance for DXGKrnl service.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DXGKrnl" /v "MonitorLatencyTolerance" /t REG_DWORD /d "1" /f  >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DXGKrnl" /v "MonitorRefreshLatencyTolerance" /t REG_DWORD /d "1" /f >nul 2>&1

REM Configure exit latency and tolerance settings for power management.
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatency" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatencyCheckEnabled" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "Latency" /t REG_DWORD /d "1" /f  >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceDefault" /t REG_DWORD /d "1" /f  >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceFSVP" /t REG_DWORD /d "1" /f  >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyTolerancePerfOverride" /t REG_DWORD /d "1" /f  >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceScreenOffIR" /t REG_DWORD /d "1" /f  >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceVSyncEnabled" /t REG_DWORD /d "1" /f  >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "RtlCapabilityCheckLatency" /t REG_DWORD /d "1" /f >nul 2>&1

REM Configure default D3 transition latency tolerance settings for graphics
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyActivelyUsed" /t REG_DWORD /d "1" /f  >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleLongTime" /t REG_DWORD /d "1" /f  >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleMonitorOff" /t REG_DWORD /d "1" /f  >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleNoContext" /t REG_DWORD /d "1" /f  >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleShortTime" /t REG_DWORD /d "1" /f  >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleVeryLongTime" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceIdle0" /t REG_DWORD /d "1" /f  >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceIdle0MonitorOff" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceIdle1" /t REG_DWORD /d "1" /f  >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceIdle1MonitorOff" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceMemory" /t REG_DWORD /d "1" /f  >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceNoContext" /t REG_DWORD /d "1" /f  >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceNoContextMonitorOff" /t REG_DWORD /d "1" /f  >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceOther" /t REG_DWORD /d "1" /f  >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceTimerPeriod" /t REG_DWORD /d "1" /f  >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultMemoryRefreshLatencyToleranceActivelyUsed" /t REG_DWORD /d "1" /f  >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultMemoryRefreshLatencyToleranceMonitorOff" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultMemoryRefreshLatencyToleranceNoContext" /t REG_DWORD /d "1" /f  >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "Latency" /t REG_DWORD /d "1" /f  >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "MaxIAverageGraphicsLatencyInOneBucket" /t REG_DWORD /d "1" /f  >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "MiracastPerfTrackGraphicsLatency" /t REG_DWORD /d "1" /f  >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "MonitorLatencyTolerance" /t REG_DWORD /d "1" /f  >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "MonitorRefreshLatencyTolerance" /t REG_DWORD /d "1" /f  >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "TransitionLatency" /t REG_DWORD /d "1" /f >nul 2>&1

REM Configure priority, scheduling, and importance policies.
reg add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\CPU\HardCap0" /v "CapPercentage" /t REG_DWORD /d "0" /f  >nul 2>&1
reg add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\CPU\HardCap0" /v "SchedulingType" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\CPU\Paused" /v "CapPercentage" /t REG_DWORD /d "0" /f  >nul 2>&1
reg add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\CPU\Paused" /v "SchedulingType" /t REG_DWORD /d "0" /f  >nul 2>&1
reg add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\CPU\SoftCapFull" /v "CapPercentage" /t REG_DWORD /d "0" /f  >nul 2>&1
reg add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\CPU\SoftCapFull" /v "SchedulingType" /t REG_DWORD /d "0" /f  >nul 2>&1
reg add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\CPU\SoftCapLow" /v "CapPercentage" /t REG_DWORD /d "0" /f  >nul 2>&1
reg add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\CPU\SoftCapLow" /v "SchedulingType" /t REG_DWORD /d "0" /f  >nul 2>&1

REM Configure priority flags and importance settings.
reg add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Flags\BackgroundDefault" /v "IsLowPriority" /t REG_DWORD /d "0" /f  >nul 2>&1
reg add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Flags\Frozen" /v "IsLowPriority" /t REG_DWORD /d "0" /f  >nul 2>&1
reg add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Flags\FrozenDNCS" /v "IsLowPriority" /t REG_DWORD /d "0" /f  >nul 2>&1
reg add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Flags\FrozenDNK" /v "IsLowPriority" /t REG_DWORD /d "0" /f  >nul 2>&1
reg add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Flags\FrozenPPLE" /v "IsLowPriority" /t REG_DWORD /d "0" /f  >nul 2>&1
reg add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Flags\Paused" /v "IsLowPriority" /t REG_DWORD /d "0" /f  >nul 2>&1
reg add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Flags\PausedDNK" /v "IsLowPriority" /t REG_DWORD /d "0" /f  >nul 2>&1
reg add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Flags\Pausing" /v "IsLowPriority" /t REG_DWORD /d "0" /f  >nul 2>&1
reg add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Flags\PrelaunchForeground" /v "IsLowPriority" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Flags\ThrottleGPUInterference" /v "IsLowPriority" /t REG_DWORD /d "0" /f  >nul 2>&1

REM Configure importance policies.
reg add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Importance\Critical" /v "BasePriority" /t REG_DWORD /d "82" /f  >nul 2>&1
reg add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Importance\Critical" /v "OverTargetPriority" /t REG_DWORD /d "50" /f  >nul 2>&1
reg add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Importance\CriticalNoUi" /v "BasePriority" /t REG_DWORD /d "82" /f  >nul 2>&1
reg add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Importance\CriticalNoUi" /v "OverTargetPriority" /t REG_DWORD /d "50" /f  >nul 2>&1
reg add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Importance\EmptyHostPPLE" /v "BasePriority" /t REG_DWORD /d "82" /f  >nul 2>&1
reg add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Importance\EmptyHostPPLE" /v "OverTargetPriority" /t REG_DWORD /d "50" /f  >nul 2>&1
reg add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Importance\High" /v "BasePriority" /t REG_DWORD /d "82" /f  >nul 2>&1
reg add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Importance\High" /v "OverTargetPriority" /t REG_DWORD /d "50" /f  >nul 2>&1
reg add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Importance\Low" /v "BasePriority" /t REG_DWORD /d "82" /f >nul 2>&1
reg add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Importance\Low" /v "OverTargetPriority" /t REG_DWORD /d "50" /f  >nul 2>&1
reg add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Importance\Lowest" /v "BasePriority" /t REG_DWORD /d "82" /f  >nul 2>&1
reg add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Importance\Lowest" /v "OverTargetPriority" /t REG_DWORD /d "50" /f  >nul 2>&1
reg add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Importance\Medium" /v "BasePriority" /t REG_DWORD /d "82" /f  >nul 2>&1
reg add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Importance\Medium" /v "OverTargetPriority" /t REG_DWORD /d "50" /f  >nul 2>&1
reg add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Importance\MediumHigh" /v "BasePriority" /t REG_DWORD /d "82" /f  >nul 2>&1
reg add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Importance\MediumHigh" /v "OverTargetPriority" /t REG_DWORD /d "50" /f  >nul 2>&1
reg add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Importance\StartHost" /v "BasePriority" /t REG_DWORD /d "82" /f  >nul 2>&1
reg add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Importance\StartHost" /v "OverTargetPriority" /t REG_DWORD /d "50" /f  >nul 2>&1
reg add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Importance\VeryHigh" /v "BasePriority" /t REG_DWORD /d "82" /f  >nul 2>&1
reg add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Importance\VeryHigh" /v "OverTargetPriority" /t REG_DWORD /d "50" /f  >nul 2>&1
reg add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Importance\VeryLow" /v "BasePriority" /t REG_DWORD /d "82" /f  >nul 2>&1
reg add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Importance\VeryLow" /v "OverTargetPriority" /t REG_DWORD /d "50" /f  >nul 2>&1

REM Configure CPU, memory, and I/O policies.
reg add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\IO\NoCap" /v "IOBandwidth" /t REG_DWORD /d "0" /f  >nul 2>&1
reg add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Memory\NoCap" /v "CommitLimit" /t REG_DWORD /d "4294967295" /f  >nul 2>&1
reg add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Memory\NoCap" /v "CommitTarget" /t REG_DWORD /d "4294967295" /f  >nul 2>&1


REM Disable DMA Remapping Compatibility for various services.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\rdyboost\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\pci\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\kbdhid\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\NdisWan\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\EhStorClass\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\HDAudBus\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\partmgr\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\ACPI\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\acpipagr\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\BasicDisplay\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\BasicRender\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\CompositeBus\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\dc1-controller\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\MEIx64\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Monitor\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\mouhid\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\msisadrv\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\NdisVirtualBus\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\NvModuleTracker\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\storahci\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\umbus\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB3\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\USBXHCI\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\vdrvroot\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\vwifibus\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WpdUpFItr\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WUDFWpdFs\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\xinputhid\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f >nul 2>&1

REM Configure Win32PrioritySeparation for process prioritization.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d "38" /f >nul 2>&1

REM Remove specifi AppxPackage apps
PowerShell -Command "Get-AppxPackage -allusers *3DBuilder* | Remove-AppxPackage" >nul 2>&1
PowerShell -Command "Get-AppxPackage -allusers *bing* | Remove-AppxPackage" >nul 2>&1
PowerShell -Command "Get-AppxPackage -allusers *bingfinance* | Remove-AppxPackage" >nul 2>&1
PowerShell -Command "Get-AppxPackage -allusers *bingsports* | Remove-AppxPackage" >nul 2>&1
PowerShell -Command "Get-AppxPackage -allusers *BingWeather* | Remove-AppxPackage" >nul 2>&1
PowerShell -Command "Get-AppxPackage -allusers *CommsPhone* | Remove-AppxPackage" >nul 2>&1
PowerShell -Command "Get-AppxPackage -allusers *Drawboard PDF* | Remove-AppxPackage" >nul 2>&1
PowerShell -Command "Get-AppxPackage -allusers *Facebook* | Remove-AppxPackage" >nul 2>&1
PowerShell -Command "Get-AppxPackage -allusers *Getstarted* | Remove-AppxPackage" >nul 2>&1
PowerShell -Command "Get-AppxPackage -allusers *Microsoft.Messaging* | Remove-AppxPackage" >nul 2>&1
PowerShell -Command "Get-AppxPackage -allusers *MicrosoftOfficeHub* | Remove-AppxPackage" >nul 2>&1
PowerShell -Command "Get-AppxPackage -allusers *Office.OneNote* | Remove-AppxPackage" >nul 2>&1
PowerShell -Command "Get-AppxPackage -allusers *OneNote* | Remove-AppxPackage" >nul 2>&1
PowerShell -Command "Get-AppxPackage -allusers *people* | Remove-AppxPackage" >nul 2>&1
PowerShell -Command "Get-AppxPackage -allusers *SkypeApp* | Remove-AppxPackage" >nul 2>&1
PowerShell -Command "Get-AppxPackage -allusers *solit* | Remove-AppxPackage" >nul 2>&1
PowerShell -Command "Get-AppxPackage -allusers *Sway* | Remove-AppxPackage" >nul 2>&1
PowerShell -Command "Get-AppxPackage -allusers *Twitter* | Remove-AppxPackage" >nul 2>&1
PowerShell -Command "Get-AppxPackage -allusers *WindowsAlarms* | Remove-AppxPackage" >nul 2>&1
PowerShell -Command "Get-AppxPackage -allusers *WindowsPhone* | Remove-AppxPackage" >nul 2>&1
PowerShell -Command "Get-AppxPackage -allusers *WindowsMaps* | Remove-AppxPackage" >nul 2>&1
PowerShell -Command "Get-AppxPackage -allusers *WindowsFeedbackHub* | Remove-AppxPackage" >nul 2>&1
PowerShell -Command "Get-AppxPackage -allusers *WindowsSoundRecorder* | Remove-AppxPackage" >nul 2>&1
PowerShell -Command "Get-AppxPackage -allusers *windowscommunicationsapps* | Remove-AppxPackage">nul 2>&1
PowerShell -Command "Get-AppxPackage -allusers *zune* | Remove-AppxPackage" >nul 2>&1

REM Configure Sysinternals Process Explorer settings.
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "EulaAccepted" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "Windowplacement" /t REG_BINARY /d "2c0000000200000003000000ffffffffffffffffffffffffffffffff75030000110000009506000069020000" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "FindWindowplacement" /t REG_BINARY /d "2c00000000000000000000000000000000000000000000000000000096000000960000000000000000000000" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "SysinfoWindowplacement" /t REG_BINARY /d "2c00000000000000010000000000000000000000ffffffffffffffff28000000280000002b0300002b020000" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "PropWindowplacement" /t REG_BINARY /d "2c00000000000000000000000000000000000000000000000000000028000000280000000000000000000000" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "DllPropWindowplacement" /t REG_BINARY /d "2c00000000000000010000000000000000000000ffffffffffffffff2800000028000000e70100009f020000" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "UnicodeFont" /t REG_BINARY /d "080000000000000000000000000000009001000000000000000000004d00530020005300680065006c006c00200044006c00670000000000000000000000000000000000000000000000000000000000000000000000000000000000" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "Divider" /t REG_BINARY /d "531f0e151662ea3f" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "SavedDivider" /t REG_BINARY /d "531f0e151662ea3f" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "ProcessImageColumnWidth" /t REG_DWORD /d "261" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "ShowUnnamedHandles" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "ShowDllView" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "HandleSortColumn" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "HandleSortDirection" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "DllSortColumn" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "DllSortDirection" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "ProcessSortColumn" /t REG_DWORD /d "4294967295" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "ProcessSortDirection" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "HighlightServices" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "HighlightOwnProcesses" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "HighlightRelocatedDlls" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "HighlightJobs" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "HighlightNewProc" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "HighlightDelProc" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "HighlightImmersive" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "HighlightProtected" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "HighlightPacked" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "HighlightNetProcess" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "HighlightSuspend" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "HighlightDuration" /t REG_DWORD /d "1000" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "ShowCpuFractions" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "ShowLowerpane" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "ShowAllUsers" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "ShowProcessTree" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "SymbolWarningShown" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "HideWhenMinimized" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "AlwaysOntop" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "OneInstance" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "NumColumnSets" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "ConfirmKill" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "RefreshRate" /t REG_DWORD /d "5000" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "PrcessColumnCount" /t REG_DWORD /d "18" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "DllColumnCount" /t REG_DWORD /d "5" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "HandleColumnCount" /t REG_DWORD /d "2" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "DefaultProcPropPage" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "DefaultSysInfoPage" /t REG_DWORD /d "4" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "DefaultDllPropPage" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "DbgHelpPath" /t REG_SZ /d "C:\Windows\SYSTEM32\dbghelp.dll" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "SymbolPath" /t REG_SZ /d "" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "ColorPacked" /t REG_DWORD /d "16711808" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "ColorImmersive" /t REG_DWORD /d "15395328" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "ColorOwn" /t REG_DWORD /d "16765136" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "ColorServices" /t REG_DWORD /d "13684991" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "ColorRelocatedDlls" /t REG_DWORD /d "10551295" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "ColorGraphBk" /t REG_DWORD /d "15790320" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "ColorJobs" /t REG_DWORD /d "27856" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "ColorDelProc" /t REG_DWORD /d "4605695" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "ColorNewProc" /t REG_DWORD /d "4652870" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "ColorNet" /t REG_DWORD /d "10551295" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "ColorProtected" /t REG_DWORD /d "8388863" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "ShowHeatmaps" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "ColorSuspend" /t REG_DWORD /d "8421504" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "StatusBarColumns" /t REG_DWORD /d "13589" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "ShowAllCpus" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "ShowAllGpus" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "Opacity" /t REG_DWORD /d "100" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "GpuNodeUsageMask" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "GpuNodeUsageMask1" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "VerifySignatures" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "VirusTotalCheck" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "VirusTotalSubmitUnknown" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "ToolbarBands" /t REG_BINARY /d "0601000000000000000000004b00000001000000000000004b00000002000000000000004b00000003000000000000004b0000000400000000000000400000000500000000000000500000000600000000000000930400000700000000000000" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "UseGoogle" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "ShowNewProcesses" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "TrayCPUHistory" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "ShowIoTray" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "ShowNetTray" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "ShowDiskTray" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "ShowPhysTray" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "ShowCommitTray" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "ShowGpuTray" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "FormatIoBytes" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "StackWindowPlacement" /t REG_BINARY /d "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "ETWstandardUserWarning" /t REG_DWORD /d "0" /f >nul 2>&1

REM Adjusting DllColumnMap values.
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer\DllColumnMap" /v "0" /t REG_DWORD /d "26" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer\DllColumnMap" /v "1" /t REG_DWORD /d "42" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer\DllColumnMap" /v "2" /t REG_DWORD /d "1033" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer\DllColumnMap" /v "3" /t REG_DWORD /d "1111" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer\DllColumnMap" /v "4" /t REG_DWORD /d "1670" /f >nul 2>&1

REM Adjusting DllColumns values.
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer\DllColumns" /v "0" /t REG_DWORD /d "110" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer\DllColumns" /v "1" /t REG_DWORD /d "180" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer\DllColumns" /v "2" /t REG_DWORD /d "140" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer\DllColumns" /v "3" /t REG_DWORD /d "300" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer\DllColumns" /v "4" /t REG_DWORD /d "100" /f >nul 2>&1

REM Adjusting HandleColumnMap values.
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer\HandleColumnMap" /v "0" /t REG_DWORD /d "21" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer\HandleColumnMap" /v "1" /t REG_DWORD /d "22" /f >nul 2>&1

REM Adjusting HandleColumn values
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer\HandleColumns" /v "0" /t REG_DWORD /d "100" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer\HandleColumns" /v "1" /t REG_DWORD /d "450" /f >nul 2>&1

REM Adjusting ProcessColumnMap values
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer\ProcessColumnMap" /v "0" /t REG_DWORD /d "3" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer\ProcessColumnMap" /v "1" /t REG_DWORD /d "1055" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer\ProcessColumnMap" /v "2" /t REG_DWORD /d "1650" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer\ProcessColumnMap" /v "3" /t REG_DWORD /d "1200" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer\ProcessColumnMap" /v "4" /t REG_DWORD /d "1092" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer\ProcessColumnMap" /v "5" /t REG_DWORD /d "1333" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer\ProcessColumnMap" /v "6" /t REG_DWORD /d "1622" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer\ProcessColumnMap" /v "7" /t REG_DWORD /d "1636" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer\ProcessColumnMap" /v "8" /t REG_DWORD /d "1179" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer\ProcessColumnMap" /v "9" /t REG_DWORD /d "1340" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer\ProcessColumnMap" /v "10" /t REG_DWORD /d "5" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer\ProcessColumnMap" /v "11" /t REG_DWORD /d "1339" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer\ProcessColumnMap" /v "12" /t REG_DWORD /d "1060" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer\ProcessColumnMap" /v "13" /t REG_DWORD /d "1063" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer\ProcessColumnMap" /v "14" /t REG_DWORD /d "4" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer\ProcessColumnMap" /v "15" /t REG_DWORD /d "1065" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer\ProcessColumnMap" /v "16" /t REG_DWORD /d "18" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer\ProcessColumnMap" /v "17" /t REG_DWORD /d "1670" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer\ProcessColumnMap" /v "18" /t REG_DWORD /d "1653" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer\ProcessColumnMap" /v "19" /t REG_DWORD /d "1653" /f >nul 2>&1

REM Adjusting ProcessColumns values.
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer\ProcessColumns" /v "0" /t REG_DWORD /d "261" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer\ProcessColumns" /v "1" /t REG_DWORD /d "35" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer\ProcessColumns" /v "2" /t REG_DWORD /d "37" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer\ProcessColumns" /v "3" /t REG_DWORD /d "82" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer\ProcessColumns" /v "4" /t REG_DWORD /d "81" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer\ProcessColumns" /v "5" /t REG_DWORD /d "65" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer\ProcessColumns" /v "6" /t REG_DWORD /d "93" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer\ProcessColumns" /v "7" /t REG_DWORD /d "76" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer\ProcessColumns" /v "8" /t REG_DWORD /d "55" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer\ProcessColumns" /v "9" /t REG_DWORD /d "60" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer\ProcessColumns" /v "10" /t REG_DWORD /d "39" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer\ProcessColumns" /v "11" /t REG_DWORD /d "80" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer\ProcessColumns" /v "12" /t REG_DWORD /d "70" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer\ProcessColumns" /v "13" /t REG_DWORD /d "70" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer\ProcessColumns" /v "14" /t REG_DWORD /d "31" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer\ProcessColumns" /v "15" /t REG_DWORD /d "52" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer\ProcessColumns" /v "16" /t REG_DWORD /d "52" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Sysinternals\Process Explorer\ProcessColumns" /v "17" /t REG_DWORD /d "44" /f >nul 2>&1

REM Set Affinities (Credits To HoneCTRL)
for /f "tokens=*" %%f in ('wmic cpu get NumberOfCores /value ^| find "="') do set %%f
for /f "tokens=*" %%f in ('wmic cpu get NumberOfLogicalProcessors /value ^| find "="') do set %%f
if "!NumberOfCores!" == "2" goto skippingaffinities

if !NumberOfCores! gtr 4 (
	for /f %%i in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /l "PCI\VEN_"') do (
		reg add "HKLM\System\CurrentControlSet\Enum\%%i\Device Parameters\Interrupt Management\Affinity Policy" /v "DevicePolicy" /t REG_DWORD /d "3" /f
		reg delete "HKLM\System\CurrentControlSet\Enum\%%i\Device Parameters\Interrupt Management\Affinity Policy" /v "AssignmentSetOverride" /f
	) >nul 2>&1
	for /f %%i in ('wmic path Win32_NetworkAdapter get PNPDeviceID^| findstr /l "PCI\VEN_"') do (
		reg add "HKLM\System\CurrentControlSet\Enum\%%i\Device Parameters\Interrupt Management\Affinity Policy" /v "DevicePolicy" /t REG_DWORD /d "5" /f
		reg delete "HKLM\System\CurrentControlSet\Enum\%%i\Device Parameters\Interrupt Management\Affinity Policy" /v "AssignmentSetOverride" /f
	) >nul 2>&1
)
if !NumberOfLogicalProcessors! gtr !NumberOfCores! (
REM HyperThreading Enabled
for /f %%i in ('wmic path Win32_USBController get PNPDeviceID^| findstr /l "PCI\VEN_"') do (
	reg add "HKLM\System\CurrentControlSet\Enum\%%i\Device Parameters\Interrupt Management\Affinity Policy" /v "DevicePolicy" /t REG_DWORD /d "4" /f
	reg add "HKLM\System\CurrentControlSet\Enum\%%i\Device Parameters\Interrupt Management\Affinity Policy" /v "AssignmentSetOverride" /t REG_BINARY /d "C0" /f
) >nul 2>&1
for /f %%i in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /l "PCI\VEN_"') do (
	reg add "HKLM\System\CurrentControlSet\Enum\%%i\Device Parameters\Interrupt Management\Affinity Policy" /v "DevicePolicy" /t REG_DWORD /d "4" /f
	reg add "HKLM\System\CurrentControlSet\Enum\%%i\Device Parameters\Interrupt Management\Affinity Policy" /v "AssignmentSetOverride" /t REG_BINARY /d "C0" /f
) >nul 2>&1
for /f %%i in ('wmic path Win32_NetworkAdapter get PNPDeviceID^| findstr /l "PCI\VEN_"') do (
	reg add "HKLM\System\CurrentControlSet\Enum\%%i\Device Parameters\Interrupt Management\Affinity Policy" /v "DevicePolicy" /t REG_DWORD /d "4" /f
	reg add "HKLM\System\CurrentControlSet\Enum\%%i\Device Parameters\Interrupt Management\Affinity Policy" /v "AssignmentSetOverride" /t REG_BINARY /d "30" /f
) >nul 2>&1
) else (
REM HyperThreading Disabled
for /f %%i in ('wmic path Win32_USBController get PNPDeviceID^| findstr /l "PCI\VEN_"') do (
	reg add "HKLM\System\CurrentControlSet\Enum\%%i\Device Parameters\Interrupt Management\Affinity Policy" /v "DevicePolicy" /t REG_DWORD /d "4" /f
	reg add "HKLM\System\CurrentControlSet\Enum\%%i\Device Parameters\Interrupt Management\Affinity Policy" /v "AssignmentSetOverride" /t REG_BINARY /d "08" /f
) >nul 2>&1
for /f %%i in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /l "PCI\VEN_"') do (
	reg add "HKLM\System\CurrentControlSet\Enum\%%i\Device Parameters\Interrupt Management\Affinity Policy" /v "DevicePolicy" /t REG_DWORD /d "4" /f
	reg add "HKLM\System\CurrentControlSet\Enum\%%i\Device Parameters\Interrupt Management\Affinity Policy" /v "AssignmentSetOverride" /t REG_BINARY /d "02" /f
) >nul 2>&1
for /f %%i in ('wmic path Win32_NetworkAdapter get PNPDeviceID^| findstr /l "PCI\VEN_"') do (
	reg add "HKLM\System\CurrentControlSet\Enum\%%i\Device Parameters\Interrupt Management\Affinity Policy" /v "DevicePolicy" /t REG_DWORD /d "4" /f
	reg add "HKLM\System\CurrentControlSet\Enum\%%i\Device Parameters\Interrupt Management\Affinity Policy" /v "AssignmentSetOverride" /t REG_BINARY /d "04" /f
) >nul 2>&1
)
)
:skippingaffinities


REM Adjusting thread priorities for various services.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\DXGKrnl\Parameters" /v "ThreadPriority" /t REG_DWORD /d "15" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\nvlddmkm\Parameters" /v "ThreadPriority" /t REG_DWORD /d "31" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\USBHUB3\Parameters" /v "ThreadPriority" /t REG_DWORD /d "15" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\USBXHCI\Parameters" /v "ThreadPriority" /t REG_DWORD /d "15" /f >nul 2>&1

REM Setting registry values related to Windows Update behavior.
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ExcludeWUDriversInQualityUpdate" /t REG_DWORD /d "1" /f >nul 2>&1

REM Adjusting memory management settings
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnableSuperfetch" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /t REG_DWORD /d "1" /f >nul 2>&1

REM Configuring multimedia system profile settings
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d "100" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "LazyModeTimeout" /t REG_DWORD /d "10000" /f >nul 2>&1

REM Mouse settings
Reg.exe add "HKCU\Control Panel\Mouse" /v "MouseSpeed" /t REG_SZ /d "0" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Mouse" /v "MouseThreshold1" /t REG_SZ /d "0" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Mouse" /v "MouseThreshold2" /t REG_SZ /d "0" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Mouse" /v "MouseSensitivity" /t REG_SZ /d "10" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" /v "MouseDataQueueSize" /t REG_DWORD /d "20" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" /v "KeyboardDataQueueSize" /t REG_DWORD /d "20" /f >nul 2>&1

REM Accessibility settings
Reg.exe add "HKCU\Control Panel\Accessibility" /v "StickyKeys" /t REG_SZ /d "506" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Accessibility\ToggleKeys" /v "Flags" /t REG_SZ /d "58" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Accessibility\Keyboard Response" /v "DelayBeforeAcceptance" /t REG_SZ /d "0" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Accessibility\Keyboard Response" /v "AutoRepeatRate" /t REG_SZ /d "0" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Accessibility\Keyboard Response" /v "AutoRepeatDelay" /t REG_SZ /d "0" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Accessibility\Keyboard Response" /v "Flags" /t REG_SZ /d "122" /f >nul 2>&1

REM Graphics and gaming settings
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_DWORD /d "2" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /t REG_SZ /d "0" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Microsoft\GameBar" /v "AutoGameModeEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Microsoft\GameBar" /v "AllowAutoGameMode" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKCU\System\GameConfigStore" /v "Win32_AutoGameModeDefaultProfile" /t REG_BINARY /d "00000000000000000000000000000000000000000000000000000000000000000000000000000000" /f >nul 2>&1
Reg.exe add "HKCU\System\GameConfigStore" /v "Win32_GameModeRelatedProcesses" /t REG_BINARY /d "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" /f >nul 2>&1

REM Delete Windows Search ContractId registry entries
reg delete "HKCR\Extensions\ContractId\Windows.Search\PackageId\Microsoft.Windows.Search_1.14.0.19041_neutral_neutral_cw5n1h2txyewy" /f >nul 2>&1

REM Delete Windows ComponentUI ContractId registry entries
reg delete "HKCR\Extensions\ContractId\Windows.ComponentUI\PackageId\Microsoft.Windows.Search_1.14.0.19041_neutral_neutral_cw5n1h2txyewy" /f >nul 2>&1
reg delete "HKCR\Extensions\ContractId\Windows.ComponentUI\PackageId\Microsoft.Windows.StartMenuExperienceHost_10.0.19041.423_neutral_neutral_cw5n1h2txyewy" /f >nul 2>&1

REM Delete Windows AppService ContractId registry entries
reg delete "HKCR\Extensions\ContractId\Windows.AppService\PackageId\Microsoft.Windows.Search_1.14.0.19041_neutral_neutral_cw5n1h2txyewy" /f >nul 2>&1
reg delete "HKCR\Extensions\ContractId\Windows.AppService\PackageId\Microsoft.Windows.ShellExperienceHost_10.0.19041.423_neutral_neutral_cw5n1h2txyewy" /f >nul 2>&1

REM Delete Windows BackgroundTasks ContractId registry entries
reg delete "HKCR\Extensions\ContractId\Windows.BackgroundTasks\PackageId\46928bounde.EclipseManager_2.2.4.51_neutral__a5h4egax66k6y" /f >nul 2>&1
reg delete "HKCR\Extensions\ContractId\Windows.BackgroundTasks\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0" /f >nul 2>&1
reg delete "HKCR\Extensions\ContractId\Windows.BackgroundTasks\PackageId\Microsoft.Windows.Search_1.14.0.19041_neutral_neutral_cw5n1h2txyewy" /f >nul 2>&1
reg delete "HKCR\Extensions\ContractId\Windows.BackgroundTasks\PackageId\Microsoft.Windows.ShellExperienceHost_10.0.19041.423_neutral_neutral_cw5n1h2txyewy" /f >nul 2>&1
reg delete "HKCR\Extensions\ContractId\Windows.BackgroundTasks\PackageId\Microsoft.Windows.StartMenuExperienceHost_10.0.19041.423_neutral_neutral_cw5n1h2txyewy" /f >nul 2>&1
reg delete "HKCR\Extensions\ContractId\Windows.BackgroundTasks\PackageId\MicrosoftWindows.UndockedDevKit_10.0.19041.423_neutral_neutral_cw5n1h2txyewy" /f >nul 2>&1
reg delete "HKCR\Extensions\ContractId\Windows.BackgroundTasks\PackageId\Microsoft.MicrosoftOfficeHub_17.7909.7600.0_x64__8wekyb3d8bbwe" /f >nul 2>&1
reg delete "HKCR\Extensions\ContractId\Windows.BackgroundTasks\PackageId\Microsoft.PPIProjection_10.0.15063.0_neutral_neutral_cw5n1h2txyewy" /f >nul 2>&1
reg delete "HKCR\Extensions\ContractId\Windows.BackgroundTasks\PackageId\Microsoft.XboxGameCallableUI_1000.15063.0.0_neutral_neutral_cw5n1h2txyewy" /f >nul 2>&1
reg delete "HKCR\Extensions\ContractId\Windows.BackgroundTasks\PackageId\Microsoft.XboxGameCallableUI_1000.16299.15.0_neutral_neutral_cw5n1h2txyewy" /f >nul 2>&1

REM Delete Windows File ContractId registry entries
reg delete "HKCR\Extensions\ContractId\Windows.File\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0" /f >nul 2>&1

REM Delete Windows Launch ContractId registry entries
reg delete "HKCR\Extensions\ContractId\Windows.Launch\PackageId\46928bounde.EclipseManager_2.2.4.51_neutral__a5h4egax66k6y" /f >nul 2>&1
reg delete "HKCR\Extensions\ContractId\Windows.Launch\PackageId\Microsoft.Windows.Search_1.14.0.19041_neutral_neutral_cw5n1h2txyewy" /f >nul 2>&1
reg delete "HKCR\Extensions\ContractId\Windows.Launch\PackageId\Microsoft.Windows.ShellExperienceHost_10.0.19041.423_neutral_neutral_cw5n1h2txyewy" /f >nul 2>&1
reg delete "HKCR\Extensions\ContractId\Windows.Launch\PackageId\Microsoft.Windows.StartMenuExperienceHost_10.0.19041.423_neutral_neutral_cw5n1h2txyewy" /f >nul 2>&1
reg delete "HKCR\Extensions\ContractId\Windows.Launch\PackageId\MicrosoftWindows.UndockedDevKit_10.0.19041.423_neutral_neutral_cw5n1h2txyewy" /f >nul 2>&1
reg delete "HKCR\Extensions\ContractId\Windows.Launch\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0" /f >nul 2>&1
reg delete "HKCR\Extensions\ContractId\Windows.Launch\PackageId\Microsoft.PPIProjection_10.0.15063.0_neutral_neutral_cw5n1h2txyewy" /f >nul 2>&1
reg delete "HKCR\Extensions\ContractId\Windows.Launch\PackageId\Microsoft.XboxGameCallableUI_1000.15063.0.0_neutral_neutral_cw5n1h2txyewy" /f >nul 2>&1
reg delete "HKCR\Extensions\ContractId\Windows.Launch\PackageId\Microsoft.XboxGameCallableUI_1000.16299.15.0_neutral_neutral_cw5n1h2txyewy" /f >nul 2>&1
reg delete "HKCR\Extensions\ContractId\Windows.PreInstalledConfigTask\PackageId\Microsoft.MicrosoftOfficeHub_17.7909.7600.0_x64__8wekyb3d8bbwe" /f >nul 2>&1

REM Delete Windows Protocol ContractId registry entries
reg delete "HKCR\Extensions\ContractId\Windows.Protocol\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0" /f >nul 2>&1
reg delete "HKCR\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.PPIProjection_10.0.15063.0_neutral_neutral_cw5n1h2txyewy" /f >nul 2>&1
reg delete "HKCR\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.XboxGameCallableUI_1000.15063.0.0_neutral_neutral_cw5n1h2txyewy" /f >nul 2>&1
reg delete "HKCR\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.XboxGameCallableUI_1000.16299.15.0_neutral_neutral_cw5n1h2txyewy" /f >nul 2>&1
reg delete "HKCR\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.Windows.Search_1.14.0.19041_neutral_neutral_cw5n1h2txyewy" /f >nul 2>&1
reg delete "HKCR\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.Windows.ShellExperienceHost_10.0.19041.423_neutral_neutral_cw5n1h2txyewy" /f >nul 2>&1
reg delete "HKCR\Extensions\ContractId\Windows.ShareTarget\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0" /f >nul 2>&1
reg delete "HKCR\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.BingWeather_4.25.20211.0_x64__8wekyb3d8bbwe" /f >nul 2>&1
reg delete "HKCR\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.GetHelp_10.1706.13331.0_x64__8wekyb3d8bbwe" /f >nul 2>&1
reg delete "HKCR\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.Getstarted_8.2.22942.0_x64__8wekyb3d8bbwe" /f >nul 2>&1
reg delete "HKCR\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.MicrosoftEdge_44.19041.423.0_neutral__8wekyb3d8bbwe" /f >nul 2>&1
reg delete "HKCR\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.MicrosoftOfficeHub_18.1903.1152.0_x64__8wekyb3d8bbwe" /f >nul 2>&1
reg delete "HKCR\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.MixedReality.Portal_2000.19081.1301.0_x64__8wekyb3d8bbwe" /f >nul 2>&1
reg delete "HKCR\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.MSPaint_6.1907.29027.0_x64__8wekyb3d8bbwe" /f >nul 2>&1
reg delete "HKCR\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.Office.OneNote_16001.12026.20112.0_x64__8wekyb3d8bbwe" /f >nul 2>&1
reg delete "HKCR\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.People_10.1902.633.0_x64__8wekyb3d8bbwe" /f >nul 2>&1
reg delete "HKCR\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.WindowsAlarms_10.1906.2182.0_x64__8wekyb3d8bbwe" /f >nul 2>&1
reg delete "HKCR\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.WindowsCamera_2018.826.98.0_x64__8wekyb3d8bbwe" /f >nul 2>&1
reg delete "HKCR\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.WindowsFeedbackHub_1.1907.3152.0_x64__8wekyb3d8bbwe" /f >nul 2>&1
reg delete "HKCR\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.WindowsCalculator_10.1906.55.0_x64__8wekyb3d8bbwe" /f >nul 2>&1
reg delete "HKCR\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.WindowsMaps_5.1906.1972.0_x64__8wekyb3d8bbwe" /f >nul 2>&1
reg delete "HKCR\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.WindowsStore_11910.1002.5.0_x64__8wekyb3d8bbwe" /f >nul 2>&1
reg delete "HKCR\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.Xbox.TCUI_1.23.28002.0_x64__8wekyb3d8bbwe" /f >nul 2>&1
reg delete "HKCR\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.XboxApp_48.49.31001.0_x64__8wekyb3d8bbwe" /f >nul 2>&1
reg delete "HKCR\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.XboxGameCallableUI_1000.19041.423.0_neutral_neutral_cw5n1h2txyewy" /f >nul 2>&1
reg delete "HKCR\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.XboxGameOverlay_1.46.11001.0_x64__8wekyb3d8bbwe" /f >nul 2>&1
reg delete "HKCR\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.XboxGamingOverlay_2.34.28001.0_x64__8wekyb3d8bbwe" /f >nul 2>&1
reg delete "HKCR\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.XboxSpeechToTextOverlay_1.17.29001.0_x64__8wekyb3d8bbwe" /f >nul 2>&1
reg delete "HKCR\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.ZuneMusic_10.19071.19011.0_x64__8wekyb3d8bbwe" /f >nul 2>&1
reg delete "HKCR\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.ZuneVideo_10.19071.19011.0_x64__8wekyb3d8bbwe" /f >nul 2>&1

REM Set MSI Mode (Credits To HoneCTRl)
for /f %%g in ('wmic path win32_VideoController get PNPDeviceID ^| findstr /L "VEN_"') do reg add "HKLM\SYSTEM\CurrentControlSet\Enum\%%g\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties" /v "MSISupported" /t REG_DWORD /d "1" /f >nul 2>&1
for /f %%g in ('wmic path win32_VideoController get PNPDeviceID ^| findstr /L "VEN_"') do reg delete "HKLM\System\CurrentControlSet\Enum\%%g\Device Parameters\Interrupt Management\Affinity Policy" /v "DevicePriority" /f >nul 2>&1
for /f %%i in ('wmic path Win32_NetworkAdapter get PNPDeviceID ^| findstr /L "VEN_"') do reg add "HKLM\SYSTEM\CurrentControlSet\Enum\%%i\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties" /v "MSISupported" /t REG_DWORD /d "1" /f >nul 2>&1
for /f %%i in ('wmic path Win32_NetworkAdapter get PNPDeviceID ^| findstr /L "VEN_"') do reg delete "HKLM\System\CurrentControlSet\Enum\%%i\Device Parameters\Interrupt Management\Affinity Policy" /v "DevicePriority" /f >nul 2>&1

REM Download Vitality Power Plan
mkdir "%SYSTEMDRIVE%\Vitality\Resources\PowerPlan"
if exist "%SYSTEMDRIVE%\Vitality\Resources\PowerPlan\Vitality.pow" del "%SYSTEMDRIVE%\Vitality\Resources\PowerPlan\Vitality.pow" >nul 2>&1
powercfg /d 01010101-0101-0101-0101-010101010101 >nul 2>&1
curl -g -k -L -# -o "%SYSTEMDRIVE%\Vitality\Resources\PowerPlan\Vitality.pow" "https://cdn.discordapp.com/attachments/1140029335944835152/1140029390449819659/Vitality.pow" >nul 2>&1
powercfg -import "%SYSTEMDRIVE%\Vitality\Resources\PowerPlan\Vitality.pow" 01010101-0101-0101-0101-010101010101 >nul 2>&1
powercfg /changename 01010101-0101-0101-0101-010101010101 "Vitality" " " >nul 2>&1
powercfg -setactive 01010101-0101-0101-0101-010101010101 >nul 2>&1

REM Download Timer Resolution (Credits to Amitxv)
if exist "%SYSTEMDRIVE%\SetTimerResolution.exe" del "%SYSTEMDRIVE%\SetTimerResolution.exe" >nul 2>&1
curl -g -k -L -# -o "%SYSTEMDRIVE%\SetTimerResolution.exe" "https://github.com/amitxv/TimerResolution/releases/download/SetTimerResolution-v0.1.3/SetTimerResolution.exe" >nul 2>&1

REM Creating Shortcut for Timer Resolution
if exist "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\TimerResolutionShortcut.lnk" del "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\TimerResolutionShortcut.lnk" >nul 2>&1
cd "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup"
set "targetPath=C:\SetTimerResolution.exe"
set "args=--resolution 5000 --no-console"
set "shortcutName=TimerResolutionShortcut.lnk"
powershell -Command "$WshShell = New-Object -ComObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut('%shortcutName%'); $Shortcut.TargetPath = '%targetPath%'; $Shortcut.Arguments = '%args%'; $Shortcut.Save()" >nul 2>&1
start "" "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\TimerResolutionShortcut.lnk" >nul 2>&1


set "file=C:\Vitality\Info\fpsandinput"
if not exist "%file%" (
    echo Vitality > "%file%"
    set /a "ran_optimizations+=1"
)
cd C:\Vitality
set "formatted_optimizations=%ran_optimizations%"
if %formatted_optimizations% LSS 10 set "formatted_optimizations= %formatted_optimizations%"
echo set "ran_optimizations=%ran_optimizations%"> v.bat
:skippingfps


if "%Latency%"=="false" goto skippinglatency
echo                                                  Applying Latency Tweaks
REM TCP/IP ServiceProvider Priorities
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v "LocalPriority" /t REG_DWORD /d "4" /f  >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v "HostsPriority" /t REG_DWORD /d "5" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v "DnsPriority" /t REG_DWORD /d "6" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v "NetbtPriority" /t REG_DWORD /d "7" /f >nul 2>&1

REM Desktop and App Timeout Settings
Reg.exe add "HKCU\Control Panel\Desktop" /v "HungAppTimeout" /t REG_SZ /d "1000" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Desktop" /v "WaitToKillAppTimeout" /t REG_SZ /d "2000" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Desktop" /v "LowLevelHooksTimeout" /t REG_SZ /d "1000" /f >nul 2>&1

REM System Policies Configuration
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d "0" /f  >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d "0" /f  >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "PromptOnSecureDesktop" /t REG_DWORD /d "0" /f  >nul 2>&1

REM Memory Management & Features
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /t REG_DWORD /d "1" /f  >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "DisablePagingExecutive" /t REG_DWORD /d "1" /f  >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "DisablePagingCombining" /t REG_DWORD /d "1" /f  >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Control\Session Manager\Memory Management" /v "EnableCfg" /t REG_DWORD /d "0" /f  >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettings" /t REG_DWORD /d "1" /f  >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverride" /t REG_DWORD /d "3" /f   >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverrideMask" /t REG_DWORD /d "3" /f  >nul 2>&1

REM Security & DeviceGuard Policies
reg add "HKLM\SOFTWARE\Policies\Microsoft\FVE" /v "DisableExternalDMAUnderLock" /t REG_DWORD /d "0" /f  >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v "EnableVirtualizationBasedSecurity" /t REG_DWORD /d "0" /f  >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v "HVCIMATRequired" /t REG_DWORD /d "0" /f  >nul 2>&1

REM Power & Coalescing Timer Settings
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f  >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f  >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f  >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Executive" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f  >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f  >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\ModernSleep" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f  >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f  >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f  >nul 2>&1

REM Multimedia & Display Settings
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d "10" /f  >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d "6" /f  >nul 2>&1

REM Session Manager Protection Mode
reg add "HKLM\System\CurrentControlSet\Control\Session Manager" /v "ProtectionMode" /t REG_DWORD /d "0" /f  >nul 2>&1

REM Desktop Window Manager (DWM) Configuration
reg add "HKCU\Software\Microsoft\Windows\DWM" /v "CompositionPolicy" /t REG_DWORD /d "0" /f  >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "Composition" /t REG_DWORD /d "0" /f  >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "EnableWindowColorization" /t REG_DWORD /d "0" /f  >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "EnableAeroPeek" /t REG_DWORD /d "0" /f  >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "AlwaysHibernateThumbnails" /t REG_DWORD /d "0" /f  >nul 2>&1

REM Input Personalization & Explorer Settings
reg add "HKCU\SOFTWARE\Policies\Microsoft\InputPersonalization" /v "RestrictImplicitTextCollection" /t REG_DWORD /d "1" /f  >nul 2>&1
reg add "HKCU\SOFTWARE\Policies\Microsoft\InputPersonalization" /v "RestrictImplicitInkCollection" /t REG_DWORD /d "1" /f  >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Hidden" /t REG_DWORD /d "1" /f  >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "VisualFXSetting" /t REG_DWORD /d "3" /f  >nul 2>&1

REM Control Panel & User Interface Settings
reg add "HKCU\Control Panel\Desktop" /v "DragFullWindows" /t REG_SZ /d "0" /f   >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v "FontSmoothing" /t REG_SZ /d "2" /f  >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v "UserPreferencesMask" /t REG_BINARY /d "9012038010020000" /f  >nul 2>&1
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MinAnimate" /t REG_SZ /d "0" /f  >nul 2>&1

REM TCP/IPv6 Disabled Components
reg add "HKLM\System\CurrentControlSet\Services\Tcpip6\Parameters" /v "DisabledComponents" /t REG_DWORD /d "255" /f  >nul 2>&1

REM Multimedia System Profile Settings
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d "0" /f  >nul 2>&1

REM Memory Management Feature Settings
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettings" /t REG_DWORD /d "1" /f  >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverride" /t REG_DWORD /d "3" /f  >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverrideMask" /t REG_DWORD /d "3" /f  >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "EnableCfg" /t REG_DWORD /d "0" /f  >nul 2>&1
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Session Manager\Memory Management" /v "FeatureSettings" /t REG_DWORD /d "1" /f  >nul 2>&1
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Session Manager\Memory Management" /v "FeatureSettingsOverride" /t REG_DWORD /d "3" /f  >nul 2>&1
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Session Manager\Memory Management" /v "FeatureSettingsOverrideMask" /t REG_DWORD /d "3" /f  >nul 2>&1
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Session Manager\Memory Management" /v "EnableCfg" /t REG_DWORD /d "0" /f  >nul 2>&1
Reg.exe add "HKLM\SYSTEM\ControlSet002\Control\Session Manager\Memory Management" /v "FeatureSettings" /t REG_DWORD /d "1" /f  >nul 2>&1
Reg.exe add "HKLM\SYSTEM\ControlSet002\Control\Session Manager\Memory Management" /v "FeatureSettingsOverride" /t REG_DWORD /d "3" /f  >nul 2>&1
Reg.exe add "HKLM\SYSTEM\ControlSet002\Control\Session Manager\Memory Management" /v "FeatureSettingsOverrideMask" /t REG_DWORD /d "3" /f  >nul 2>&1
Reg.exe add "HKLM\SYSTEM\ControlSet002\Control\Session Manager\Memory Management" /v "EnableCfg" /t REG_DWORD /d "0" /f  >nul 2>&1

REM Kernel Settings
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "DisableExceptionChainValidation" /t REG_DWORD /d "1" /f  >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "KernelSEHOPEnabled" /t REG_DWORD /d "0" /f  >nul 2>&1
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Session Manager\kernel" /v "DisableExceptionChainValidation" /t REG_DWORD /d "1" /f  >nul 2>&1
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Session Manager\kernel" /v "KernelSEHOPEnabled" /t REG_DWORD /d "0" /f  >nul 2>&1
Reg.exe add "HKLM\SYSTEM\ControlSet002\Control\Session Manager\kernel" /v "DisableExceptionChainValidation" /t REG_DWORD /d "1" /f  >nul 2>&1
Reg.exe add "HKLM\SYSTEM\ControlSet002\Control\Session Manager\kernel" /v "KernelSEHOPEnabled" /t REG_DWORD /d "0" /f  >nul 2>&1

REM User Profile & Advertising Settings
reg add "HKCU\Control Panel\International\User Profile" /v "HttpAcceptLanguageOptOut" /t REG_DWORD /d "1" /f  >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d "0" /f  >nul 2>&1

REM AppHost & WiFi Settings
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /t REG_DWORD /d "0" /f  >nul 2>&1
reg add "HKLM\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" /v "value" /t REG_DWORD /d "0" /f  >nul 2>&1
reg add "HKLM\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" /v "value" /t REG_DWORD /d "0" /f  >nul 2>&1

REM Downloading Low Audio Latency (Credits to sppdl)
if exist "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\low_audio_latency_no_console.exe" del "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\low_audio_latency_no_console.exe"
curl -g -k -L -# -o "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\low_audio_latency_no_console.exe" "https://github.com/spddl/LowAudioLatency/releases/download/v2.0.1/low_audio_latency_no_console.exe" >nul 2>&1



set "file=C:\Vitality\Info\latency"
if not exist "%file%" (
    echo Vitality > "%file%"
    set /a "ran_optimizations+=1"
)
cd C:\Vitality
set "formatted_optimizations=%ran_optimizations%"
if %formatted_optimizations% LSS 10 set "formatted_optimizations= %formatted_optimizations%"
echo set "ran_optimizations=%ran_optimizations%"> v.bat
:skippinglatency

if "%Network%"=="false" goto skippingnetwork
echo                                                  Applying Network Tweaks
REM TCP/IP Parameters Settings
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "NV Hostname" /t REG_SZ /d "domme" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "DataBasePath" /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\drivers\etc" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "NameServer" /t REG_SZ /d "" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "ForwardBroadcasts" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "IPEnableRouter" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "Domain" /t REG_SZ /d "" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "Hostname" /t REG_SZ /d "domme" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "SearchList" /t REG_SZ /d "" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "UseDomainNameDevolution" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnableICMPRedirect" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "DeadGWDetectDefault" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "DontAddDefaultGatewayDefault" /t REG_DWORD /d "0" /f >nul 2>&1

REM TCP/IP Parameters and Service Provider Priority Settings
reg add HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v GlobalMaxTcpWindowSize /t REG_DWORD /d 256960 /f >nul 2>&1
reg add HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v TcpTimedWaitDelay /t REG_DWORD /d 30 /f >nul 2>&1
reg add HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v EnableWsd /t REG_DWORD /d 0 /f >nul 2>&1
reg add HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v Tcp1323Opts /t REG_DWORD /d 1 /f >nul 2>&1
reg add HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v TcpMaxDupAcks /t REG_DWORD /d 2 /f >nul 2>&1
reg add HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v TcpWindowSize /t REG_DWORD /d 256960 /f >nul 2>&1
reg add HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v DefaultTTL /t REG_DWORD /d 64 /f >nul 2>&1
reg add HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v DisableTaskOffload /t REG_DWORD /d 0 /f >nul 2>&1
reg add HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v DisableDynamicDiscovery /t REG_DWORD /d 0 /f >nul 2>&1
reg add HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v EnablePMTUDiscovery /t REG_DWORD /d 1 /f >nul 2>&1
reg add HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v EnablePMTUBDetect /t REG_DWORD /d 0 /f >nul 2>&1
reg add HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider /v LocalPriority /t REG_DWORD /d 4 /f >nul 2>&1
reg add HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider /v HostPriority /t REG_DWORD /d 5 /f >nul 2>&1
reg add HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider /v DnsPriority /t REG_DWORD /d 6 /f >nul 2>&1
reg add HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider /v NetbtPriority /t REG_DWORD /d 7 /f >nul 2>&1

REM TCP/IP Parameters and Internet Settings
reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TcpAckFrequency /t REG_DWORD /d 1 /f >nul 2>&1
reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TCPNoDelay /t REG_DWORD /d 1 /f >nul 2>&1
reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TcpWindowSize /t REG_DWORD /d 65535 /f >nul 2>&1

REM Internet ZoneMap Settings
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\localstrike.net\ads" /v "*" /t REG_DWORD /d "4" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\localstrike.net\search" /v "*" /t REG_DWORD /d "4" /f >nul 2>&1

REM TCP/IP Parameters for Adapters
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Adapters\NdisWanIp" /v "LLInterface" /t REG_SZ /d "WANARP" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Adapters\NdisWanIp" /v "IpConfig" /t REG_MULTI_SZ /d "Tcpip\Parameters\Interfaces\{20612573-D9EB-46BB-9D1D-EED00C62A620}\0Tcpip\Parameters\Interfaces\{C8D439BE-B578-4A9E-B1AF-9779937EEF15}" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Adapters\NdisWanIp" /v "NumInterfaces" /t REG_DWORD /d "2" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Adapters\NdisWanIp" /v "IpInterfaces" /t REG_BINARY /d "73256120ebd9bb469d1deed00c62a620be39d4c878b59e4ab1af9779937eef15" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Adapters\{A8DFEEA2-1FBA-427A-8639-668BFC4F78B0}" /v "LLInterface" /t REG_SZ /d "" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Adapters\{A8DFEEA2-1FBA-427A-8639-668BFC4F78B0}" /v "IpConfig" /t REG_MULTI_SZ /d "Tcpip\Parameters\Interfaces\{A8DFEEA2-1FBA-427A-8639-668BFC4F78B0}" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Adapters\{B2C8C55E-653D-4C97-AADB-6DE6FB94AC89}" /v "LLInterface" /t REG_SZ /d "ARP1394" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Adapters\{B2C8C55E-653D-4C97-AADB-6DE6FB94AC89}" /v "IpConfig" /t REG_MULTI_SZ /d "Tcpip\Parameters\Interfaces\{B2C8C55E-653D-4C97-AADB-6DE6FB94AC89}" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Adapters\{E686FBA4-2E2C-4855-9035-0C70B85184B6}" /v "IpConfig" /t REG_MULTI_SZ /d "Tcpip\Parameters\Interfaces\{E686FBA4-2E2C-4855-9035-0C70B85184B6}" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{20612573-D9EB-46BB-9D1D-EED00C62A620}" /v "UseZeroBroadcast" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{20612573-D9EB-46BB-9D1D-EED00C62A620}" /v "IPAddress" /t REG_MULTI_SZ /d "0.0.0.0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{20612573-D9EB-46BB-9D1D-EED00C62A620}" /v "SubnetMask" /t REG_MULTI_SZ /d "0.0.0.0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{20612573-D9EB-46BB-9D1D-EED00C62A620}" /v "DefaultGateway" /t REG_MULTI_SZ /d "" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{20612573-D9EB-46BB-9D1D-EED00C62A620}" /v "EnableDeadGWDetect" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{20612573-D9EB-46BB-9D1D-EED00C62A620}" /v "DontAddDefaultGateway" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8DFEEA2-1FBA-427A-8639-668BFC4F78B0}" /v "UseZeroBroadcast" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8DFEEA2-1FBA-427A-8639-668BFC4F78B0}" /v "EnableDeadGWDetect" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8DFEEA2-1FBA-427A-8639-668BFC4F78B0}" /v "EnableDHCP" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8DFEEA2-1FBA-427A-8639-668BFC4F78B0}" /v "IPAddress" /t REG_MULTI_SZ /d "192.168.0.2" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8DFEEA2-1FBA-427A-8639-668BFC4F78B0}" /v "SubnetMask" /t REG_MULTI_SZ /d "255.255.255.0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8DFEEA2-1FBA-427A-8639-668BFC4F78B0}" /v "DefaultGateway" /t REG_MULTI_SZ /d "192.168.0.1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8DFEEA2-1FBA-427A-8639-668BFC4F78B0}" /v "DefaultGatewayMetric" /t REG_MULTI_SZ /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8DFEEA2-1FBA-427A-8639-668BFC4F78B0}" /v "NameServer" /t REG_SZ /d "192.168.0.1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8DFEEA2-1FBA-427A-8639-668BFC4F78B0}" /v "Domain" /t REG_SZ /d "" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8DFEEA2-1FBA-427A-8639-668BFC4F78B0}" /v "RegistrationEnabled" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8DFEEA2-1FBA-427A-8639-668BFC4F78B0}" /v "RegisterAdapterName" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8DFEEA2-1FBA-427A-8639-668BFC4F78B0}" /v "TCPAllowedPorts" /t REG_MULTI_SZ /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8DFEEA2-1FBA-427A-8639-668BFC4F78B0}" /v "UDPAllowedPorts" /t REG_MULTI_SZ /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8DFEEA2-1FBA-427A-8639-668BFC4F78B0}" /v "RawIPAllowedProtocols" /t REG_MULTI_SZ /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8DFEEA2-1FBA-427A-8639-668BFC4F78B0}" /v "NTEContextList" /t REG_MULTI_SZ /d "0x00000002" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8DFEEA2-1FBA-427A-8639-668BFC4F78B0}" /v "DhcpClassIdBin" /t REG_BINARY /d "" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8DFEEA2-1FBA-427A-8639-668BFC4F78B0}" /v "DhcpServer" /t REG_SZ /d "255.255.255.255" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8DFEEA2-1FBA-427A-8639-668BFC4F78B0}" /v "Lease" /t REG_DWORD /d "3600" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8DFEEA2-1FBA-427A-8639-668BFC4F78B0}" /v "LeaseObtainedTime" /t REG_DWORD /d "1128721584" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8DFEEA2-1FBA-427A-8639-668BFC4F78B0}" /v "T1" /t REG_DWORD /d "1128723384" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8DFEEA2-1FBA-427A-8639-668BFC4F78B0}" /v "T2" /t REG_DWORD /d "1128724734" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8DFEEA2-1FBA-427A-8639-668BFC4F78B0}" /v "LeaseTerminatesTime" /t REG_DWORD /d "1128725184" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8DFEEA2-1FBA-427A-8639-668BFC4F78B0}" /v "IPAutoconfigurationAddress" /t REG_SZ /d "0.0.0.0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8DFEEA2-1FBA-427A-8639-668BFC4F78B0}" /v "IPAutoconfigurationMask" /t REG_SZ /d "255.255.0.0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8DFEEA2-1FBA-427A-8639-668BFC4F78B0}" /v "IPAutoconfigurationSeed" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8DFEEA2-1FBA-427A-8639-668BFC4F78B0}" /v "AddressType" /t REG_DWORD /d "0" /f >nul 2>&1

REM Resetting Network Settings
netsh winsock reset >nul 2>&1

REM Disabling Autotuning
netsh int tcp set global autotuninglevel=disabled >nul 2>&1

REM Disabling Transition Technologies
netsh interface 6to4 set state disabled >nul 2>&1
netsh int isatap set state disable >nul 2>&1

REM Disabling TCP Timestamps
netsh int tcp set global timestamps=disabled >nul 2>&1

REM Disabling TCP Heuristics
netsh int tcp set heuristics disabled >nul 2>&1

REM Disabling TCP Chimney Offload
netsh int tcp set global chimney=disabled >nul 2>&1

REM Disabling ECN Capability
netsh int tcp set global ecncapability=disabled >nul 2>&1

REM Disabling Receive-Side Scaling (RSS)
netsh int tcp set global rsc=disabled >nul 2>&1

REM Disabling Receive Segment Coalescing (RSC)
netsh int tcp set global nonsackrttresiliency=disabled >nul 2>&1

REM Disabling Non-SACK Retransmissions
netsh int tcp set security mpp=disabled >nul 2>&1

REM Disabling TCP/IP Security Features
netsh int tcp set security profiles=disabled >nul 2>&1
netsh int ip set global icmpredirects=disabled >nul 2>&1

REM Disabling ICMP Redirects
netsh int tcp set security mpp=disabled profiles=disabled >nul 2>&1

REM Disabling Multicast Forwarding
netsh int ip set global multicastforwarding=disabled >nul 2>&1

REM Setting Congestion Provider to DCTCP
netsh int tcp set supplemental Internet congestionprovider=dctcp >nul 2>&1

REM Disabling Teredo
netsh interface teredo set state disabled >nul 2>&1

REM Modifying TCP Initial Retransmission Timeout
netsh int tcp set global initialRto=3000 >nul 2>&1

REM Disabling Receive-Side Scaling (RSS)
netsh int tcp set global rss=enabled >nul 2>&1

REM Enabling Device Configuration Activeness (DCA)
netsh int tcp set global dca=enabled >nul 2>&1

REM Disabling IP Task Offload
netsh int ip set global taskoffload=disabled >nul 2>&1

REM Enabling Network Direct Memory Access (NetDMA)
netsh int tcp set global netdma=enabled >nul 2>&1

REM Setting Neighbor Cache Limit
netsh int ip set global neighborcachelimit=4096 >nul 2>&1

REM Modifying TCP Parameters
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnablePMTUDiscovery" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "Tcp1323Opts" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpMaxDupAcks" /t REG_DWORD /d "2" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpTimedWaitDelay" /t REG_DWORD /d "32" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "GlobalMaxTcpWindowSize" /t REG_DWORD /d "8760" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpWindowSize" /t REG_DWORD /d "8760" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "MaxConnectionsPerServer" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "MaxUserPort" /t REG_DWORD /d "65534" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "SackOpts" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "DefaultTTL" /t REG_DWORD /d "64" /f >nul 2>&1

REM Modifying Network Throttling Index
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_SZ /d "ffffffff" /f >nul 2>&1

REM Deleting Useless NET Stuff
sc stop aspnet_state >nul 2>&1
sc stop clr_optimization_v2.0.50727_32 >nul 2>&1
sc stop clr_optimization_v2.0.50727_64 >nul 2>&1
sc stop clr_optimization_v4.0.30319_32 >nul 2>&1
sc stop clr_optimization_v4.0.30319_64 >nul 2>&1
sc delete aspnet_state >nul 2>&1
sc delete clr_optimization_v2.0.50727_32 >nul 2>&1
sc delete clr_optimization_v2.0.50727_64 >nul 2>&1
sc delete clr_optimization_v4.0.30319_32 >nul 2>&1
sc delete clr_optimization_v4.0.30319_64 >nul 2>&1

REM Setting NetBT service start type to manual
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\NetBT" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

REM Setting Psched service start type to manual
Reg.exe add "HKLM\System\ControlSet001\Services\Psched" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

REM Setting Ndu service start type to manual
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\Ndu" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

REM Disabling Active Probing for Network Connectivity
Reg.exe add "HKLM\System\ControlSet001\services\NlaSvc\Parameters\Internet" /v "EnableActiveProbing" /t REG_DWORD /d "0" /f >nul 2>&1

REM Disabling Internet Explorer Browser Extensions (Various CLSIDs)
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{2933BF90-7B36-11D2-B20E-00C04F983E60}" /v "Flags" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{2933BF90-7B36-11D2-B20E-00C04F983E60}" /v "Version" /t REG_SZ /d "*" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{2933BF91-7B36-11D2-B20E-00C04F983E60}" /v "Flags" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{2933BF91-7B36-11D2-B20E-00C04F983E60}" /v "Version" /t REG_SZ /d "*" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{2933BF94-7B36-11D2-B20E-00C04F983E60}" /v "Flags" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{2933BF94-7B36-11D2-B20E-00C04F983E60}" /v "Version" /t REG_SZ /d "*" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{3050F819-98B5-11CF-BB82-00AA00BDCE0B}" /v "Flags" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{3050F819-98B5-11CF-BB82-00AA00BDCE0B}" /v "Version" /t REG_SZ /d "*" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{333C7BC4-460F-11D0-BC04-0080C7055A83}" /v "Flags" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{333C7BC4-460F-11D0-BC04-0080C7055A83}" /v "Version" /t REG_SZ /d "*" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{373984C9-B845-449B-91E7-45AC83036ADE}" /v "Flags" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{373984C9-B845-449B-91E7-45AC83036ADE}" /v "Version" /t REG_SZ /d "*" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{64AB4BB7-111E-11D1-8F79-00C04FC2FBE1}" /v "Flags" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{64AB4BB7-111E-11D1-8F79-00C04FC2FBE1}" /v "Version" /t REG_SZ /d "*" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{6BF52A52-394A-11D3-B153-00C04F79FAA6}" /v "Flags" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{6BF52A52-394A-11D3-B153-00C04F79FAA6}" /v "Version" /t REG_SZ /d "*" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{884E2049-217D-11DA-B2A4-000E7BBB2B09}" /v "Flags" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{884E2049-217D-11DA-B2A4-000E7BBB2B09}" /v "Version" /t REG_SZ /d "*" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{884E2051-217D-11DA-B2A4-000E7BBB2B09}" /v "Flags" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{884E2051-217D-11DA-B2A4-000E7BBB2B09}" /v "Version" /t REG_SZ /d "*" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{88D96A05-F192-11D4-A65F-0040963251E5}" /v "Flags" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{88D96A05-F192-11D4-A65F-0040963251E5}" /v "Version" /t REG_SZ /d "*" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{88D96A06-F192-11D4-A65F-0040963251E5}" /v "Flags" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{88D96A06-F192-11D4-A65F-0040963251E5}" /v "Version" /t REG_SZ /d "*" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{88D96A07-F192-11D4-A65F-0040963251E5}" /v "Flags" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{88D96A07-F192-11D4-A65F-0040963251E5}" /v "Version" /t REG_SZ /d "*" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{88D96A08-F192-11D4-A65F-0040963251E5}" /v "Flags" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{88D96A08-F192-11D4-A65F-0040963251E5}" /v "Version" /t REG_SZ /d "*" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{88D96A0A-F192-11D4-A65F-0040963251E5}" /v "Flags" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{88D96A0A-F192-11D4-A65F-0040963251E5}" /v "Version" /t REG_SZ /d "*" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{8E4062D9-FE1B-4B9E-AA16-5E8EEF68F48E}" /v "Flags" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{8E4062D9-FE1B-4B9E-AA16-5E8EEF68F48E}" /v "Version" /t REG_SZ /d "*" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{D2517915-48CE-4286-970F-921E881B8C5C}" /v "Flags" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{D2517915-48CE-4286-970F-921E881B8C5C}" /v "Version" /t REG_SZ /d "*" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{EE09B103-97E0-11CF-978F-00A02463E06F}" /v "Flags" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{EE09B103-97E0-11CF-978F-00A02463E06F}" /v "Version" /t REG_SZ /d "*" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{F5078F32-C551-11D3-89B9-0000F81FE221}" /v "Version" /t REG_SZ /d "*" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{F5078F32-C551-11D3-89B9-0000F81FE221}" /v "Flags" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{F5078F33-C551-11D3-89B9-0000F81FE221}" /v "Flags" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{F5078F33-C551-11D3-89B9-0000F81FE221}" /v "Version" /t REG_SZ /d "*" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{F5078F34-C551-11D3-89B9-0000F81FE221}" /v "Flags" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{F5078F34-C551-11D3-89B9-0000F81FE221}" /v "Version" /t REG_SZ /d "*" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{F5078F35-C551-11D3-89B9-0000F81FE221}" /v "Flags" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{F5078F35-C551-11D3-89B9-0000F81FE221}" /v "Version" /t REG_SZ /d "*" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{F5078F36-C551-11D3-89B9-0000F81FE221}" /v "Flags" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{F5078F36-C551-11D3-89B9-0000F81FE221}" /v "Version" /t REG_SZ /d "*" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{F5078F39-C551-11D3-89B9-0000F81FE221}" /v "Flags" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{F5078F39-C551-11D3-89B9-0000F81FE221}" /v "Version" /t REG_SZ /d "*" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{F6D90F12-9C73-11D3-B32E-00C04F990BB4}" /v "Flags" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{F6D90F12-9C73-11D3-B32E-00C04F990BB4}" /v "Version" /t REG_SZ /d "*" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{F6D90F14-9C73-11D3-B32E-00C04F990BB4}" /v "Version" /t REG_SZ /d "*" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{F6D90F14-9C73-11D3-B32E-00C04F990BB4}" /v "Flags" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{2933BF90-7B36-11D2-B20E-00C04F983E60}\iexplore" /v "Flags" /t REG_DWORD /d "4" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{2933BF91-7B36-11D2-B20E-00C04F983E60}\iexplore" /v "Flags" /t REG_DWORD /d "4" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{2933BF94-7B36-11D2-B20E-00C04F983E60}\iexplore" /v "Flags" /t REG_DWORD /d "4" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{3050F819-98B5-11CF-BB82-00AA00BDCE0B}\iexplore" /v "Flags" /t REG_DWORD /d "4" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{333C7BC4-460F-11D0-BC04-0080C7055A83}\iexplore" /v "Flags" /t REG_DWORD /d "4" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{373984C9-B845-449B-91E7-45AC83036ADE}\iexplore" /v "Flags" /t REG_DWORD /d "4" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{64AB4BB7-111E-11D1-8F79-00C04FC2FBE1}\iexplore" /v "Flags" /t REG_DWORD /d "4" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{6BF52A52-394A-11D3-B153-00C04F79FAA6}\iexplore" /v "Flags" /t REG_DWORD /d "4" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{884E2049-217D-11DA-B2A4-000E7BBB2B09}\iexplore" /v "Flags" /t REG_DWORD /d "4" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{884E2051-217D-11DA-B2A4-000E7BBB2B09}\iexplore" /v "Flags" /t REG_DWORD /d "4" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{88D96A05-F192-11D4-A65F-0040963251E5}\iexplore" /v "Flags" /t REG_DWORD /d "4" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{88D96A06-F192-11D4-A65F-0040963251E5}\iexplore" /v "Flags" /t REG_DWORD /d "4" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{88D96A07-F192-11D4-A65F-0040963251E5}\iexplore" /v "Flags" /t REG_DWORD /d "4" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{88D96A08-F192-11D4-A65F-0040963251E5}\iexplore" /v "Flags" /t REG_DWORD /d "4" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{88D96A0A-F192-11D4-A65F-0040963251E5}\iexplore" /v "Flags" /t REG_DWORD /d "4" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{8E4062D9-FE1B-4B9E-AA16-5E8EEF68F48E}\iexplore" /v "Flags" /t REG_DWORD /d "4" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{D2517915-48CE-4286-970F-921E881B8C5C}\iexplore" /v "Flags" /t REG_DWORD /d "4" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{EE09B103-97E0-11CF-978F-00A02463E06F}\iexplore" /v "Flags" /t REG_DWORD /d "4" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{F5078F32-C551-11D3-89B9-0000F81FE221}\iexplore" /v "Flags" /t REG_DWORD /d "4" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{F5078F33-C551-11D3-89B9-0000F81FE221}\iexplore" /v "Flags" /t REG_DWORD /d "4" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{F5078F34-C551-11D3-89B9-0000F81FE221}\iexplore" /v "Flags" /t REG_DWORD /d "4" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{F5078F35-C551-11D3-89B9-0000F81FE221}\iexplore" /v "Flags" /t REG_DWORD /d "4" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{F5078F36-C551-11D3-89B9-0000F81FE221}\iexplore" /v "Flags" /t REG_DWORD /d "4" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{F5078F39-C551-11D3-89B9-0000F81FE221}\iexplore" /v "Flags" /t REG_DWORD /d "4" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{F6D90F12-9C73-11D3-B32E-00C04F990BB4}\iexplore" /v "Flags" /t REG_DWORD /d "4" /f >nul 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{F6D90F14-9C73-11D3-B32E-00C04F990BB4}\iexplore" /v "Flags" /t REG_DWORD /d "4" /f >nul 2>&1


REM Adjusts TCP/IP settings for better network performance
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v "Class" /t REG_DWORD /d "8" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v "LocalPriority" /t REG_DWORD /d "4" /f >nul 2>&1

REM Optimizes Microsoft Message Queuing (MSMQ) network settings
Reg.exe add "HKLM\SOFTWARE\Microsoft\MSMQ\Parameters" /v "TCPNoDelay" /t REG_DWORD /d "1" /f >nul 2>&1

REM Disables System Restore Point creation frequency
REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" /V "SystemRestorePointCreationFrequency" /T REG_DWORD /D 0 /F >nul 2>&1

REM Adjusts TCP/IP parameters for better network performance
REG ADD HKey_Local_Machine\System\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\ /v TcpAckFrequency /t REG_DWORD /d 0 /f >nul 2>&1
REG ADD HKey_Local_Machine\System\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\ /v TCPNoDelay /t REG_DWORD /d 0 /f >nul 2>&1

REM Modifies power-saving settings for network adapters
Reg.exe add "HKLM\System\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0001" /v "MIMOPowerSaveMode" /t REG_SZ /d "3" /f >nul 2>&1
Reg.exe add "HKLM\System\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0001" /v "PowerSavingMode" /t REG_SZ /d "0" /f >nul 2>&1
Reg.exe add "HKLM\System\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0001" /v "EnableGreenEthernet" /t REG_SZ /d "0" /f >nul 2>&1
Reg.exe add "HKLM\System\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0001" /v "*EEE" /t REG_SZ /d "0" /f >nul 2>&1
Reg.exe add "HKLM\System\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0001" /v "PnPCapabilities" /t REG_DWORD /d "24" /f >nul 2>&1

REM Similar modifications for another network adapter instance
Reg.exe add "HKLM\System\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0002" /v "MIMOPowerSaveMode" /t REG_SZ /d "3" /f >nul 2>&1
Reg.exe add "HKLM\System\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0002" /v "PowerSavingMode" /t REG_SZ /d "0" /f >nul 2>&1
Reg.exe add "HKLM\System\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0002" /v "EnableGreenEthernet" /t REG_SZ /d "0" /f >nul 2>&1
Reg.exe add "HKLM\System\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0002" /v "*EEE" /t REG_SZ /d "0" /f >nul 2>&1
Reg.exe add "HKLM\System\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0002" /v "PnPCapabilities" /t REG_DWORD /d "24" /f >nul 2>&1

REM Configures Quality of Service (QoS) and other TCP/IP settings
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched" /v "NonBestEffortLimit" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnablePMTUBHDetect" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpMaxConnectRetransmissions" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "Tcp1323Opts" /t REG_DWORD /d "1" /f >nul 2>&1

REM Adjusts settings for the LanmanServer service
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "IRPStackSize" /t REG_DWORD /d "50" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "SizReqBuf" /t REG_DWORD /d "17424" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "Size" /t REG_DWORD /d "3" /f >nul 2>&1

REM Configures additional TCP/IP and Winsock parameters
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Winsock" /v "UseDelayedAcceptance" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Winsock" /v "MaxSockAddrLength" /t REG_DWORD /d "16" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Winsock" /v "MinSockAddrLength" /t REG_DWORD /d "16" /f >nul 2>&1

REM Adjusts multimedia network throttling settings
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d "10" /f >nul 2>&1

REM Disables Network Location Awareness (NLA) for Quality of Service (QoS)
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\QoS" /v "Do not use NLA" /t REG_SZ /d "1" /f >nul 2>&1

REM Configures DNS cache parameters
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "NegativeCacheTime" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "NegativeSOACacheTime" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "NetFailureCacheTime" /t REG_DWORD /d "0" /f >nul 2>&1

REM Adjusts Windows data collection settings
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "DoNotShowFeedbackNotifications" /t REG_DWORD /d "1" /f >nul 2>&1

REM Configures maximum connections per server for internet settings
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v MaxConnectionsPerServer /t REG_DWORD /d 8 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v MaxConnectionsPer1_0Server /t REG_DWORD /d 8 /f >nul 2>&1
reg add "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v MaxConnectionsPerServer /t REG_DWORD /d 8 /f >nul 2>&1
reg add "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v MaxConnectionsPer1_0Server /t REG_DWORD /d 8 /f >nul 2>&1

REM Adjusts Psched (QoS Packet Scheduler) settings
reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched /v TimerResolution /t REG_DWORD /d 1 /f >nul 2>&1
reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched /v NonBestEffortLimit /t REG_DWORD /d 0 /f >nul 2>&1
reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched /v MaxOutstandingSends /t REG_DWORD /d 0 /f >nul 2>&1

set "file=C:\Vitality\Info\network"
if not exist "%file%" (
    echo Vitality > "%file%"
    set /a "ran_optimizations+=1"
)
cd C:\Vitality
set "formatted_optimizations=%ran_optimizations%"
if %formatted_optimizations% LSS 10 set "formatted_optimizations= %formatted_optimizations%"
echo set "ran_optimizations=%ran_optimizations%"> v.bat

:skippingnetwork


if "%KBM%"=="false" goto skippingkbm
echo                                                     Applying KBM Tweaks

REM Adjusts keyboard parameters
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\kbdclass\Parameters" /v "KeyboardDataQueueSize" /t REG_DWORD /d "50" /f >nul 2>&1
reg.exe add "HKCU\Control Panel\Keyboard" /v "KeyboardSpeed" /t REG_SZ /d "31" /f >nul 2>&1
reg.exe add "HKCU\Control Panel\Keyboard" /v "KeyboardDelay" /t REG_SZ /d "0" /f >nul 2>&1

REM Configures keyboard accessibility settings
Reg.exe add "HKCU\Control Panel\Accessibility\Keyboard Response" /v "BounceTime" /t REG_SZ /d "0" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Accessibility\Keyboard Response" /v "Flags" /t REG_SZ /d "0" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Accessibility\Keyboard Response" /v "Last BounceKey Setting" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Accessibility\Keyboard Response" /v "Last Valid Delay" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Accessibility\Keyboard Response" /v "Last Valid Repeat" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Accessibility\Keyboard Response" /v "Last Valid Wait" /t REG_DWORD /d "1000" /f >nul 2>&1

REM Adjusts mouse parameters
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\mouclass\Parameters" /v "MouseDataQueueSize" /t REG_DWORD /d "50" /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v "MouseSpeed" /t REG_DWORD /d "0" /f  >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v "MouseThreshold1" /t REG_DWORD /d "0" /f   >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v "MouseThreshold2" /t REG_DWORD /d "0" /f  >nul 2>&1

REM Configures mouse accessibility settings
Reg.exe add "HKCU\Control Panel\Accessibility\MouseKeys" /v "Flags" /t REG_SZ /d "0" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Accessibility\MouseKeys" /v "MaximumSpeed" /t REG_SZ /d "80" /f >nul 2>&1
Reg.exe add "HKCU\Control Panel\Accessibility\MouseKeys" /v "TimeToMaximumSpeed" /t REG_SZ /d "3000" /f >nul 2>&1

set "file=C:\Vitality\Info\kbm"
if not exist "%file%" (
    echo Vitality > "%file%"
    set /a "ran_optimizations+=1"
)
cd C:\Vitality
set "formatted_optimizations=%ran_optimizations%"
if %formatted_optimizations% LSS 10 set "formatted_optimizations= %formatted_optimizations%"
echo set "ran_optimizations=%ran_optimizations%"> v.bat






:skippingkbm
if "%Task%"=="false" goto skippingtask
echo                                               Applying Task Scheduler Tweaks
REM Disable Not Used Scheduler Tasks
schtasks /Change /TN "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Diagnosis\Scheduled" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Location\Notifications" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Location\WindowsActionDialog" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Offline Files\Background Synchronization" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Offline Files\Logon Synchronization" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Time Synchronization\ForceSynchronizeTime" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Time Synchronization\SynchronizeTime" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Time Zone\SynchronizeTimeZone" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\UpdateOrchestrator\Schedule Scan" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\UpdateOrchestrator\Schedule Scan Static Task" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\UpdateOrchestrator\Reboot" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\USB\Usb-Notifications" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\WDI\ResolutionHost" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\WindowsUpdate\Scheduled Start" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Workplace Join\Automatic-Device-Join" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Workplace Join\Recovery-Check"  /Disable >nul 2>&1

set "file=C:\Vitality\Info\task"
if not exist "%file%" (
    echo Vitality > "%file%"
    set /a "ran_optimizations+=1"
)
cd C:\Vitality
set "formatted_optimizations=%ran_optimizations%"
if %formatted_optimizations% LSS 10 set "formatted_optimizations= %formatted_optimizations%"
echo set "ran_optimizations=%ran_optimizations%"> v.bat

:skippingtask 



if "%GPU%"=="false" goto skippinggpu

if %gpu1%==Nvidia (
    goto nvidia
) else (
    goto checkforradeon
)

:checkforradeon
if %gpu1%==AMD (
    goto radeon
) else (
    goto nullgpu
)

:nullgpu
echo                                            Your GPU is not supported by Vitality.

:nvidia
echo                                                   Applying Nvidia Tweaks
REM Modifies settings for the nvlddmkm driver
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\FTS" /v "EnableRID61684" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\FTS" /v "EnablePreemption" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\FTS" /v "GPUPreemptionLevel" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\FTS" /v "ComputePreemption" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\FTS" /v "EnableMidGfxPreemptionVGPU" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\FTS" /v "EnableMidBufferPreemptionForHighTdrTimeout" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\FTS" /v "EnableAsyncMidBufferPreemption" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\FTS" /v "EnableSCGMidBufferPreemption" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\FTS" /v "PerfAnalyzeMidBufferPreemption" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\FTS" /v "EnableMidGfxPreemption" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\FTS" /v "EnableMidBufferPreemption" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\FTS" /v "EnableCEPreemption" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\FTS" /v "DisableCudaContextPreemption" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\FTS" /v "DisablePreemptionOnS3S4" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\FTS" /v "DisablePreemption" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\FTS" /v "DisablePreemption" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\FTS" /v "DisableCudaContextPreemption" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\FTS" /v "EnablePreemption" /t REG_DWORD /d "0" /f >nul 2>&1

REM Modifies settings in the GraphicsDrivers section
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "RMDisablePostL2Compression" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "RmDisableRegistryCaching" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "RmGpsPsEnablePerCpuCoreDpc" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "DisableWriteCombining" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "EnablePreemption" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "GPUPreemptionLevel" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "ComputePreemption" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "EnableMidGfxPreemptionVGPU" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "EnableMidBufferPreemptionForHighTdrTimeout" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "EnableAsyncMidBufferPreemption" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "EnableSCGMidBufferPreemption" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "PerfAnalyzeMidBufferPreemption" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "EnableMidGfxPreemption" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "EnableMidBufferPreemption" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "EnableCEPreemption" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "DisableCudaContextPreemption" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "DisablePreemptionOnS3S4" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "MonitorLatencyTolerance" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "MonitorRefreshLatencyTolerance" /t REG_DWORD /d "0" /f >nul 2>&1

REM Modifies settings in the Power section of GraphicsDrivers
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "RMDisablePostL2Compression" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "RmDisableRegistryCaching" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "RmGpsPsEnablePerCpuCoreDpc" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DisableWriteCombining" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "EnablePreemption" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "GPUPreemptionLevel" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "ComputePreemption" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "EnableMidGfxPreemptionVGPU" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "EnableMidBufferPreemptionForHighTdrTimeout" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "EnableAsyncMidBufferPreemption" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "EnableSCGMidBufferPreemption" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "PerfAnalyzeMidBufferPreemption" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "EnableMidGfxPreemption" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "EnableMidBufferPreemption" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "EnableCEPreemption" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DisableCudaContextPreemption" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DisablePreemptionOnS3S4" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "MonitorLatencyTolerance" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "MonitorRefreshLatencyTolerance" /t REG_DWORD /d "0" /f >nul 2>&1

REM Modifies settings for the nvlddmkm driver
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\nvlddmkm" /v "EnableBugcheckDisplay" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\nvlddmkm" /v "DisableMshybridNvsrSwitch" /t REG_DWORD /d "1" /f >nul 2>&1

REM Modifies settings for the nvlddmkm driver
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\nvlddmkm" /v "LogWarningEntries" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\nvlddmkm" /v "LogPagingEntries" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\nvlddmkm" /v "LogEventEntries" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\nvlddmkm" /v "LogErrorEntries" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\nvlddmkm" /v "DisablePreemption" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\nvlddmkm" /v "DisableCudaContextPreemption" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\nvlddmkm" /v "EnableCEPreemption" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\nvlddmkm" /v "DisablePreemptionOnS3S4" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\nvlddmkm" /v "ComputePreemption" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\nvlddmkm" /v "EnableMidGfxPreemption" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\nvlddmkm" /v "EnableMidGfxPreemptionVGPU" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\nvlddmkm" /v "EnableMidBufferPreemptionForHighTdrTimeout" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\nvlddmkm" /v "EnableMidBufferPreemption" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\nvlddmkm" /v "EnableAsyncMidBufferPreemption" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\nvlddmkm" /v "DisableCudaContextPreemption" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\nvlddmkm" /v "PerfAnalyzeMidBufferPreemption" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\nvlddmkm\Global\NVTweak" /v "DisplayPowerSaving" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\GraphicsDrivers\Scheduler" /v "EnablePreemption" /t REG_DWORD /d "0" /f >nul 2>&1

REM Modifies settings for a specific graphics driver in Class
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RMDisablePostL2Compression" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmDisableRegistryCaching" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmGpsPsEnablePerCpuCoreDpc" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DisableWriteCombining" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "EnablePreemption" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "GPUPreemptionLevel" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "ComputePreemption" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "EnableMidGfxPreemptionVGPU" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "EnableMidBufferPreemptionForHighTdrTimeout" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "EnableAsyncMidBufferPreemption" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "EnableSCGMidBufferPreemption" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "PerfAnalyzeMidBufferPreemption" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "EnableMidGfxPreemption" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "EnableMidBufferPreemption" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "EnableCEPreemption" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DisableCudaContextPreemption" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DisablePreemptionOnS3S4" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "MonitorLatencyTolerance" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "MonitorRefreshLatencyTolerance" /t REG_DWORD /d "0" /f >nul 2>&1

REM Modifies GPU Scheduler Settings
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "RMDisablePostL2Compression" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "RmDisableRegistryCaching" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "RmGpsPsEnablePerCpuCoreDpc" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "DisableWriteCombining" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnablePreemption" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "GPUPreemptionLevel" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "ComputePreemption" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnableMidGfxPreemptionVGPU" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnableMidBufferPreemptionForHighTdrTimeout" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnableAsyncMidBufferPreemption" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnableSCGMidBufferPreemption" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "PerfAnalyzeMidBufferPreemption" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnableMidGfxPreemption" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnableMidBufferPreemption" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnableCEPreemption" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "DisableCudaContextPreemption" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "DisablePreemptionOnS3S4" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "MonitorLatencyTolerance" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "MonitorRefreshLatencyTolerance" /t REG_DWORD /d "0" /f >nul 2>&1

REM Graphics Driver Settings
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "RmGpsPsEnablePerCpuCoreDpc" /t REG_DWORD /d "1" /f >nul 2>&1

REM Graphics Driver Power Settings
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "RmGpsPsEnablePerCpuCoreDpc" /t REG_DWORD /d "1" /f >nul 2>&1

REM Nvidia Graphics Driver Settings
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "RmGpsPsEnablePerCpuCoreDpc" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\NVAPI" /v "RmGpsPsEnablePerCpuCoreDpc" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\NVTweak" /v "RmGpsPsEnablePerCpuCoreDpc" /t REG_DWORD /d "1" /f >nul 2>&1

REM Nvidia Graphics Driver Advanced Settings
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "DisablePreemption" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "DisableCudaContextPreemption" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "DisableWriteCombining" /t REG_DWORD /d "1" /f >nul 2>&1

REM Graphics Scheduler Settings
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnablePreemption" /t REG_DWORD /d "0" /f >nul 2>&1

REM Power Management Settings
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatency" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatencyCheckEnabled" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "Latency" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceDefault" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceFSVP" /t REG_DWORD /d "1" /f >nul 2>&1

REM More Power Management Latency Settings
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyTolerancePerfOverride" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceScreenOffIR" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceVSyncEnabled" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "RtlCapabilityCheckLatency" /t REG_DWORD /d "1" /f >nul 2>&1

REM More Power Management Settings
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "QosManagesIdleProcessors" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DisableVsyncLatencyUpdate" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DisableSensorWatchdog" /t REG_DWORD /d "1" /f >nul 2>&1

REM Further Power Management Settings
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "InterruptSteeringDisabled" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LowLatencyScalingPercentage" /t REG_DWORD /d "100" /f >nul 2>&1

REM Performance Settings
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HighPerformance" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HighestPerformance" /t REG_DWORD /d "1" /f >nul 2>&1

REM CPU Throttle Settings
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MinimumThrottlePercent" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaximumThrottlePercent" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaximumPerformancePercent" /t REG_DWORD /d "100" /f >nul 2>&1

REM Miscellaneous Power Settings
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "InitialUnparkCount" /t REG_DWORD /d "100" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyActivelyUsed" /t REG_DWORD /d "0" /f >nul 2>&1

REM More Latency Tolerance Settings
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleLongTime" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleMonitorOff" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleNoContext" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleShortTime" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleVeryLongTime" /t REG_DWORD /d "1" /f >nul 2>&1

REM Default Latency Tolerance Settings
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle0" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle0MonitorOff" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle1" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle1MonitorOff" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceMemory" /t REG_DWORD /d "1" /f >nul 2>&1

REM Default Latency Tolerance for No Context
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceNoContext" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceNoContextMonitorOff" /t REG_DWORD /d "1" /f >nul 2>&1

REM Other Default Latency Tolerances
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceOther" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceTimerPeriod" /t REG_DWORD /d "1" /f >nul 2>&1

REM Memory Refresh Latency Tolerance Settings
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceActivelyUsed" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceMonitorOff" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceNoContext" /t REG_DWORD /d "1" /f >nul 2>&1

REM More Latency and Performance Settings
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "Latency" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaxIAverageGraphicsLatencyInOneBucket" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MiracastPerfTrackGraphicsLatency" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MonitorLatencyTolerance" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MonitorRefreshLatencyTolerance" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "TransitionLatency" /t REG_DWORD /d "1" /f >nul 2>&1

REM Graphics Driver Settings
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "Acceleration.Level" /t REG_DWORD /d "0" /f >nul 2>&1

REM Disable Desktop Stereo Shortcuts
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DesktopStereoShortcuts" /t REG_DWORD /d "0" /f >nul 2>&1

REM Set Feature Control to 4
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "FeatureControl" /t REG_DWORD /d "4" /f >nul 2>&1

REM Disable NVDevice Support KFilter
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "NVDeviceSupportKFilter" /t REG_DWORD /d "0" /f >nul 2>&1

REM Disable RmCacheLoc
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmCacheLoc" /t REG_DWORD /d "0" /f >nul 2>&1

REM Disable RmDisableInst2Sys
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmDisableInst2Sys" /t REG_DWORD /d "0" /f >nul 2>&1

REM Enable RmFbsrPagedDMA
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmFbsrPagedDMA" /t REG_DWORD /d "1" /f >nul 2>&1

REM Set RMGpuId to 256
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RMGpuId" /t REG_DWORD /d "256" /f >nul 2>&1

REM Disable RmProfilingAdminOnly
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmProfilingAdminOnly" /t REG_DWORD /d "0" /f >nul 2>&1

REM Disable TCCSupported
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "TCCSupported" /t REG_DWORD /d "0" /f >nul 2>&1

REM Disable TrackResetEngine
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "TrackResetEngine" /t REG_DWORD /d "0" /f >nul 2>&1

REM Set UseBestResolution to 1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "UseBestResolution" /t REG_DWORD /d "1" /f >nul 2>&1

REM Disable ValidateBlitSubRects
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "ValidateBlitSubRects" /t REG_DWORD /d "0" /f >nul 2>&1

REM Disable Graphics Scheduler Preemption
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnablePreemption" /t REG_DWORD /d "0" /f >nul 2>&1

REM Disable Platform Support for Miracast
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "PlatformSupportMiracast" /t REG_DWORD /d "0" /f >nul 2>&1

REM Configure nvlddmkm Services
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "RMPcieLinkSpeed" /t REG_DWORD /d "4" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "EnablePreemption" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "GPUPreemptionLevel" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "ComputePreemption" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "EnableMidGfxPreemptionVGPU" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "EnableMidBufferPreemptionForHighTdrTimeout" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "EnableAsyncMidBufferPreemption" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "EnableSCGMidBufferPreemption" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "PerfAnalyzeMidBufferPreemption" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "EnableMidGfxPreemption" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "EnableMidBufferPreemption" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "EnableCEPreemption" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "DisableCudaContextPreemption" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "DisablePreemptionOnS3S4" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "DisablePreemption" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Parameters" /v "ThreadPriority" /t REG_DWORD /d "31" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "DisablePreemption" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "DisableCudaContextPreemption" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnablePreemption" /t REG_DWORD /d "0" /f >nul 2>&1

REM Applying Custon Nvidia Profile Inspector Config (HoneCTRL) [https://github.com/Orbmu2k/nvidiaProfileInspector]
if exist "%SYSTEMDRIVE%\Vitality\Resources\nvidiaProfileInspector" (
    rd /s /q "%SYSTEMDRIVE%\Vitality\Resources\nvidiaProfileInspector"  >nul 2>&1
) 
if not exist "%SYSTEMDRIVE%\Vitality\Resources\nvidiaProfileInspector" md "%SYSTEMDRIVE%\Vitality\Resources\nvidiaProfileInspector"  >nul 2>&1
curl -g -L -# -o "%SYSTEMDRIVE%\Vitality\Resources\nvidiaProfileInspector\nvidiaProfileInspector.zip" "https://github.com/Orbmu2k/nvidiaProfileInspector/releases/latest/download/nvidiaProfileInspector.zip"  >nul 2>&1
powershell -NoProfile Expand-Archive '%SYSTEMDRIVE%\Vitality\Resources\nvidiaProfileInspector\nvidiaProfileInspector.zip' -DestinationPath '%SYSTEMDRIVE%\Vitality\Resources\nvidiaProfileInspector' >nul 2>&1
del /F /Q "%SYSTEMDRIVE%\Vitality\Resources\nvidiaProfileInspector\nvidiaProfileInspector.zip"  >nul 2>&1
curl -g -L -# -o "%SYSTEMDRIVE%\Vitality\Resources\nvidiaProfileInspector\Vitality.nip" "https://cdn.discordapp.com/attachments/1140029335944835152/1142006515520249886/Vitality.nip"  >nul 2>&1
cd "%SYSTEMDRIVE%\Vitality\Resources\nvidiaProfileInspector\"  >nul 2>&1
nvidiaProfileInspector.exe "Vitality.nip" >nul 2>&1


set "file=C:\Vitality\Info\gpu"
if not exist "%file%" (
    echo Vitality > "%file%"
    set /a "ran_optimizations+=1"
)
cd C:\Vitality
set "formatted_optimizations=%ran_optimizations%"
if %formatted_optimizations% LSS 10 set "formatted_optimizations= %formatted_optimizations%"
echo set "ran_optimizations=%ran_optimizations%"> v.bat
goto skippinggpu









:radeon
echo                                                   Applying Radeon Tweaks
REM LTR (Latency Tolerance Reporting) Settings
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "LTRSnoopL1Latency" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "LTRSnoopL0Latency" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "LTRNoSnoopL1Latency" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "LTRMaxNoSnoopLatency" /t REG_DWORD /d "1" /f >nul 2>&1

REM KMD (Kernel Mode Driver) Settings
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "LTRMaxNoSnoopLatency" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "KMD_RpmComputeLatency" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DalUrgentLatencyNs" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "memClockSwitchLatency" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "PP_RTPMComputeF1Latency" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "PP_DGBMMMaxTransitionLatencyUvd" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "PP_DGBPMMaxTransitionLatencyGfx" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DalNBLatencyForUnderFlow" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "BGM_LTRSnoopL1Latency" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "BGM_LTRSnoopL0Latency" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "BGM_LTRNoSnoopL1Latency" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "BGM_LTRNoSnoopL0Latency" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "BGM_LTRMaxSnoopLatencyValue" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "BGM_LTRMaxNoSnoopLatencyValue" /t REG_DWORD /d "1" /f >nul 2>&1

REM AMD Software Settings
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\AMD Log Utility" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\AMD External Events Utility" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\amdlog" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
Reg.exe add "HKEY_CURRENT_USER\Software\AMD\CN" /v "AutoUpdateTriggered" /t REG_DWORD /d "0" /f > nul 2>&1 > nul 2>&1
Reg.exe add "HKEY_CURRENT_USER\Software\AMD\CN" /v "PowerSaverAutoEnable_CUR" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKEY_CURRENT_USER\Software\AMD\CN" /v "WindowSize" /t REG_SZ /d "1440,960" /f > nul 2>&1
Reg.exe add "HKEY_CURRENT_USER\Software\AMD\CN" /v "BuildType" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKEY_CURRENT_USER\Software\AMD\CN" /v "WizardProfile" /t REG_SZ /d "PROFILE_CUSTOM" /f > nul 2>&1
Reg.exe add "HKEY_CURRENT_USER\Software\AMD\CN" /v "UserTypeWizardShown" /t REG_DWORD /d "1" /f > nul 2>&1
Reg.exe add "HKEY_CURRENT_USER\Software\AMD\CN" /v "LastPage" /t REG_SZ /d "settings/graphics/0/" /f > nul 2>&1
Reg.exe add "HKEY_CURRENT_USER\Software\AMD\CN" /v "AutoUpdate" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKEY_CURRENT_USER\Software\AMD\CN" /v "RSXBrowserUnavailable" /t REG_SZ /d "true" /f > nul 2>&1
Reg.exe add "HKEY_CURRENT_USER\Software\AMD\CN" /v "SYSTEMTray" /t REG_SZ /d "false" /f > nul 2>&1
Reg.exe add "HKEY_CURRENT_USER\Software\AMD\CN" /v "AllowWebContent" /t REG_SZ /d "false" /f > nul 2>&1
Reg.exe add "HKEY_CURRENT_USER\Software\AMD\CN" /v "CN_Hide_Toast_Notification" /t REG_SZ /d "true" /f > nul 2>&1
Reg.exe add "HKEY_CURRENT_USER\Software\AMD\CN" /v "AnimationEffect" /t REG_SZ /d "false" /f > nul 2>&1
Reg.exe add "HKEY_CURRENT_USER\Software\AMD\CN\OverlayNotification" /v "AlreadyNotified" /t REG_DWORD /d "1" /f > nul 2>&1
Reg.exe add "HKEY_CURRENT_USER\Software\AMD\CN\VirtualSuperResolution" /v "AlreadyNotified" /t REG_DWORD /d "1" /f > nul 2>&1

REM AMD DVR Settings
Reg.exe add "HKEY_CURRENT_USER\Software\AMD\DVR" /v "PerformanceMonitorOpacityWA" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKEY_CURRENT_USER\Software\AMD\DVR" /v "CaptureFileOutput" /t REG_SZ /d "C:\Users\Emre\Videos\Radeon ReLive" /f > nul 2>&1
Reg.exe add "HKEY_CURRENT_USER\Software\AMD\DVR" /v "DvrEnabled" /t REG_DWORD /d "1" /f > nul 2>&1
Reg.exe add "HKEY_CURRENT_USER\Software\AMD\DVR" /v "ActiveSceneId" /t REG_SZ /d "0" /f > nul 2>&1
Reg.exe add "HKEY_CURRENT_USER\Software\AMD\DVR" /v "AVCCaps" /t REG_SZ /d "256,1,4096,4096,100000000,244800,0;" /f > nul 2>&1
Reg.exe add "HKEY_CURRENT_USER\Software\AMD\DVR" /v "HEVCCaps" /t REG_SZ /d "256,1,4096,4096,2147483647,979200,0;" /f > nul 2>&1
Reg.exe add "HKEY_CURRENT_USER\Software\AMD\DVR" /v "AvcEfcSupport" /t REG_SZ /d "0;" /f > nul 2>&1
Reg.exe add "HKEY_CURRENT_USER\Software\AMD\DVR" /v "HevcEfcSupport" /t REG_SZ /d "0;" /f > nul 2>&1
Reg.exe add "HKEY_CURRENT_USER\Software\AMD\DVR" /v "PrevInstantReplayEnable" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKEY_CURRENT_USER\Software\AMD\DVR" /v "PrevInGameReplayEnabled" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKEY_CURRENT_USER\Software\AMD\DVR" /v "PrevInstantGifEnabled" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKEY_CURRENT_USER\Software\AMD\DVR" /v "DvrDesktops" /t REG_SZ /d "\\.\DISPLAY19" /f > nul 2>&1
Reg.exe add "HKEY_CURRENT_USER\Software\AMD\DVR" /v "RemoteServerStatus" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKEY_CURRENT_USER\Software\AMD\DVR" /v "ShowRSOverlay" /t REG_SZ /d "false" /f > nul 2>&1
Reg.exe add "HKEY_CURRENT_USER\Software\AMD\SCENE\0" /v "CameraSize" /t REG_DWORD /d "3" /f > nul 2>&1
Reg.exe add "HKEY_CURRENT_USER\Software\AMD\SCENE\0" /v "CameraEnabled" /t REG_DWORD /d "1" /f > nul 2>&1
Reg.exe add "HKEY_CURRENT_USER\Software\AMD\SCENE\0" /v "CameraOpacity" /t REG_DWORD /d "100" /f > nul 2>&1
Reg.exe add "HKEY_CURRENT_USER\Software\AMD\SCENE\0" /v "CameraAnchor" /t REG_DWORD /d "3" /f > nul 2>&1
Reg.exe add "HKEY_CURRENT_USER\Software\AMD\SCENE\0" /v "CameraShownOnScreen" /t REG_DWORD /d "1" /f > nul 2>&1
Reg.exe add "HKEY_CURRENT_USER\Software\AMD\SCENE\0" /v "IndicatorPosition" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKEY_CURRENT_USER\Software\AMD\SCENE\0" /v "TimerEnabled" /t REG_DWORD /d "1" /f > nul 2>&1
Reg.exe add "HKEY_CURRENT_USER\Software\AMD\SCENE\0" /v "ChatOverlayEnabled" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKEY_CURRENT_USER\Software\AMD\SCENE\0" /v "ChatCustomOffset" /t REG_SZ /d "0.0260,0.0462" /f > nul 2>&1
Reg.exe add "HKEY_CURRENT_USER\Software\AMD\SCENE\0" /v "ChatOverlayAnchor" /t REG_DWORD /d "4" /f > nul 2>&1
Reg.exe add "HKEY_CURRENT_USER\Software\AMD\SCENE\0" /v "ChatBackgroundBlur" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKEY_CURRENT_USER\Software\AMD\SCENE\0" /v "ChatFontSize" /t REG_DWORD /d "1" /f > nul 2>&1
Reg.exe add "HKEY_CURRENT_USER\Software\AMD\SCENE\0" /v "RelativeCoords" /t REG_DWORD /d "1" /f > nul 2>&1
Reg.exe add "HKEY_CURRENT_USER\Software\AMD\SCENE\0" /v "CameraOffset" /t REG_SZ /d "0.0208,0.0370" /f > nul 2>&1
Reg.exe add "HKEY_CURRENT_USER\Software\AMD\SCENE\0" /v "CameraCustomOffset" /t REG_SZ /d "0.0208,0.0370" /f > nul 2>&1
Reg.exe add "HKEY_CURRENT_USER\Software\AMD\SCENE\0" /v "CameraRect" /t REG_SZ /d "0.1667,0.2222" /f > nul 2>&1
Reg.exe add "HKEY_CURRENT_USER\Software\AMD\SCENE\0" /v "CameraCustomRect" /t REG_SZ /d "0.1667,0.2222" /f > nul 2>&1
Reg.exe add "HKEY_CURRENT_USER\Software\AMD\SCENE\0" /v "ChatCustomRect" /t REG_SZ /d "0.1562,0.1562" /f > nul 2>&1
Reg.exe add "HKEY_CURRENT_USER\Software\AMD\SCENE\0" /v "ChatOverlaySize" /t REG_DWORD /d "3" /f > nul 2>&1
Reg.exe add "HKEY_CURRENT_USER\Software\ATI\ACE\Settings\ADL\AppProfiles" /v "AplReloadCounter" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\Software\AMD\Install" /v "AUEP" /t REG_DWORD /d "1" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\Software\AUEP" /v "RSX_AUEPStatus" /t REG_DWORD /d "2" /f > nul 2>&1

REM UMD (User Mode Driver) Settings
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "NotifySubscription" /t REG_BINARY /d "3000" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "IsComponentControl" /t REG_BINARY /d "00000000" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "KMD_USUEnable" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "KMD_RadeonBoostEnabled" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "IsAutoDefault" /t REG_BINARY /d "01000000" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "KMD_ChillEnabled" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "KMD_DeLagEnabled" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "ACE" /t REG_BINARY /d "3000" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "AnisoDegree_SET" /t REG_BINARY /d "3020322034203820313600" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "Main3D_SET" /t REG_BINARY /d "302031203220332034203500" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "Tessellation_OPTION" /t REG_BINARY /d "3200" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "Tessellation" /t REG_BINARY /d "3100" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "AAF" /t REG_BINARY /d "30000000" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "GI" /t REG_BINARY /d "31000000" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "CatalystAI" /t REG_BINARY /d "31000000" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "TemporalAAMultiplier_NA" /t REG_BINARY /d "3100" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "ForceZBufferDepth" /t REG_BINARY /d "30000000" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "EnableTripleBuffering" /t REG_BINARY /d "3000" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "ExportCompressedTex" /t REG_BINARY /d "31000000" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "PixelCenter" /t REG_BINARY /d "30000000" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "ZFormats_NA" /t REG_BINARY /d "3100" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "DitherAlpha_NA" /t REG_BINARY /d "3100" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "SwapEffect_D3D_SET" /t REG_BINARY /d "3020312032203320342038203900" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "TFQ" /t REG_BINARY /d "3200" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "VSyncControl" /t REG_BINARY /d "3100" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "TextureOpt" /t REG_BINARY /d "30000000" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "TextureLod" /t REG_BINARY /d "30000000" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "ASE" /t REG_BINARY /d "3000" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "ASD" /t REG_BINARY /d "3000" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "ASTT" /t REG_BINARY /d "3000" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "AntiAliasSamples" /t REG_BINARY /d "3000" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "AntiAlias" /t REG_BINARY /d "3100" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "AnisoDegree" /t REG_BINARY /d "3000" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "AnisoType" /t REG_BINARY /d "30000000" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "AntiAliasMapping_SET" /t REG_BINARY /d "3028303A302C313A3029203228303A322C313A3229203428303A342C313A3429203828303A382C313A382900" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "AntiAliasSamples_SET" /t REG_BINARY /d "3020322034203800" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "ForceZBufferDepth_SET" /t REG_BINARY /d "3020313620323400" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "SwapEffect_OGL_SET" /t REG_BINARY /d "3020312032203320342035203620372038203920313120313220313320313420313520313620313700" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "Tessellation_SET" /t REG_BINARY /d "31203220342036203820313620333220363400" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "HighQualityAF" /t REG_BINARY /d "3100" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "DisplayCrossfireLogo" /t REG_BINARY /d "3000" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "AppGpuId" /t REG_BINARY /d "300078003000310030003000" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "SwapEffect" /t REG_BINARY /d "30000000" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "PowerState" /t REG_BINARY /d "3000" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "AntiStuttering" /t REG_BINARY /d "3100" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "TurboSync" /t REG_BINARY /d "3000" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "SurfaceFormatReplacements" /t REG_BINARY /d "3100" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "EQAA" /t REG_BINARY /d "3000" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "ShaderCache" /t REG_BINARY /d "3100" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "MLF" /t REG_BINARY /d "3000" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "TruformMode_NA" /t REG_BINARY /d "3100" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "LRTCEnable" /t REG_BINARY /d "30000000" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "3to2Pulldown" /t REG_BINARY /d "31000000" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "MosquitoNoiseRemoval_ENABLE" /t REG_BINARY /d "30000000" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "MosquitoNoiseRemoval" /t REG_BINARY /d "350030000000" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "Deblocking_ENABLE" /t REG_BINARY /d "30000000" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "Deblocking" /t REG_BINARY /d "350030000000" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "DemoMode" /t REG_BINARY /d "30000000" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "OverridePA" /t REG_BINARY /d "30000000" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "DynamicRange" /t REG_BINARY /d "30000000" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "StaticGamma_ENABLE" /t REG_BINARY /d "30000000" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "BlueStretch_ENABLE" /t REG_BINARY /d "31000000" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "BlueStretch" /t REG_BINARY /d "31000000" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "LRTCCoef" /t REG_BINARY /d "3100300030000000" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "DynamicContrast_ENABLE" /t REG_BINARY /d "30000000" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "WhiteBalanceCorrection" /t REG_BINARY /d "30000000" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "Fleshtone_ENABLE" /t REG_BINARY /d "30000000" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "Fleshtone" /t REG_BINARY /d "350030000000" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "ColorVibrance_ENABLE" /t REG_BINARY /d "31000000" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "ColorVibrance" /t REG_BINARY /d "340030000000" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "Detail_ENABLE" /t REG_BINARY /d "30000000" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "Detail" /t REG_BINARY /d "310030000000" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "Denoise_ENABLE" /t REG_BINARY /d "30000000" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "Denoise" /t REG_BINARY /d "360034000000" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "TrueWhite" /t REG_BINARY /d "30000000" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "OvlTheaterMode" /t REG_BINARY /d "30000000" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "StaticGamma" /t REG_BINARY /d "3100300030000000" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "InternetVideo" /t REG_BINARY /d "30000000" /f > nul 2>&1

REM Disable AMD Chill (Power Saving)
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\amdwddmg" /v "ChillEnabled" /t REG_DWORD /d "0" /f > nul 2>&1

REM UMD Settings Related to 3D
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "Main3D_DEF" /t REG_SZ /d "1" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "Main3D" /t REG_BINARY /d "3100" /f > nul 2>&1

REM Disable DMA (Direct Memory Access) copy
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DisableDMACopy" /t REG_DWORD /d "1" /f > nul 2>&1

REM Enable Block Write Operations
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DisableBlockWrite" /t REG_DWORD /d "0" /f > nul 2>&1


REM Disable Automatic Thermal Throttling
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "PP_ThermalAutoThrottlingEnable" /t REG_DWORD /d "0" /f > nul 2>&1

REM Disable Power Gating For a DRM (Direct Rendering Manager) Component
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DisableDrmdmaPowerGating" /t REG_DWORD /d "1" /f > nul 2>&1

REM Disable AMD Services
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\AMD Crash Defender Service" /v "Start" /t REG_DWORD /d "4" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\AMD External Events Utility" /v "Start" /t REG_DWORD /d "4" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\amdfendr" /v "Start" /t REG_DWORD /d "4" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\amdfendrmgr" /v "Start" /t REG_DWORD /d "4" /f > nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\amdlog" /v "Start" /t REG_DWORD /d "4" /f > nul 2>&1

REM Debloat AMD Drivers (Credits amitxv)
rmdir /s /q "%PROGRAMFILES%\AMD\CNext\CNext\facebook" > nul 2>&1
rmdir /s /q "%PROGRAMFILES%\AMD\CNext\CNext\ffmpeg" > nul 2>&1
rmdir /s /q "%PROGRAMFILES%\AMD\CNext\CNext\Gfycat" > nul 2>&1
rmdir /s /q "%PROGRAMFILES%\AMD\CNext\CNext\localisation" > nul 2>&1
rmdir /s /q "%PROGRAMFILES%\AMD\CNext\CNext\mixer" > nul 2>&1
rmdir /s /q "%PROGRAMFILES%\AMD\CNext\CNext\models" > nul 2>&1
rmdir /s /q "%PROGRAMFILES%\AMD\CNext\CNext\QtCharts" > nul 2>&1
rmdir /s /q "%PROGRAMFILES%\AMD\CNext\CNext\QtMultimedia" > nul 2>&1
rmdir /s /q "%PROGRAMFILES%\AMD\CNext\CNext\QtQml" > nul 2>&1
rmdir /s /q "%PROGRAMFILES%\AMD\CNext\CNext\QtTest" > nul 2>&1
rmdir /s /q "%PROGRAMFILES%\AMD\CNext\CNext\QtWebEngine" > nul 2>&1
rmdir /s /q "%PROGRAMFILES%\AMD\CNext\CNext\QtWinExtras" > nul 2>&1
rmdir /s /q "%PROGRAMFILES%\AMD\CNext\CNext\quanminTV" > nul 2>&1
rmdir /s /q "%PROGRAMFILES%\AMD\CNext\CNext\resources" > nul 2>&1
rmdir /s /q "%PROGRAMFILES%\AMD\CNext\CNext\restream" > nul 2>&1
rmdir /s /q "%PROGRAMFILES%\AMD\CNext\CNext\sinaWeibo" > nul 2>&1
rmdir /s /q "%PROGRAMFILES%\AMD\CNext\CNext\streamable" > nul 2>&1
rmdir /s /q "%PROGRAMFILES%\AMD\CNext\CNext\translations" > nul 2>&1
rmdir /s /q "%PROGRAMFILES%\AMD\CNext\CNext\twitch" > nul 2>&1
rmdir /s /q "%PROGRAMFILES%\AMD\CNext\CNext\twitter" > nul 2>&1
rmdir /s /q "%PROGRAMFILES%\AMD\CNext\CNext\youku" > nul 2>&1
rmdir /s /q "%PROGRAMFILES%\AMD\CNext\CNext\youtube" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\RadeonML-DirectML.dll" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\swresample-3.dll" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\swscale-5.dll" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\WirelessVR-windesktop64.dll" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\xerces-c_2_6.dll" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\branding.bmp" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\brandingRSX.bmp" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\brandingWS_RSX.bmp" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\atiacmLocalisation.ini" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\radeonimagefilters64.dl_" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\radeonml-directml.dl_" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\ModularMonet.dtd" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\branding_pro_rsx.ico" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\branding_rsx.ico" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\CNVersions.json" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\workstation.rcc" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\amddvr.reg" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\EyefinityPro.reg" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\license.txt" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\ModularMonet.xml" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\StartCN.xml" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\StartCNBM.xml" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\StartDVR.xml" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\wProfile.xsd" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\7z.exe" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\amddmlfilters.exe" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\amdow.exe" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\AMDRSServ.exe" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\AMDRSSrcExt.exe" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\ATISetup.exe" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\AutoOverClockGFXCLK.exe" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\CompressionUtility.exe" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\DuplicateDesktop.exe" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\EyefinityPro.exe" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\gpuup.exe" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\installShell64.exe" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\MMLoadDrv.exe" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\MMLoadDrvPXDiscrete.exe" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\QtWebEngineProcess.exe" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\RSServCmd.exe" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\videotrim.exe" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\ZipUtility.exe" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\7z.dll" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\amf-component-ffmpeg64.dll" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\amf-component-ring-buffer64.dll" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\avcodec-58.dll" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\avdevice-58.dll" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\avfilter-7.dll" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\avformat-58.dll" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\avresample-4.dll" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\avutil-56.dll" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\D3Dcompiler_47.dll" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\dvrres_cs.dll" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\dvrres_da_DK.dll" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\dvrres_de.dll" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\dvrres_el_GR.dll" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\dvrres_en_US.dll" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\dvrres_es_ES.dll" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\dvrres_fi_FI.dll" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\dvrres_fr_FR.dll" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\dvrres_hu_HU.dll" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\dvrres_it_IT.dll" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\dvrres_ja.dll" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\dvrres_ko_KR.dll" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\dvrres_nl_NL.dll" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\dvrres_no.dll" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\dvrres_pl.dll" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\dvrres_pt_BR.dll" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\dvrres_ru_RU.dll" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\dvrres_sv_SE.dll" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\dvrres_th.dll" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\dvrres_tr_TR.dll" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\dvrres_zh_CN.dll" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\dvrres_zh_TW.dll" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\freeglut.dll" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\glew32.dll" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\MediaInfo.dll" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\Qt5Multimedia.dll" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\Qt5MultimediaQuick.dll" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\Qt5QuickTest.dll" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\Qt5SerialPort.dll" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\Qt5Test.dll" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\Qt5WebEngineWidgets.dll" > nul 2>&1
del /q "%PROGRAMFILES%\AMD\CNext\CNext\RadeonImageFilters64.dll" > nul 2>&1
set "file=C:\Vitality\Info\gpu"
if not exist "%file%" (
    echo Vitality > "%file%"
    set /a "ran_optimizations+=1"
)
cd C:\Vitality
set "formatted_optimizations=%ran_optimizations%"
if %formatted_optimizations% LSS 10 set "formatted_optimizations= %formatted_optimizations%"
echo set "ran_optimizations=%ran_optimizations%"> v.bat

goto skippinggpu


:skippinggpu



if "%RAM%"=="false" goto skippingram
echo                                                     Applying RAM Tweaks
REM Memory Managment Tweaks
for /f %%a in ('wmic cpu get L2CacheSize ^| findstr /r "[0-9][0-9]"') do (
    set /a l2c=%%a
    set /a sum1=%%a
) 
for /f %%a in ('wmic cpu get L3CacheSize ^| findstr /r "[0-9][0-9]"') do (
    set /a l3c=%%a
    set /a sum2=%%a
) 

REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "ClearPageFileAtShutdown" /t REG_DWORD /d "0" /f > nul 2>&1
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "DisablePagingExecutive" /t REG_DWORD /d "1" /f > nul 2>&1
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "DisablePageCombining" /t REG_DWORD /d "1" /f > nul 2>&1
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /t REG_DWORD /d "0" /f > nul 2>&1
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "NonPagedPoolQuota" /t REG_DWORD /d "0" /f > nul 2>&1
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "NonPagedPoolSize" /t REG_DWORD /d "0" /f > nul 2>&1
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "PagedPoolQuota" /t REG_DWORD /d "0" /f > nul 2>&1
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "PagedPoolSize" /t REG_DWORD /d "192" /f > nul 2>&1
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "SessionPoolSize" /t REG_DWORD /d "192" /f > nul 2>&1
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "SessionViewSize" /t REG_DWORD /d "192" /f > nul 2>&1
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "SystemPages" /t REG_DWORD /d "4294967295" /f > nul 2>&1
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "PhysicalAddressExtension" /t REG_DWORD /d "1" /f > nul 2>&1
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettings" /t REG_DWORD /d "1" /f > nul 2>&1
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverride" /t REG_DWORD /d "3" /f > nul 2>&1
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverrideMask" /t REG_DWORD /d "3" /f > nul 2>&1
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "IoPageLockLimit" /t REG_DWORD /d "16710656" /f > nul 2>&1
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "PoolUsageMaximum" /t REG_DWORD /d "96" /f > nul 2>&1
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "EnablePrefetcher" /t REG_DWORD /d "0" /f > nul 2>&1
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "EnableSuperfetch" /t REG_DWORD /d "0" /f > nul 2>&1
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnablePrefetcher" /t REG_DWORD /d "0" /f > nul 2>&1
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnableSuperfetch" /t REG_DWORD /d "0" /f > nul 2>&1
REG ADD "hklm\system\controlset001\control\session manager\memory management" /v "secondleveldatacache" /t reg_dword /d "%sum1%" /f > nul 2>&1
REG ADD "hklm\system\controlset001\control\session manager\memory management" /v "thirdleveldatacache" /t reg_dword /d "%sum2%" /f > nul 2>&1
REG ADD "hklm\system\controlset001\control\filesystem" /v "contigfileallocsize" /t reg_dword /d "1536" /f > nul 2>&1
REG ADD "hklm\system\controlset001\control\filesystem" /v "disabledeletenotification" /t reg_dword /d "0" /f > nul 2>&1
REG ADD "hklm\system\controlset001\control\filesystem" /v "dontverifyrandomdrivers" /t reg_dword /d "1" /f > nul 2>&1
REG ADD "hklm\system\controlset001\control\filesystem" /v "filenamecache" /t reg_dword /d "1024" /f > nul 2>&1
REG ADD "hklm\system\controlset001\control\filesystem" /v "longpathsenabled" /t reg_dword /d "0" /f > nul 2>&1
REG ADD "hklm\system\controlset001\control\filesystem" /v "ntfsallowextendedcharacter8dot3rename" /t reg_dword /d "0" /f > nul 2>&1
REG ADD "hklm\system\controlset001\control\filesystem" /v "ntfsbugcheckoncorrupt" /t reg_dword /d "0" /f > nul 2>&1
REG ADD "hklm\system\controlset001\control\filesystem" /v "ntfsdisable8dot3namecreation" /t reg_dword /d "1" /f > nul 2>&1
REG ADD "hklm\system\controlset001\control\filesystem" /v "ntfsdisablecompression" /t reg_dword /d "0" /f > nul 2>&1
REG ADD "hklm\system\controlset001\control\filesystem" /v "ntfsdisableencryption" /t reg_dword /d "1" /f > nul 2>&1
REG ADD "hklm\system\controlset001\control\filesystem" /v "ntfsencryptpagingfile" /t reg_dword /d "0" /f > nul 2>&1
REG ADD "hklm\system\controlset001\control\filesystem" /v "ntfsmemoryusage" /t reg_dword /d "0" /f > nul 2>&1
REG ADD "hklm\system\controlset001\control\filesystem" /v "ntfsmftzonereservation" /t reg_dword /d "4" /f > nul 2>&1
REG ADD "hklm\system\controlset001\control\filesystem" /v "pathcache" /t reg_dword /d "128" /f > nul 2>&1
REG ADD "hklm\system\controlset001\control\filesystem" /v "refsdisablelastaccessupdate" /t reg_dword /d "1" /f > nul 2>&1
REG ADD "hklm\system\controlset001\control\filesystem" /v "udfssoftwaredefectmanagement" /t reg_dword /d "0" /f > nul 2>&1
REG ADD "hklm\system\controlset001\control\filesystem" /v "win31filesystem" /t reg_dword /d "0" /f > nul 2>&1
REG ADD "hklm\system\currentcontrolset\control\filesystem" /v "contigfileallocsize" /t reg_dword /d "1536" /f > nul 2>&1
REG ADD "hklm\system\currentcontrolset\control\filesystem" /v "disabledeletenotification" /t reg_dword /d "0" /f > nul 2>&1
REG ADD "hklm\system\currentcontrolset\control\filesystem" /v "dontverifyrandomdrivers" /t reg_dword /d "1" /f > nul 2>&1
REG ADD "hklm\system\currentcontrolset\control\filesystem" /v "filenamecache" /t reg_dword /d "1024" /f > nul 2>&1
REG ADD "hklm\system\currentcontrolset\control\filesystem" /v "longpathsenabled" /t reg_dword /d "0" /f > nul 2>&1
REG ADD "hklm\system\currentcontrolset\control\filesystem" /v "ntfsallowextendedcharacter8dot3rename" /t reg_dword /d "0" /f > nul 2>&1
REG ADD "hklm\system\currentcontrolset\control\filesystem" /v "ntfsbugcheckoncorrupt" /t reg_dword /d "0" /f > nul 2>&1
REG ADD "hklm\system\currentcontrolset\control\filesystem" /v "ntfsdisable8dot3namecreation" /t reg_dword /d "1" /f > nul 2>&1
REG ADD "hklm\system\currentcontrolset\control\filesystem" /v "ntfsdisablecompression" /t reg_dword /d "0" /f > nul 2>&1
REG ADD "hklm\system\currentcontrolset\control\filesystem" /v "ntfsdisableencryption" /t reg_dword /d "1" /f > nul 2>&1
REG ADD "hklm\system\currentcontrolset\control\filesystem" /v "ntfsencryptpagingfile" /t reg_dword /d "0" /f > nul 2>&1
REG ADD "hklm\system\currentcontrolset\control\filesystem" /v "ntfsmemoryusage" /t reg_dword /d "0" /f > nul 2>&1
REG ADD "hklm\system\currentcontrolset\control\filesystem" /v "ntfsmftzonereservation" /t reg_dword /d "3" /f > nul 2>&1
REG ADD "hklm\system\currentcontrolset\control\filesystem" /v "pathcache" /t reg_dword /d "128" /f > nul 2>&1
REG ADD "hklm\system\currentcontrolset\control\filesystem" /v "refsdisablelastaccessupdate" /t reg_dword /d "1" /f > nul 2>&1
REG ADD "hklm\system\currentcontrolset\control\filesystem" /v "udfssoftwaredefectmanagement" /t reg_dword /d "0" /f > nul 2>&1
REG ADD "hklm\system\currentcontrolset\control\filesystem" /v "win31filesystem" /t reg_dword /d "0" /f > nul 2>&1

REM Disable FTH
reg add "HKLM\Software\Microsoft\FTH" /v "Enabled" /t Reg_DWORD /d "0" /f > nul 2>&1

REM Disable Background apps
reg add "HKLM\Software\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsRunInBackground" /t Reg_DWORD /d "2" /f > nul 2>&1

REM Free unused ram
reg add "HKLM\System\CurrentControlSet\Control\Session Manager" /v "HeapDeCommitFreeBlockThreshold" /t REG_DWORD /d "262144" /f > nul 2>&1

REM Auto restart Powershell on error
reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "AutoRestartShell" /t REG_DWORD /d "1" /f > nul 2>&1

REM Raise the limit of paged pool memory
fsutil behavior set memoryusage 2 > nul 2>&1

REM https://www.serverbrain.org/solutions-2003/the-mft-zone-can-be-optimized.html
fsutil behavior set mftzone 2 > nul 2>&1

REM Disable Last Access information on directories, performance/privacy
fsutil behavior set disablelastaccess 1 > nul 2>&1

REM Disable Virtual Memory Pagefile Encryption
fsutil behavior set encryptpagingfile 0 > nul 2>&1

REM Disables the creation of legacy 8.3 character-length file names on FAT- and NTFS-formatted volumes.
fsutil behavior set disable8dot3 1 > nul 2>&1

REM Disable NTFS compression
fsutil behavior set disablecompression 1 > nul 2>&1

REM Enable Trim
fsutil behavior set disabledeletenotify 0 > nul 2>&1


REM Set SVCSplitThreshold To User Memory Size
for /f "tokens=2 delims==" %%i in ('wmic os get TotalVisibleMemorySize /format:value') do set mem=%%i
set /a ram=%mem% + 1024000
Reg.exe add "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control" /v "SvcHostSplitThresholdInKB" /t REG_DWORD /d "%ram%" /f >nul 2>&1

set "file=C:\Vitality\Info\ram"
if not exist "%file%" (
    echo Vitality > "%file%"
    set /a "ran_optimizations+=1"
)
cd C:\Vitality
set "formatted_optimizations=%ran_optimizations%"
if %formatted_optimizations% LSS 10 set "formatted_optimizations= %formatted_optimizations%"
echo set "ran_optimizations=%ran_optimizations%"> v.bat

:skippingram

if "%DISK%"=="false" goto skippingdisk
echo                                                     Applying DISK Tweaks
REM Set storage devices as internal
reg add "HKLM\SYSTEM\CurrentControlSet\Control\StorageDevicePolicies" /v TreatAsInternalPort /t REG_MULTI_SZ /d "*" /f > nul 2>&1

REM Enable AHCI for StorAHCI service
reg add "HKLM\SYSTEM\CurrentControlSet\Services\storahci\Parameters" /v StorAHCI /t REG_DWORD /d 0x1 /f > nul 2>&1

REM Disable Paging of Executive Code
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v DisablePagingExecutive /t REG_DWORD /d 0x1 /f >nul 2>&1

REM Disable Last Access Time Update for NTFS
reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v NtfsDisableLastAccessUpdate /t REG_DWORD /d 0x1 /f >nul 2>&1

REM Disable Task Offload for TCP/IP
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v DisableTaskOffload /t REG_DWORD /d 0x1 /f >nul 2>&1

REM Disable Autorun for CD/DVD Drives
reg add "HKLM\SYSTEM\CurrentControlSet\Services\cdrom" /v Autorun /t REG_DWORD /d 0x0 /f >nul 2>&1

REM Set BITS (Background Intelligent Transfer Service) Start Mode
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BITS" /v Start /t REG_DWORD /d 0x3 /f >nul 2>&1

REM Enable LongPaths
reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v "LongPathsEnabled" /t REG_DWORD /d "0" /f

REM Disable Windows Services
sc config SysMain start=disabled >nul 2>&1
sc config FontCache start=disabled >nul 2>&1
sc config FontCache3.0.0.0 start=disabled >nul 2>&1

set "file=C:\Vitality\Info\disk"
if not exist "%file%" (
    echo Vitality > "%file%"
    set /a "ran_optimizations+=1"
)
cd C:\Vitality
set "formatted_optimizations=%ran_optimizations%"
if %formatted_optimizations% LSS 10 set "formatted_optimizations= %formatted_optimizations%"
echo set "ran_optimizations=%ran_optimizations%"> v.bat

:skippingdisk

if "%Windows%"=="false" goto skippingwindows
echo                                                   Applying Windows Tweaks
REM Background Settings
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v "GlobalUserDisabled" /t REG_DWORD /d 00000001  /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v "BackgroundAppGlobalToggle" /t REG_DWORD /d 00000000 /f >nul 2>&1

REM TCP/IP Priorities
reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider /v LocalPriority /t REG_DWORD /d 4 /f >nul 2>&1
reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider /v HostsPriority /t REG_DWORD /d 5 /f >nul 2>&1
reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider /v DnsPriority /t REG_DWORD /d 6 /f >nul 2>&1
reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider /v NetbtPriority /t REG_DWORD /d 7 /f >nul 2>&1

REM Performance Tweaks
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v AutoEndTasks /t REG_SZ /d 1 /f  >nul 2>&1
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v HungAppTimeout /t REG_SZ /d 1000 /f  >nul 2>&1
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v WaitToKillAppTimeout /t REG_SZ /d 2000 /f  >nul 2>&1
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v LowLevelHooksTimeout /t REG_SZ /d 1000 /f  >nul 2>&1
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v MenuShowDelay /t REG_SZ /d 0 /f >nul 2>&1

REM Maintenance and UI Settings
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v WaitToKillServiceTimeout /t REG_SZ /d 2000 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MinAnimate" /t REG_SZ /d 0 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v MaintenanceDisabled /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v EnableBalloonTips /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "DpiMapIommuContiguous" /t REG_DWORD /d "1" /f  >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Internet Explorer\Main" /v "DEPOff" /t REG_DWORD /d "1" /f  >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v "foregroundLockTimeout" /t REG_SZ /d 150000 /f >nul 2>&1
reg add "HKCU\Control Panel\International\User Profile" /v "HttpAcceptLanguageOptOut" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v "MouseHoverTime" /t REG_SZ /d 100 /f  >nul 2>&1

REM Explorer Settings
reg add "HKEY_CURRENT_USER\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags\AllFolders\Shell" /v "WFlags" /t REG_DWORD /d 0 /f  >nul 2>&1
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackProgs" /t REG_DWORD /d 0 /f  >nul 2>&1
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "NavPaneShowAllFolders" /t REG_DWORD /d 1 /f  >nul 2>&1
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ExtendedUIHoverTime" /t REG_DWORD /d 0 /f  >nul 2>&1
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ListviewShadow" /t REG_DWORD /d 0 /f  >nul 2>&1
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ListviewAlphaSelect" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarSizeMove" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "DisablePreviewDesktop" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LastActiveClick" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "StartMenuAdminTools" /t REG_SZ /d "YES" /f >nul 2>&1

REM Search and Synchronization Settings
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "AnyAboveLockAppsActive" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search\Flighting" /v "RotateFlight" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\BrowserSettings" /v "Enabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v "StoragePoliciesNotified" /t REG_DWORD /d 0 /f >nul 2>&1

REM System behavior and sound settings
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "DisableStartupSound" /t REG_DWORD /d 1 /f >nul 2>&1

REM Tracing Settings
reg add "HKEY_LOCAL_MACHINE\Software\WOW6432Node\Microsoft\Tracing\SystemSettings_RASAPI32" /v "EnableConsoleTracing" /t REG_DWORD /d 00000000 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\Software\WOW6432Node\Microsoft\Tracing\SystemSettings_RASMANCS" /v "EnableConsoleTracing" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\Software\WOW6432Node\Microsoft\Tracing\SystemSettings_RASMANCS" /v "EnableAutoFileTracing" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\Software\WOW6432Node\Microsoft\Tracing\SystemSettings_RASMANCS" /v "EnableFileTracing" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Console" /v "VirtualTerminalLevel" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Tracing\RASAPI32" /v "EnableConsoleTracing" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Tracing\RASMANCS" /v "EnableConsoleTracing" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Tracing\RASMANCS" /v "EnableAutoFileTracing" /t REG_DWORD /d 0 /f >nul 2>&1

REM Multimedia and Mouse Settings
REG ADD "HKEY_CURRENT_USER\Control Panel\Mouse" /v "MouseSensitivity" /t REG_SZ /d "10" /f >nul 2>&1
REG ADD "HKEY_CURRENT_USER\Control Panel\Mouse" /v "SmoothMouseXCurve" /t REG_BINARY /d "0000000000C0CC0C00000000809919000000004066260000000033330000000000" /f >nul 2>&1
REG ADD "HKEY_CURRENT_USER\Control Panel\Mouse" /v "SmoothMouseYCurve" /t REG_BINARY /d "000000000000380000000000700000000000A80000000000E000000000000000" /f >nul 2>&1
REG ADD "HKEY_USERS\.DEFAULT\Control Panel\Mouse" /v "MouseSpeed" /t REG_SZ /d "0" /f >nul 2>&1
REG ADD "HKEY_USERS\.DEFAULT\Control Panel\Mouse" /v "MouseThreshold1" /t REG_SZ /d "0" /f >nul 2>&1
REG ADD "HKEY_USERS\.DEFAULT\Control Panel\Mouse" /v "MouseThreshold2" /t REG_SZ /d "0" /f >nul 2>&1

REM Keyboard Response Settings
reg add "HKEY_CURRENT_USER\Control Panel\Accessibility\Keyboard Response" /v "AutoRepeatDelay" /t REG_SZ /d "200" /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Control Panel\Accessibility\Keyboard Response" /v "AutoRepeatRate" /t REG_SZ /d "15" /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Control Panel\Accessibility\Keyboard Response" /v "BounceTime" /t REG_SZ /d "0" /f >nul 2>&1


REM Keyboard Settings
reg add "HKCU\Control Panel\Keyboard" /v "KeyboardSpeed" /t REG_SZ /d "31" /f >nul 2>&1
reg add "HKCU\Control Panel\Keyboard" /v "KeyboardDelay" /t REG_SZ /d "0" /f  >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\services\kbdclass\Parameters" /v "KeyboardDataQueueSize" /t REG_DWORD /d "50" /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Control Panel\Accessibility\Keyboard Response" /v "DelayBeforeAcceptance" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Control Panel\Accessibility\Keyboard Response" /v "Flags" /t REG_SZ /d "59" /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Control Panel\Accessibility\Keyboard Response" /v "Last BounceKey Setting" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Control Panel\Accessibility\Keyboard Response" /v "Last Valid Repeat" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Control Panel\Accessibility\Keyboard Response" /v "Last Valid Wait" /t REG_DWORD /d 1000 /f >nul 2>&1

REM Security And Compatibility Settings
reg add "HKLM\SOFTWARE\Policies\Microsoft\FVE" /v "DisableExternalDMAUnderLock" /t REG_DWORD /d "0"  /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v "EnableVirtualizationBasedSecurity" /t REG_DWORD /d "0"  /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v "HVCIMATRequired" /t REG_DWORD /d "0"  /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "EnableCfg" /t REG_DWORD /d "0"  /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "ProtectionMode" /t REG_DWORD /d "0"  /f >nul 2>&1

REM Priority And Performance Settings
reg add "HKLM\Software\Policies\Microsoft\Biometrics" /v "Enabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableInventory" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Control\Session Manager" /v "ProtectionMode" /t REG_DWORD /d "0" /f >nul 2>&1

REM Notification and compatibility settings
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\csrss.exe" /v "Priority" /t REG_DWORD /d 00000009 /f >nul 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 00000016 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "DisableWriteCombining" /t Reg_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications" /v "NoTileApplicationNotification" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSyncProviderNotifications" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "TaskbarNoNotification" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" /v "ToastEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\DataCollection" /v "DoNotShowFeedbackNotifications" /t REG_DWORD /d 00000001 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableVidMemVBs" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "MMX Fast Path" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "FlipNoVsync" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D\Drivers" /v "SoftwareOnly" /t REG_DWORD /d "0" /f >nul 2>&1
REG ADD "HKLM\SOFTWARE\Microsoft\Windows Defender\Spynet" /v " SpyNetReporting" /t REG_DWORD /d 0 /f >nul 2>&1
REG ADD "HKLM\SOFTWARE\Microsoft\Windows Defender\Spynet" /v " SubmitSamplesConsent" /t REG_DWORD /d 0 /f >nul 2>&1
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v "SpynetReporting" /t REG_DWORD /d 0 /f >nul 2>&1
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v "SubmitSamplesConsent" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 0 /f >nul 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WinDefend" /v "Start" /t REG_DWORD /d 00000004 /f >nul 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SecurityHealthService" /v "Start" /t REG_DWORD /d 00000004 /f >nul 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WdNisSvc" /v "Start" /t REG_DWORD /d 00000004 /f >nul 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Sense" /v "Start" /t REG_DWORD /d 00000004 /f >nul 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\wscsvc" /v "Start" /t REG_DWORD /d 00000004 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Notifications" /v "DisableNotifications" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\CurrentVersion\PushNotifications" /v "NoToastApplicationNotification" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\CurrentVersion\PushNotifications" /v "NoToastApplicationNotificationOnLockScreen" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "SleepStudyDisabled" /t REG_DWORD /d "1" /f  >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "MoveImages" /t REG_DWORD /d "0" /f >nul 2>&1

REM Memory and File System Optimization
fsutil behavior set memoryusage 2  >nul 2>&1
fsutil behavior set mftzone 4  >nul 2>&1
fsutil behavior set disablelastaccess 1  >nul 2>&1

REM Disable NTFS Compression
REG ADD "HKEY_LOCAL_MACHINE\System\ControlSet001\Control\FileSystem" /v "NtfsDisableCompression" /t REG_DWORD /d "1" /f >nul 2>&1

REM Adjust NTFS MFT Zone Reservation
REG ADD "HKEY_LOCAL_MACHINE\System\ControlSet001\Control\FileSystem" /v "NtfsMftZoneReservation" /t REG_DWORD /d "2" /f  >nul 2>&1

REM Set I/O priority for better performance.
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\I/O System" /v "PassiveIntRealTimeWorkerPriority" /t REG_DWORD /d "18" /f  >nul 2>&1

REM Adjust process priorities for improved performance.
reg add "HKLM\SYSTEM\CurrentControlSet\Control\KernelVelocity" /v "DisableFGBoostDecay" /t REG_DWORD /d "1" /f  >nul 2>&1

REM Set CPU priority classes for specific processes.
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\lsass.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f  >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SearchIndexer.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f  >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\TrustedInstaller.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f  >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\audiodg.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "2" /f  >nul 2>&1
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\dwm.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "4" /f  >nul 2>&1
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\lsass.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f  >nul 2>&1
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\svchost.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f  >nul 2>&1
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\wuauclt.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d "0" /f  >nul 2>&1

REM Configure registry settings to optimize system performance.
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\DAL2_DATA__2_0\DisplayPath_4\EDID_D109_78E9\Option" /v "ProtectionControl" /t REG_BINARY /d "0100000001000000" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RMHdcpKeyGlobZero" /t REG_DWORD /d "1" /f  >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "TCCSupported" /t REG_DWORD /d "0" /f  >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "EnableTiledDisplay" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "DisableWriteCombining" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DisableSAMUPowerGating" /t REG_DWORD /d "1" /f  >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DisableUVDPowerGatingDynamic" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DisableVCEPowerGating" /t REG_DWORD /d "1" /f  >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DisablePowerGating" /t REG_DWORD /d "1" /f  >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DisableDrmdmaPowerGating" /t REG_DWORD /d "1" /f  >nul 2>&1


REM GPU and memory management settings 
Reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnablePrefetcher" /t REG_DWORD /d "0" /f  >nul 2>&1
Reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnableSuperfetch" /t REG_DWORD /d "0" /f  >nul 2>&1
Reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnableBoottrace" /t REG_DWORD /d "0" /f  >nul 2>&1
Reg add "HKLM\System\CurrentControlSet\Control\FileSystem" /v "DontVerifyRandomDrivers" /t REG_DWORD /d "1" /f >nul 2>&1
Reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "DriverSigningPolicy" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Control\Session Manager\Memory Management" /v "DisablePageCombining" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "DisableExceptionChainValidation" /t REG_DWORD /d "1" /f  >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "KernelSEHOPEnabled" /t REG_DWORD /d "0" /f  >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Control\Session Manager\kernel" /v "DisableTsx" /t REG_DWORD /d "1" /f  >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v "Enabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Control\DeviceGuard" /v "EnableVirtualizationBasedSecurity" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Settings" /v "DownloadMode" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization" /v "SystemSettingsDownloadMode" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\DeliveryOptimization" /v "DODownloadMode" /t REG_DWORD /d 00000000 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DODownloadMode" /t REG_DWORD /d 00000000 /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows\Psched" /v "NonBestEffortLimit" /t REG_DWORD /d "0" /f >nul 2>&1
reg add HKEY_USERS\.DEFAULT\SOFTWARE\Policies\Microsoft\Windows\Explorer /v DisableNotificationCenter /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "NoNetCrawling" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoThumbnailCache" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "DisableThumbnailCache" /t REG_DWORD /d 1 /f >nul 2>&1

Rem Disable Thumbnails For Network Folders
reg add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer /v DisableThumbnailsOnNetworkFolders /t REG_DWORD /d 1 /f >nul 2>&1

REM Disable File Delete Confirmation
reg add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer /v ConfirmFileDelete /t REG_DWORD /d 0 /f >nul 2>&1

REM Ignore Link Information During link Resolution
reg add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer /v LinkResolveIgnoreLinkInfo /t REG_DWORD /d 1 /f >nul 2>&1

REM Disable Search Result Resolving
reg add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer /v NoResolveSearch /t REG_DWORD /d 1 /f >nul 2>&1

REM Disable Tracking Of Resolved Shell Shortcuts
reg add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer /v NoResolveTrack /t REG_DWORD /d 1 /f >nul 2>&1

REM Disable Autorun For Specific Drive Types
reg add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer /v NoDriveTypeAutoRun /t REG_DWORD /d 221 /f >nul 2>&1

REM Disable Low Disk Space Checks
reg add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer /v NoLowDiskSpaceChecks /t REG_DWORD /d 1 /f >nul 2>&1

REM Disable Minimizing Open Windows Using Shortcuts
reg add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "NoWindowMinimizingShortcuts" /t REG_DWORD /d 00000001 /f >nul 2>&1

REM Set Pending Work Status For .NET Framework Service
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\.NETFramework\v2.0.50727\NGenService\Roots" /v "WorkPending" /t REG_DWORD /d 0 /f >nul 2>&1

REM Allow Changes To The Start Menu
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoChangeStartMenu" /t REG_DWORD /d 0 /f >nul 2>&1

REM Disable online tips
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "AllowOnlineTips" /t REG_DWORD /d 0 /f >nul 2>&1

REM Enable Control Panel access
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoControlPanel" /t REG_DWORD /d 0 /f >nul 2>&1

REM Disable recent documents in the Network Locations folder
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoRecentDocsNetHood" /t REG_DWORD /d 1 /f >nul 2>&1

REM Disable User Mode Instrumentation
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoInstrumentation" /t REG_DWORD /d 1 /f >nul 2>&1

REM Disable Secure UIA Paths
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableSecureUIAPaths" /t REG_DWORD /d 0 /f >nul 2>&1

REM Disable Consent Prompt For Admin Users
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d 0 /f >nul 2>&1

REM Disable Synchronous Startup Scripts
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "RunStartupScriptSync" /t REG_DWORD /d 0 /f >nul 2>&1

REM Disable Automatic Restart After Sign-on
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "DisableAutomaticRestartSignOn" /t REG_DWORD /d 1 /f >nul 2>&1

REM Disable Sensor Permission State
reg add "HKEY_LOCAL_MACHINE\Software\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v "SensorPermissionState" /t REG_DWORD /d 0 /f >nul 2>&1

REM Disable DirectInput Mapper For JAVAW.EXE
reg add HKEY_CURRENT_USER\SOFTWARE\Microsoft\DirectInput\JAVAW.EXE71FF49A70000A510 /v UsesMapper /t REG_BINARY /d 00000000 /f >nul 2>&1

REM Restrict Implicit Text Collection
reg add HKEY_CURRENT_USER\SOFTWARE\Microsoft\InputPersonalization /v RestrictImplicitTextCollection /t REG_DWORD /d 00000001 /f >nul 2>&1

REM Restrict Implicit Ink Collection
reg add HKEY_CURRENT_USER\SOFTWARE\Microsoft\InputPersonalization /v RestrictImplicitInkCollection /t REG_DWORD /d 00000001 /f >nul 2>&1

REM Set Notepad Word Wrap
reg add HKEY_CURRENT_USER\SOFTWARE\Microsoft\Notepad /v fWrap /t REG_DWORD /d 00000001 /f >nul 2>&1

REM Restrict Implicit Ink Collection In Personalization Settings
reg add HKEY_CURRENT_USER\SOFTWARE\Microsoft\Personalization\Settings /v RestrictImplicitInkCollection /t REG_DWORD /d 00000001 /f >nul 2>&1

REM Set Aggregate Cache Generation For Poom
reg add HKEY_CURRENT_USER\SOFTWARE\Microsoft\Poom /v AggregateCacheGeneration /t REG_DWORD /d 00000016 /f >nul 2>&1

REM Set Number Of SIUF In A Period For SIUF Rules
reg add HKEY_CURRENT_USER\SOFTWARE\Microsoft\Siuf\Rules /v NumberOfSIUFInPeriod /t REG_DWORD /d 00000000 /f >nul 2>&1

REM Disable sensor permission
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Permissions\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v SensorPermissionState /t REG_DWORD /d 0 /f >nul 2>&1

REM Disable web content evaluation in AppHost
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /t REG_DWORD /d 0 /f >nul 2>&1

REM Disable PNG file type association toast
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" /v "pngfile_.png" /t REG_DWORD /d 0 /f >nul 2>&1

REM Disable Notepad and PowerShell file association toast
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" /v "Applications\notepad.exe_.ps1" /t REG_DWORD /d 0 /f >nul 2>&1

REM Disable RomeSdkChannelUserAuthzPolicy in CDP
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\CDP" /v "RomeSdkChannelUserAuthzPolicy" /t REG_DWORD /d 0 /f >nul 2>&1

REM Disable CdpSessionUserAuthzPolicy in CDP
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\CDP" /v "CdpSessionUserAuthzPolicy" /t REG_DWORD /d 0 /f >nul 2>&1

REM Disable soft landing in ContentDeliveryManager
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SoftLandingEnabled" /t REG_DWORD /d 0 /f >nul 2>&1

REM Disable valid content notification
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\88000105" /v "HasValidContent" /t REG_DWORD /d 0 /f >nul 2>&1

REM Disable frequent items in Explorer
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowFrequent" /t REG_DWORD /d 0 /f >nul 2>&1

REM Disable hover select on desktops
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "HoverSelectDesktops" /t REG_DWORD /d 0 /f >nul 2>&1

REM Run separate processes for folder windows
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v SeparateProcess /t REG_DWORD /d 1 /f >nul 2>&1

REM Disable PenWorkspace app suggestions
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\PenWorkspace" /v "PenWorkspaceAppSuggestionsEnabled" /t REG_DWORD /d 0 /f >nul 2>&1

REM Enable preview handler for specific CLSID
reg add HKEY_LOCAL_MACHINE\Software\Classes\WOW6432Node\CLSID\{3A84F9C2-6164-485C-A7D9-4B27F8AC009E} /v EnablePreviewHandler /t REG_DWORD /d 1 /f >nul 2>&1

REM Disable EnterpriseID in Microsoft Edge
reg add HKEY_LOCAL_MACHINE\Software\Microsoft\SecurityManager\CapAuthz\ApplicationsEx\Microsoft.MicrosoftEdge.Stable_110.0.1587.69_neutral__8wekyb3d8bbwe /v EnterpriseID /t REG_DWORD /d 0 /f >nul 2>&1

REM Disable ApplicationFlags in Microsoft Edge
reg add HKEY_LOCAL_MACHINE\Software\Microsoft\SecurityManager\CapAuthz\ApplicationsEx\Microsoft.MicrosoftEdge.Stable_110.0.1587.69_neutral__8wekyb3d8bbwe /v ApplicationFlags /t REG_DWORD /d 0 /f >nul 2>&1

REM Disable Windows Search notifications
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows Search\CrawlScopeManager\Windows\SystemIndex\SearchRoots\0" /v "ProvidesNotifications" /t REG_DWORD /d 0 /f >nul 2>&1

REM Enable Display CPL (Control Panel)
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "NoDispCPL" /t REG_DWORD /d 0 /f >nul 2>&1

REM Disable Ctrl+Alt+Delete screen
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "DisableCAD" /t REG_DWORD /d 1 /f >nul 2>&1

REM Disable startup sound
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "DisableStartupSound" /t REG_DWORD /d 1 /f >nul 2>&1

REM Disable user information on logon screen
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "DisplayLastLogonInfo" /t REG_DWORD /d 0 /f >nul 2>&1

REM Allow full admin token
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "FilterAdministratorToken" /t REG_DWORD /d 0 /f >nul 2>&1

REM Disable first logon animation
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableFirstLogonAnimation" /t REG_DWORD /d 0 /f >nul 2>&1

REM Disable WaaS assessment cache
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\WaaSAssessment\Cache" /v "UpToDateDays" /t REG_DWORD /d 0 /f >nul 2>&1

REM Disable NVIDIA RID 66610
reg add "HKEY_LOCAL_MACHINE\Software\NVIDIA Corporation\Global\FTS" /v "EnableRID66610" /t REG_DWORD /d 0 /f >nul 2>&1

REM Opt out of NVIDIA Control Panel updates
reg add "HKEY_LOCAL_MACHINE\Software\NVIDIA Corporation\NvControlPanel2\Client" /v "OptInOrOutPreference" /t REG_DWORD /d 0 /f >nul 2>&1

REM Disable ticket generation in Software Protection Platform
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows NT\CurrentVersion\Software Protection Platform" /v "NoGenTicket" /t REG_DWORD /d 1 /f >nul 2>&1

REM Disable Application Impact Telemetry
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\AppCompat" /v "AITEnable" /t REG_DWORD /d 0 /f >nul 2>&1

REM Hide feedback notifications
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\DataCollection" /v "DoNotShowFeedbackNotifications" /t REG_DWORD /d 1 /f >nul 2>&1

REM Disable HomeGroup
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\HomeGroup" /v "DisableHomeGroup" /t REG_DWORD /d 1 /f >nul 2>&1

REM Disable location scripting
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocationScripting" /t REG_DWORD /d 00000001 /f >nul 2>&1

REM Disable Windows Location Provider
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableWindowsLocationProvider" /t REG_DWORD /d 00000001 /f >nul 2>&1

REM Disable web search in Windows Search
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /t REG_DWORD /d 00000000 /f >nul 2>&1

REM Disable cloud search in Windows Search
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\Windows Search" /v "AllowCloudSearch" /t REG_DWORD /d 00000000 /f >nul 2>&1

REM Mark .NET Framework service work as complete
reg add "HKEY_LOCAL_MACHINE\Software\WOW6432Node\Microsoft\.NETFramework\v2.0.50727\NGenService\Roots" /v "WorkPending" /t REG_DWORD /d 00000000 /f >nul 2>&1

REM Set install time remaining to 0 for Edge updates
reg add "HKEY_LOCAL_MACHINE\Software\WOW6432Node\Microsoft\EdgeUpdate\ClientState\{F3017226-FE2A-4295-8BDF-00C3A9A7E4C5}\CurrentState" /v "InstallTimeRemainingMs" /t REG_DWORD /d 00000000 /f >nul 2>&1

REM Prevent network traffic pre-user sign-in in OneDrive
reg add "HKEY_LOCAL_MACHINE\Software\WOW6432Node\Microsoft\OneDrive" /v "PreventNetworkTrafficPreUserSignIn" /t REG_DWORD /d 00000001 /f >nul 2>&1

REM Disable accepted privacy policy
reg add "HKEY_LOCAL_MACHINE\Software\WOW6432Node\Microsoft\Personalization\Settings" /v "AcceptedPrivacyPolicy" /t REG_DWORD /d 00000000 /f >nul 2>&1

REM Disable file tracing for SystemSettings_RASAPI32
reg add "HKEY_LOCAL_MACHINE\Software\WOW6432Node\Microsoft\Tracing\SystemSettings_RASAPI32" /v "EnableFileTracing" /t REG_DWORD /d 00000000 /f >nul 2>&1

REM Disable file tracing for SystemSettings_RASMANCS
reg add "HKEY_LOCAL_MACHINE\Software\WOW6432Node\Microsoft\Tracing\SystemSettings_RASMANCS" /v "EnableFileTracing" /t REG_DWORD /d 00000000 /f >nul 2>&1

REM Disable automatic file tracing for SystemSettings_RASMANCS
reg add "HKEY_LOCAL_MACHINE\Software\WOW6432Node\Microsoft\Tracing\SystemSettings_RASMANCS" /v "EnableAutoFileTracing" /t REG_DWORD /d 00000000 /f >nul 2>&1

REM Disable console tracing for SystemSettings_RASMANCS
reg add "HKEY_LOCAL_MACHINE\Software\WOW6432Node\Microsoft\Tracing\SystemSettings_RASMANCS" /v "EnableConsoleTracing" /t REG_DWORD /d 00000000 /f >nul 2>&1

REM Disable SystemPaneSuggestionsEnabled in ContentDeliveryManager
reg add "HKEY_LOCAL_MACHINE\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SystemPaneSuggestionsEnabled /t REG_DWORD /d 00000000 /f >nul 2>&1

REM Prevent device metadata download from network
reg add "HKEY_LOCAL_MACHINE\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Device Metadata" /v PreventDeviceMetadataFromNetwork /t REG_DWORD /d 00000001 /f >nul 2>&1

REM Disable driver searching
reg add "HKEY_LOCAL_MACHINE\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\DriverSearching" /v SearchOrderConfig /t REG_DWORD /d 00000000 /f >nul 2>&1

REM Disable BluetoothPolicy in SmartGlass
reg add "HKEY_LOCAL_MACHINE\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\SmartGlass" /v BluetoothPolicy /t REG_DWORD /d 00000000 /f >nul 2>&1

REM Disable UserAuthPolicy in SmartGlass
reg add "HKEY_LOCAL_MACHINE\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\SmartGlass" /v UserAuthPolicy /t REG_DWORD /d 00000000 /f >nul 2>&1

REM Set defer feature updates period to 22 days
reg add "HKEY_LOCAL_MACHINE\Software\WOW6432Node\Microsoft\WindowsUpdate\UX\Settings" /v "DeferFeatureUpdatesPeriodInDays" /t REG_DWORD /d 0000016 /f >nul 2>&1

REM Set branch readiness level to 32 (Current Branch for Business)
reg add "HKEY_LOCAL_MACHINE\Software\WOW6432Node\Microsoft\WindowsUpdate\UX\Settings" /v "BranchReadinessLevel" /t REG_DWORD /d 00000020 /f >nul 2>&1

REM Set system start options
reg add "HKEY_LOCAL_MACHINE\System\ControlSet001\Control" /v "SystemStartOptions" /t REG_SZ /d "CONFIGACCESSPOLICY=DEFAULT NOEXECUTE=OPTOUT X2APICPOLICY=ENABLE TSCSYNCPOLICY=ENHANCED VSMLAUNCHTYPE=OFF NOGUIBOOT BOOTLOGO DISABLEDYNAMICTICK NOVGA" /f  >nul 2>&1

REM Set AutoChkTimeout to 5 seconds
reg add "HKEY_LOCAL_MACHINE\System\ControlSet001\Control\Session Manager" /v "AutoChkTimeout" /t REG_DWORD /d 00000005 /f >nul 2>&1


REM Set AdditionalCriticalWorkerThreads to 2
reg add "HKEY_LOCAL_MACHINE\System\ControlSet001\Control\Session Manager\Executive" /v "AdditionalCriticalWorkerThreads" /t REG_DWORD /d 00000002 /f >nul 2>&1

REM Set AdditionalDelayedWorkerThreads to 1
reg add "HKEY_LOCAL_MACHINE\System\ControlSet001\Control\Session Manager\Executive" /v "AdditionalDelayedWorkerThreads" /t REG_DWORD /d 00000001 /f >nul 2>&1

REM Set SessionViewSize to 96MB
reg add "HKEY_LOCAL_MACHINE\System\ControlSet001\Control\Session Manager\Memory Management" /v "SessionViewSize" /t REG_DWORD /d 00000060 /f >nul 2>&1

REM Disable paging of the executive (kernel mode code)
reg add "HKEY_LOCAL_MACHINE\System\ControlSet001\Control\Session Manager\Memory Management" /v "DisablePagingExecutive" /t REG_DWORD /d 00000001 /f >nul 2>&1

REM Set SessionPoolSize to 48MB
reg add "HKEY_LOCAL_MACHINE\System\ControlSet001\Control\Session Manager\Memory Management" /v "SessionPoolSize" /t REG_DWORD /d 00000030 /f >nul 2>&1

REM Disable Superfetch Tracing
reg add "HKEY_LOCAL_MACHINE\System\ControlSet001\Control\Session Manager\Memory Management\PrefetchParameters" /v "SfTracingState" /t REG_DWORD /d 00000000 /f >nul 2>&1

REM Disable Software Restriction Policies (SRP)
reg add "HKEY_LOCAL_MACHINE\System\ControlSet001\Control\Srp\Gp" /v "RuleCount" /t REG_DWORD /d 00000000 /f >nul 2>&1

REM Disable Diagtrack-Listener in WMI
reg add "HKEY_LOCAL_MACHINE\System\ControlSet001\Control\WMI\Autologger\Diagtrack-Listener" /ve /f >nul 2>&1

REM Set DevicePolicy to 4 for specific PCI device
reg add "HKEY_LOCAL_MACHINE\System\ControlSet001\Enum\PCI\VEN_10DE&DEV_1F07&SUBSYS_37C61458&REV_A1\4&2db3ecda&0&0008\Device Parameters\Interrupt Management\Affinity Policy" /v "DevicePolicy" /t REG_DWORD /d 00000004 /f >nul 2>&1

REM Enable Message Signaled Interrupt (MSI) for specific PCI device
reg add "HKEY_LOCAL_MACHINE\System\ControlSet001\Enum\PCI\VEN_10DE&DEV_1F07&SUBSYS_37C61458&REV_A1\4&2db3ecda&0&0008\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties" /v "MSISupported" /t REG_DWORD /d 00000001 /f >nul 2>&1

REM Modify AFD service parameters
reg add "HKEY_LOCAL_MACHINE\System\ControlSet001\Services\AFD\Parameters" /v "DynamicSendBufferDisable" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\System\ControlSet001\Services\AFD\Parameters" /v "DisableRawSecurity" /t REG_DWORD /d 1 /f >nul 2>&1

REM Disable Delayed AutoStart for CDPSvc
reg add "HKEY_LOCAL_MACHINE\System\ControlSet001\Services\CDPSvc" /v "DelayedAutoStart" /t REG_DWORD /d 0 /f >nul 2>&1

REM Disable Display Enhancement Service settings
reg add "HKEY_LOCAL_MACHINE\System\ControlSet001\Services\DisplayEnhancementService\State\ACR074D86119506_34_07E4_1F" /v "IsAutobrightnessOn" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\System\ControlSet001\Services\DisplayEnhancementService\State\ACR074D86119506_34_07E4_1F" /v "IsRealColorOn" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\System\ControlSet001\Services\DisplayEnhancementService\State\ACR074D86119506_34_07E4_1F" /v "AutobrightnessBias" /t REG_DWORD /d 0 /f >nul 2>&1

REM Disable DNS Cache settings
reg add "HKEY_LOCAL_MACHINE\System\ControlSet001\Services\Dnscache\Parameters" /v "NegativeCacheTime" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\System\ControlSet001\Services\Dnscache\Parameters" /v "NegativeSOACacheTime" /t REG_DWORD /d 0 /f >nul 2>&1

REM Disable Event Log backup and LAN Manager settings
reg add "HKEY_LOCAL_MACHINE\System\ControlSet001\Services\EventLog\Application" /v "AutoBackupLogFiles" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\System\ControlSet001\Services\LanmanServer\DefaultSecurity" /v "PreviousAnonymousRestriction" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\System\ControlSet001\Services\LanmanServer\Parameters" /v "IRPStackSize" /t REG_DWORD /d 50 /f >nul 2>&1

REM Modify LanmanWorkstation and STR service settings
reg add "HKEY_LOCAL_MACHINE\System\ControlSet001\Services\LanmanWorkstation\Parameters" /v "MaxCollectionCount" /t REG_DWORD /d 32 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\System\ControlSet001\Services\STR" /v "DelayedAutostart" /t REG_DWORD /d 0 /f >nul 2>&1

REM Modify TCP/IP parameters
reg add "HKEY_LOCAL_MACHINE\System\ControlSet001\Services\Tcpip\Parameters" /v "TcpTimedWaitDelay" /t REG_DWORD /d 20 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\System\ControlSet001\Services\Tcpip\Parameters\Interfaces\{dbcbecf5-1e94-453d-a74f-89ffb201cec0}" /v "UseZeroBroadcast" /t REG_DWORD /d 0 /f >nul 2>&1

REM Modify W32Time SecureTimeLimits
reg add "HKEY_LOCAL_MACHINE\System\ControlSet001\Services\W32Time\SecureTimeLimits" /v "SecureTimeHigh" /t REG_BINARY /d D7DCFED5F754D901 /f >nul 2>&1

REM Modify WpnUserService settings
reg add "HKEY_LOCAL_MACHINE\System\ControlSet001\Services\WpnUserService_3a7e0" /v "ErrorControl" /t REG_DWORD /d 0 /f >nul 2>&1

REM Disable NIC buffer holding
reg add "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\AFD\Parameters" /v "DoNotHoldNicBuffers" /t REG_DWORD /d 1 /f >nul 2>&1

REM Disable Direct3D telemetry and input personalization
reg add "HKEY_USERS\.DEFAULT\Software\Microsoft\Direct3D" /v "LastTelemetryChangeStamp" /t REG_DWORD /d 4294018288 /f >nul 2>&1
reg add "HKEY_USERS\.DEFAULT\Software\Microsoft\InputPersonalization\TrainedDataStore" /v "HarvestContacts" /t REG_DWORD /d 00000000 /f >nul 2>&1

REM Modify default user settings
reg add "HKEY_USERS\.DEFAULT\Software\Microsoft\Personalization\Settings" /v "AcceptedPrivacyPolicy" /t REG_DWORD /d 00000000 /f >nul 2>&1
reg add "HKEY_USERS\.DEFAULT\Software\Microsoft\Siuf\Rules" /v "PeriodInNanoSeconds" /t REG_DWORD /d 00000000 /f >nul 2>&1
reg add "HKEY_USERS\.DEFAULT\Software\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t REG_DWORD /d 00000000 /f >nul 2>&1
reg add "HKEY_USERS\.DEFAULT\Software\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy" /v "HasAccepted" /t REG_DWORD /d 00000000 /f >nul 2>&1
reg add "HKEY_USERS\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications\Microsoft.3DBuilder_8wekyb3d8bbwe" /v "IgnoreBatterySaver" /t REG_DWORD /d 00000000 /f >nul 2>&1
reg add "HKEY_USERS\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Census" /v "ReturnCode" /t REG_DWORD /d 00000000 /f >nul 2>&1
reg add "HKEY_USERS\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d 00000000 /f >nul 2>&1
reg add "HKEY_USERS\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d 00000000 /f >nul 2>&1
reg add "HKEY_USERS\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SoftLandingEnabled" /t REG_DWORD /d 00000000 /f >nul 2>&1
reg add "HKEY_USERS\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEverEnabled" /t REG_DWORD /d 00000000 /f >nul 2>&1
reg add "HKEY_USERS\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "OemPreInstalledAppsEnabled" /t REG_DWORD /d 00000000 /f >nul 2>&1
reg add "HKEY_USERS\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "ContentDeliveryAllowed" /t REG_DWORD /d 00000000 /f >nul 2>&1

REM Modify current user Content Delivery Manager settings
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenOverlayEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSyncProviderNotifications" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-310093Enabled" /t REG_DWORD /d "0" /f >nul 2>&1

REM Modify Windows Error Reporting settings
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "AutoApproveOSDumps" /t REG_DWORD /d 0 /f >nul 2>&1
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d 1 /f >nul 2>&1
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "ConfigureArchive" /t REG_DWORD /d 0 /f >nul 2>&1
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "DisableArchive" /t REG_DWORD /d 1 /f >nul 2>&1
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "DontSendAdditionalData" /t REG_DWORD /d 1 /f >nul 2>&1
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "LoggingDisabled" /t REG_DWORD /d 1 /f >nul 2>&1
REG ADD "HKEY_LOCAL_MACHINE\Software\WOW6432Node\Microsoft\DusmSvc\Settings" /v "DisableSystemBucket" /t REG_DWORD /d 1 /f >nul 2>&1
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d "1" /f >nul 2>&1
REG ADD "HKLM\Software\Wow6432Node\Microsoft\PCHealth\ErrorReporting" /v "ShowUI" /t REG_DWORD /d 0 /f >nul 2>&1
REG ADD "HKLM\Software\Wow6432Node\Microsoft\PCHealth\ErrorReporting" /v "DoReport" /t REG_DWORD /d 0 /f >nul 2>&1


REM Disable Windows Error Reporting related settings
REG ADD "HKEY_LOCAL_MACHINE\Software\WOW6432Node\Microsoft\Windows\Windows Error Reporting\BrokerUp" /v "WWAJSE" /t REG_DWORD /d 0 /f >nul 2>&1
REG ADD "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\HandwritingErrorReports" /v "PreventHandwritingErrorReports" /t REG_DWORD /d 1 /f >nul 2>&1
REG ADD "HKEY_LOCAL_MACHINE\Software\WOW6432Node\Microsoft\Windows NT\CurrentVersion\UnattendSettings\Windows Error Reporting" /v "DisableWER" /t REG_DWORD /d 00000001 /f >nul 2>&1
REG ADD "HKEY_LOCAL_MACHINE\Software\WOW6432Node\Microsoft\Windows\Windows Error Reporting\Consent" /v "DefaultConsent" /t REG_DWORD /d 00000000 /f >nul 2>&1

REM Adjust process priorities for specific applications
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\FortniteClient-Win64-Shipping.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\GTA5.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\javaw.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\csgo.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\VALORANT-Win64-Shipping.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1

REM Configure Windows telemetry and compatibility settings
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\AppCompat" /v "AllowTelemetry" /t REG_DWORD /d 00000000 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\AppCompat" /v "DisableInventory" /t REG_DWORD /d 00000001 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\AppCompat" /v "DisableUAR" /t REG_DWORD /d 00000001 /f >nul 2>&1

REM Adjust power management settings for CPU
reg add "HKLM\SYSTEM\ControlSet001\Control\Class\{4D36E968-E325-11CE-BFC1-08002BE10318}\0000" /v "AllowDeepCStates" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\System\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}" /v "DisableDynamicPstate" /t REG_DWORD /d "1" /f >nul 2>&1

REM Adjust early launch driver loading policy
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\EarlyLaunch" /v DriverLoadPolicy /t REG_DWORD /d 0 /f >nul 2>&1

REM Adjust memory usage settings for specific processes
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\audiodg.exe" /v "UseLargePages" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\csrss.exe" /v "UseLargePages" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\dllhost.exe" /v "UseLargePages" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\dwm.exe" /v "UseLargePages" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\explorer.exe" /v "UseLargePages" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\lsass.exe" /v "UseLargePages" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\lsm.exe" /v "UseLargePages" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ntoskrnl.exe" /v "UseLargePages" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\rundll32.exe" /v "UseLargePages" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\services.exe" /v "UseLargePages" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\smss.exe" /v "UseLargePages" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\csgo.exe" /v "Priority" /t REG_DWORD /d 3 /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\svchost.exe" /v "UseLargePages" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\taskeng.exe" /v "UseLargePages" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\taskmgr.exe" /v "UseLargePages" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\wininit.exe" /v "UseLargePages" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\winlogon.exe" /v "UseLargePages" /t REG_DWORD /d "1" /f >nul 2>&1

REM Enable GPU scheduling and TCP offload settings
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\DirectX\UserGpuPreferences" /v "DirectXUserGlobalSettings" /t REG_SZ /d "VRROptimizeEnable=0;" /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Virtualization\GPU Scheduling" /v "GPUSchedulerEnabled" /t REG_DWORD /d 1 /f >nul 2>&1
reg add HKLM\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters /v DisableTaskOffload /t REG_DWORD /d 0 /f >nul 2>&1
set "file=C:\Vitality\Info\windows"
if not exist "%file%" (
    echo Vitality > "%file%"
    set /a "ran_optimizations+=1"
)
cd C:\Vitality
set "formatted_optimizations=%ran_optimizations%"
if %formatted_optimizations% LSS 10 set "formatted_optimizations= %formatted_optimizations%"
echo set "ran_optimizations=%ran_optimizations%"> v.bat
:skippingwindows

if "%CPU%"=="false" goto skippingcpu
if %cpu%==Intel (
    goto intel
) else (
    goto amd
)

:intel
echo                                                     Applying CPU Tweaks
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDelay" /t REG_DWORD /d 8 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrLevel" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrLimitCount" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrLimitTime" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d 4294967295 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d 00000000 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v "PowerThrottlingOff" /t REG_DWORD /d 00000001 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 00000026 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Affinity" /t REG_DWORD /d 00000000 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Background Only" /t REG_SZ /d True /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Clock Rate" /t REG_DWORD /d 00002710 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 00000008 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 00000008 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d High /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d High /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\DisplayPostProcessing" /v "Affinity" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\DisplayPostProcessing" /v "Background Only" /t REG_SZ /d "True" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\DisplayPostProcessing" /v "BackgroundPriority" /t REG_DWORD /d "24" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\DisplayPostProcessing" /v "Clock Rate" /t REG_DWORD /d "10000" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\DisplayPostProcessing" /v "GPU Priority" /t REG_DWORD /d "18" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\DisplayPostProcessing" /v "Priority" /t REG_DWORD /d "8" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\DisplayPostProcessing" /v "Scheduling Category" /t REG_SZ /d "High" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\DisplayPostProcessing" /v "SFIO Priority" /t REG_SZ /d "High" /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\Software\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\DisplayPostProcessing" /v "Latency Sensitive" /t REG_SZ /d "True" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\GpuEnergyDrv" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\GpuEnergyDr" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Distribution" /v "Affinity" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Distribution" /v "Background Only" /t REG_SZ /d "True" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Distribution" /v "Clock Rate" /t REG_DWORD /d "10000" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Distribution" /v "GPU Priority" /t REG_DWORD /d "8" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Distribution" /v "Priority" /t REG_DWORD /d "8" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Distribution" /v "Scheduling Category" /t REG_SZ /d "High" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Distribution" /v "SFIO Priority" /t REG_SZ /d "High" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "Clock Rate" /t REG_DWORD /d "10000" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "GPU Priority" /t REG_DWORD /d "8" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "Priority" /t REG_DWORD /d "8" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "Scheduling Category" /t REG_SZ /d "High" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "SFIO Priority" /t REG_SZ /d "High" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "Latency Sensitive" /t REG_SZ /d "True" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Window Manager" /v "Affinity" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Window Manager" /v "Background Only" /t REG_SZ /d "True" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Window Manager" /v "Clock Rate" /t REG_DWORD /d "10000" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Window Manager" /v "GPU Priority" /t REG_DWORD /d "8" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Window Manager" /v "Priority" /t REG_DWORD /d "8" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Window Manager" /v "Scheduling Category" /t REG_SZ /d "High" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\Policy\Settings\Processor" /v "PerfEnergyPreference" /t REG_DWORD /d "0" /f >nul 2>&1



reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\Policy\Settings\Processor" /v "CPMinCores" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\Policy\Settings\Processor" /v "CPMaxCores" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\Policy\Settings\Processor" /v "CPMinCores1" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\Policy\Settings\Processor" /v "CPMaxCores1" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\Policy\Settings\Processor" /v "CPDistribution" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\Policy\Settings\Processor" /v "MaxPerformance1" /t REG_DWORD /d "100" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\Policy\Settings\Processor" /v "MaxPerformance" /t REG_DWORD /d "100" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\Policy\Settings\Processor" /v "CPDistribution1" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\Policy\Settings\Processor" /v "CPHEADROOM" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\Policy\Settings\Processor" /v "CPCONCURRENCY" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\Policy\Settings\Processor" /v "CPIncreaseTime" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\Policy\Settings\Processor" /v "CpLatencyHintUnpark" /t REG_DWORD /d "100" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\Policy\Settings\Processor" /v "CpLatencyHintUnpark1" /t REG_DWORD /d "100" /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v Attributes /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMin" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMax" /t REG_DWORD /d 0 /f >nul 2>&1
REG ADD "HKLM\System\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0001" /v "PowerSavingMode" /t REG_SZ /d "0" /f >nul 2>&1
REG ADD "HKLM\System\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0002" /v "PowerSavingMode" /t REG_SZ /d "0" /f >nul 2>&1
REG ADD "HKLM\System\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0002" /v "*EEE" /t REG_SZ /d "0" /f >nul 2>&1
REG ADD "HKEY_LOCAL_MACHINE\System\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0001" /v "AlternateSemaphoreDelay" /t REG_SZ /d "0" /f >nul 2>&1
REG ADD "HKEY_LOCAL_MACHINE\System\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0001" /v "EnableSavePowerNow" /t REG_SZ /d "0" /f >nul 2>&1
REG ADD "HKEY_LOCAL_MACHINE\System\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0001" /v "*PMARPOffload" /t REG_SZ /d "0" /f >nul 2>&1
REG ADD "HKEY_LOCAL_MACHINE\System\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0001" /v "MIMOPowerSaveMode" /t REG_SZ /d "3" /f >nul 2>&1
REG ADD "HKEY_LOCAL_MACHINE\System\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0001" /v "EnableDynamicPowerGating" /t REG_SZ /d "0" /f >nul 2>&1
REG ADD "HKEY_LOCAL_MACHINE\System\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0001" /v "*WakeOnMagicPacket" /t REG_SZ /d "0" /f >nul 2>&1
REG ADD "HKEY_LOCAL_MACHINE\System\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0001" /v "EnableConnectedPowerGating" /t REG_DWORD /d "0" /f >nul 2>&1
REG ADD "HKEY_LOCAL_MACHINE\System\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0001" /v "*WakeOnPattern" /t REG_SZ /d "0" /f >nul 2>&1
REG ADD "HKEY_LOCAL_MACHINE\System\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0001" /v "*PMNSOffload" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\FortniteClient-Win64-Shipping.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\GTA5.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\javaw.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\csgo.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\VALORANT-Win64-Shipping.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg.exe add "HKLM\System\CurrentControlSet\Services\AmdK8" /v "Start" /t REG_DWORD /d "3" /f > NUL 2>&1
reg.exe add "HKLM\System\CurrentControlSet\Services\AmdPPM" /v "Start" /t REG_DWORD /d "3" /f > NUL 2>&1
reg.exe add "HKLM\System\CurrentControlSet\Services\amdsata" /v "Start" /t REG_DWORD /d "3" /f > NUL 2>&1
reg.exe add "HKLM\System\CurrentControlSet\Services\amdsbs" /v "Start" /t REG_DWORD /d "3" /f > NUL 2>&1
reg.exe add "HKLM\System\CurrentControlSet\Services\amdxata" /v "Start" /t REG_DWORD /d "3" /f > NUL 2>&1
set "file=C:\Vitality\Info\cpu"
if not exist "%file%" (
    echo Vitality > "%file%"
    set /a "ran_optimizations+=1"
)
cd C:\Vitality
set "formatted_optimizations=%ran_optimizations%"
if %formatted_optimizations% LSS 10 set "formatted_optimizations= %formatted_optimizations%"
echo set "ran_optimizations=%ran_optimizations%"> v.bat
goto skippingcpu


:amd
echo                                                     Applying CPU Tweaks

REM Adjust graphics driver timeout settings
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDelay" /t REG_DWORD /d 8 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrLevel" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrLimitCount" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrLimitTime" /t REG_DWORD /d 0 /f >nul 2>&1

REM Optimize multimedia and gaming performance
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d 4294967295 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d 00000000 /f >nul 2>&1


REM Disable power throttling
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v "PowerThrottlingOff" /t REG_DWORD /d 00000001 /f >nul 2>&1

REM Adjust process priority separation
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 00000026 /f >nul 2>&1

REM Optimize gaming tasks
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Affinity" /t REG_DWORD /d 00000000 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Background Only" /t REG_SZ /d True /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Clock Rate" /t REG_DWORD /d 00002710 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 00000008 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 00000008 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d High /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d High /f >nul 2>&1

REM Enable hardware accelerated scheduling
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_DWORD /d 2 /f >nul 2>&1

REM Optimize display post-processing
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\DisplayPostProcessing" /v "Affinity" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\DisplayPostProcessing" /v "Background Only" /t REG_SZ /d "True" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\DisplayPostProcessing" /v "BackgroundPriority" /t REG_DWORD /d "24" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\DisplayPostProcessing" /v "Clock Rate" /t REG_DWORD /d "10000" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\DisplayPostProcessing" /v "GPU Priority" /t REG_DWORD /d "18" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\DisplayPostProcessing" /v "Priority" /t REG_DWORD /d "8" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\DisplayPostProcessing" /v "Scheduling Category" /t REG_SZ /d "High" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\DisplayPostProcessing" /v "SFIO Priority" /t REG_SZ /d "High" /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\Software\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\DisplayPostProcessing" /v "Latency Sensitive" /t REG_SZ /d "True" /f >nul 2>&1

REM Optimize tasks distribution
reg add "HKLM\SYSTEM\CurrentControlSet\Services\GpuEnergyDrv" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\GpuEnergyDr" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

REM Optimize low latency tasks
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Distribution" /v "Affinity" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Distribution" /v "Background Only" /t REG_SZ /d "True" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Distribution" /v "Clock Rate" /t REG_DWORD /d "10000" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Distribution" /v "GPU Priority" /t REG_DWORD /d "8" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Distribution" /v "Priority" /t REG_DWORD /d "8" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Distribution" /v "Scheduling Category" /t REG_SZ /d "High" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Distribution" /v "SFIO Priority" /t REG_SZ /d "High" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "Clock Rate" /t REG_DWORD /d "10000" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "GPU Priority" /t REG_DWORD /d "8" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "Priority" /t REG_DWORD /d "8" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "Scheduling Category" /t REG_SZ /d "High" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "SFIO Priority" /t REG_SZ /d "High" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "Latency Sensitive" /t REG_SZ /d "True" /f >nul 2>&1

REM Optimize window manager tasks
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Window Manager" /v "Affinity" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Window Manager" /v "Background Only" /t REG_SZ /d "True" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Window Manager" /v "Clock Rate" /t REG_DWORD /d "10000" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Window Manager" /v "GPU Priority" /t REG_DWORD /d "8" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Window Manager" /v "Priority" /t REG_DWORD /d "8" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Window Manager" /v "Scheduling Category" /t REG_SZ /d "High" /f >nul 2>&1

REM Optimize processor energy preference
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\Policy\Settings\Processor" /v "PerfEnergyPreference" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\Policy\Settings\Processor" /v "CPMinCores" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\Policy\Settings\Processor" /v "CPMaxCores" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\Policy\Settings\Processor" /v "CPMinCores1" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\Policy\Settings\Processor" /v "CPMaxCores1" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\Policy\Settings\Processor" /v "CPDistribution" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\Policy\Settings\Processor" /v "MaxPerformance1" /t REG_DWORD /d "100" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\Policy\Settings\Processor" /v "MaxPerformance" /t REG_DWORD /d "100" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\Policy\Settings\Processor" /v "CPDistribution1" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\Policy\Settings\Processor" /v "CPHEADROOM" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\Policy\Settings\Processor" /v "CPCONCURRENCY" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\Policy\Settings\Processor" /v "CPIncreaseTime" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\Policy\Settings\Processor" /v "CpLatencyHintUnpark" /t REG_DWORD /d "100" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\Policy\Settings\Processor" /v "CpLatencyHintUnpark1" /t REG_DWORD /d "100" /f >nul 2>&1


REM Modify power settings attributes
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v Attributes /t REG_DWORD /d 0 /f >nul 2>&1

REM Adjust minimum and maximum power values
reg add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMin" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMax" /t REG_DWORD /d 0 /f >nul 2>&1

REM Disable power-saving features for specific devices
REG ADD "HKLM\System\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0001" /v "PowerSavingMode" /t REG_SZ /d "0" /f >nul 2>&1
REG ADD "HKLM\System\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0002" /v "PowerSavingMode" /t REG_SZ /d "0" /f >nul 2>&1
REG ADD "HKLM\System\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0002" /v "*EEE" /t REG_SZ /d "0" /f >nul 2>&1

REM Adjust CPU priority for specific applications
REG ADD "HKEY_LOCAL_MACHINE\System\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0001" /v "AlternateSemaphoreDelay" /t REG_SZ /d "0" /f >nul 2>&1
REG ADD "HKEY_LOCAL_MACHINE\System\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0001" /v "EnableSavePowerNow" /t REG_SZ /d "0" /f >nul 2>&1
REG ADD "HKEY_LOCAL_MACHINE\System\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0001" /v "*PMARPOffload" /t REG_SZ /d "0" /f >nul 2>&1
REG ADD "HKEY_LOCAL_MACHINE\System\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0001" /v "MIMOPowerSaveMode" /t REG_SZ /d "3" /f >nul 2>&1
REG ADD "HKEY_LOCAL_MACHINE\System\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0001" /v "EnableDynamicPowerGating" /t REG_SZ /d "0" /f >nul 2>&1
REG ADD "HKEY_LOCAL_MACHINE\System\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0001" /v "*WakeOnMagicPacket" /t REG_SZ /d "0" /f >nul 2>&1
REG ADD "HKEY_LOCAL_MACHINE\System\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0001" /v "EnableConnectedPowerGating" /t REG_DWORD /d "0" /f >nul 2>&1
REG ADD "HKEY_LOCAL_MACHINE\System\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0001" /v "*WakeOnPattern" /t REG_SZ /d "0" /f >nul 2>&1
REG ADD "HKEY_LOCAL_MACHINE\System\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0001" /v "*PMNSOffload" /t REG_SZ /d "0" /f >nul 2>&1

REM Disable specific services for power management
reg.exe add "HKLM\System\CurrentControlSet\Services\iagpio" /v "Start" /t REG_DWORD /d "3" /f > NUL 2>&1
reg.exe add "HKLM\System\CurrentControlSet\Services\iai2c" /v "Start" /t REG_DWORD /d "3" /f > NUL 2>&1
reg.exe add "HKLM\System\CurrentControlSet\Services\iaLPSS2i_GPIO2" /v "Start" /t REG_DWORD /d "3" /f > NUL 2>&1
reg.exe add "HKLM\System\CurrentControlSet\Services\iaLPSS2i_GPIO2_BXT_P" /v "Start" /t REG_DWORD /d "3" /f > NUL 2>&1
reg.exe add "HKLM\System\CurrentControlSet\Services\iaLPSS2i_I2C" /v "Start" /t REG_DWORD /d "3" /f > NUL 2>&1	 reg.exe add "HKLM\System\CurrentControlSet\Services\iaLPSS2i_I2C_BXT_P" /v "Start" /t REG_DWORD /d "4" /f > NUL 2>&1	 reg.exe add "HKLM\System\CurrentControlSet\Services\iaLPSSi_GPIO" /v "Start" /t REG_DWORD /d "4" /f > NUL 2>&1	 reg.exe add "HKLM\System\CurrentControlSet\Services\iaLPSSi_I2C" /v "Start" /t REG_DWORD /d "4" /f > NUL 2>&1
reg.exe add "HKLM\System\CurrentControlSet\Services\iaStorAVC" /v "Start" /t REG_DWORD /d "3" /f > NUL 2>&1
reg.exe add "HKLM\System\CurrentControlSet\Services\iaStorV" /v "Start" /t REG_DWORD /d "3" /f > NUL 2>&1
reg.exe add "HKLM\System\CurrentControlSet\Services\intelide" /v "Start" /t REG_DWORD /d "3" /f > NUL 2>&1
reg.exe add "HKLM\System\CurrentControlSet\Services\intelpep" /v "Start" /t REG_DWORD /d "3" /f > NUL 2>&1
reg.exe add "HKLM\System\CurrentControlSet\Services\intelppm" /v "Start" /t REG_DWORD /d "3" /f > NUL 2>&1
set "file=C:\Vitality\Info\cpu"
if not exist "%file%" (
    echo Vitality > "%file%"
    set /a "ran_optimizations+=1"
)
cd C:\Vitality
set "formatted_optimizations=%ran_optimizations%"
if %formatted_optimizations% LSS 10 set "formatted_optimizations= %formatted_optimizations%"
echo set "ran_optimizations=%ran_optimizations%"> v.bat
goto skippingcpu

:skippingcpu


if "%HighQuality%"=="false" goto skippinghighquality
echo                                           Applying High Quality Recording Settings
if not exist "%appdata%\obs-studio" echo                                                        Reinstall OBS
taskkill /f /im obs64.exe >nul 2>&1
for /f %%A in ('powershell.exe -Command "(Get-WmiObject -Class Win32_VideoController).CurrentHorizontalResolution"') do set "horizontal=%%A"
for /f %%A in ('powershell.exe -Command "(Get-WmiObject -Class Win32_VideoController).CurrentVerticalResolution"') do set "vertical=%%A"
if %gpu1% == Nvidia (
	(for %%i in (
		"[AdvOut]"
		"RecEncoder=jim_nvenc"
		"RecRB=true"
		"TrackIndex=1"
		"RecType=Standard"
		"RecFormat=mp4"
		"RecTracks=1"
		"FLVTrack=1"
		"FFOutputToFile=true"
		"FFFormat="
		"FFFormatMimeType="
		"FFVEncoderId=0"
		"FFVEncoder="
		"FFAEncoderId=0"
		"FFAEncoder="
		"FFAudioMixes=1"
		"VodTrackIndex=2"
		.
		"[General]"
		"Name=Untitled"
		.
		"[Video]"
		"BaseCX=!width!"
		"BaseCY=!height!"
		"OutputCX=!width!"
		"OutputCY=!height!"
		"FPSDen=1"
		"FPSType=2"
		"ScaleType=bilinear"
		"FPSNum=60"
		"ColorSpace=sRGB"
		"ColorRange=Full"
		.
		"[Output]"
		"RecType=Standard"
		"Mode=Advanced"
	) do echo.%%~i)>"%TEMP%\Basic.ini"
	echo.{"bf":2,"cqp":17,"keyint_sec":0,"lookahead":"false","multipass":"disabled","preset2":"p1","profile":"baseline","rate_control":"CQP"} >"%TEMP%\RecordEncoder.json"
    move /Y "%TEMP%\basic.ini" "%APPDATA%\obs-studio\basic\profiles\Untitled\" >nul 2>&1
    move /Y "%TEMP%\RecordEncoder.json" "%APPDATA%\obs-studio\basic\profiles\Untitled\" >nul 2>&1
    set "file=C:\Vitality\Info\obs"
    if not exist "%file%" (
    echo Vitality > "%file%"
    set /a "ran_optimizations+=1"
    )
    cd C:\Vitality
    set "formatted_optimizations=%ran_optimizations%"
    if %formatted_optimizations% LSS 10 set "formatted_optimizations= %formatted_optimizations%"
    echo set "ran_optimizations=%ran_optimizations%"> v.bat
    goto obsend
)

if %gpu1% == AMD (
	(for %%i in (
		"[AdvOut]"
		"RecEncoder=h264_texture_amf"
		"RecRB=true"
		"TrackIndex=1"
		"RecType=Standard"
		"RecFormat=mp4"
		"RecTracks=1"
		"FLVTrack=1"
		"FFOutputToFile=true"
		"FFFormat="
		"FFFormatMimeType="
		"FFVEncoderId=0"
		"FFVEncoder="
		"FFAEncoderId=0"
		"FFAEncoder="
		"FFAudioMixes=1"
		"VodTrackIndex=2"
		.
		"[General]"
		"Name=Untitled"
		.
		"[Video]"
		"BaseCX=!width!"
		"BaseCY=!height!"
		"OutputCX=!width!"
		"OutputCY=!height!"
		"FPSDen=1"
		"FPSType=2"
		"ScaleType=bilinear"
		"FPSNum=60"
		"ColorSpace=sRGB"
		"ColorRange=Full"
		.
		"[Output]"
		"RecType=Standard"
		"Mode=Advanced"
	) do echo.%%~i)>"%TEMP%\Basic.ini"
	echo.{"cqp":18,"preset":"speed","profile":"baseline","rate_control":"CQP"} >"%TEMP%\RecordEncoder.json"
    move /Y "%TEMP%\basic.ini" "%APPDATA%\obs-studio\basic\profiles\Untitled\" >nul 2>&1
    move /Y "%TEMP%\RecordEncoder.json" "%APPDATA%\obs-studio\basic\profiles\Untitled\" >nul 2>&1
    set "file=C:\Vitality\Info\obs"
    if not exist "%file%" (
    echo Vitality > "%file%"
    set /a "ran_optimizations+=1"
    )
    cd C:\Vitality
    set "formatted_optimizations=%ran_optimizations%"
    if %formatted_optimizations% LSS 10 set "formatted_optimizations= %formatted_optimizations%"
    echo set "ran_optimizations=%ran_optimizations%"> v.bat
    goto obsend
)

if %gpu1% == NaN (
	(for %%i in (
		"[AdvOut]"
		"RecEncoder=obs_x264"
		"RecRB=true"
		"TrackIndex=1"
		"RecType=Standard"
		"RecFormat=mp4"
		"RecTracks=1"
		"FLVTrack=1"
		"FFOutputToFile=true"
		"FFFormat="
		"FFFormatMimeType="
		"FFVEncoderId=0"
		"FFVEncoder="
		"FFAEncoderId=0"
		"FFAEncoder="
		"FFAudioMixes=1"
		"VodTrackIndex=2"
		.
		"[General]"
		"Name=Untitled"
		.
		"[Video]"
		"BaseCX=!width!"
		"BaseCY=!height!"
		"OutputCX=!width!"
		"OutputCY=!height!"
		"FPSDen=1"
		"FPSType=2"
		"ScaleType=bilinear"
		"FPSNum=60"
		"ColorSpace=sRGB"
		"ColorRange=Full"
		.
		"[Output]"
		"RecType=Standard"
		"Mode=Advanced"
	) do echo.%%~i)>"%TEMP%\Basic.ini"
	echo.{"bitrate":40000,"preset":"faster","profile":"baseline","tune":"film"} >"%TEMP%\RecordEncoder.json"
    move /Y "%TEMP%\basic.ini" "%APPDATA%\obs-studio\basic\profiles\Untitled\" >nul 2>&1
    move /Y "%TEMP%\RecordEncoder.json" "%APPDATA%\obs-studio\basic\profiles\Untitled\" >nul 2>&1
    set "file=C:\Vitality\Info\obs"
    if not exist "%file%" (
    echo Vitality > "%file%"
    set /a "ran_optimizations+=1"
    )
    cd C:\Vitality
    set "formatted_optimizations=%ran_optimizations%"
    if %formatted_optimizations% LSS 10 set "formatted_optimizations= %formatted_optimizations%"
    echo set "ran_optimizations=%ran_optimizations%"> v.bat
    goto obsend
)




:skippinghighquality






if "%MediumQuality%"=="false" goto skippingmediumquality
echo                                          Applying Medium Quality Recording Settings
if not exist "%appdata%\obs-studio" echo                                                        Reinstall OBS
taskkill /f /im obs64.exe >nul 2>&1
for /f %%A in ('powershell.exe -Command "(Get-WmiObject -Class Win32_VideoController).CurrentHorizontalResolution"') do set "horizontal=%%A"
for /f %%A in ('powershell.exe -Command "(Get-WmiObject -Class Win32_VideoController).CurrentVerticalResolution"') do set "vertical=%%A"
if %gpu1% == Nvidia (
	(for %%i in (
		"[AdvOut]"
		"RecEncoder=jim_nvenc"
		"RecRB=true"
		"TrackIndex=1"
		"RecType=Standard"
		"RecFormat=mp4"
		"RecTracks=1"
		"FLVTrack=1"
		"FFOutputToFile=true"
		"FFFormat="
		"FFFormatMimeType="
		"FFVEncoderId=0"
		"FFVEncoder="
		"FFAEncoderId=0"
		"FFAEncoder="
		"FFAudioMixes=1"
		"VodTrackIndex=2"
		.
		"[General]"
		"Name=Untitled"
		.
		"[Video]"
		"BaseCX=!width!"
		"BaseCY=!height!"
		"OutputCX=!width!"
		"OutputCY=!height!"
		"FPSDen=1"
		"FPSType=2"
		"ScaleType=bilinear"
		"FPSNum=180"
		"ColorSpace=sRGB"
		"ColorRange=Partial"
		.
		"[Output]"
		"RecType=Standard"
		"Mode=Advanced"
	) do echo.%%~i)>"%TEMP%\Basic.ini"
	echo.{"bf":0,"cqp":18,"keyint_sec":0,"lookahead":"false","multipass":"disabled","preset2":"p1","profile":"baseline","psycho_aq":"false","rate_control":"CQP"} >"%TEMP%\RecordEncoder.json"
    move /Y "%TEMP%\basic.ini" "%APPDATA%\obs-studio\basic\profiles\Untitled\" >nul 2>&1
    move /Y "%TEMP%\RecordEncoder.json" "%APPDATA%\obs-studio\basic\profiles\Untitled\" >nul 2>&1
    set "file=C:\Vitality\Info\obs"
    if not exist "%file%" (
    echo Vitality > "%file%"
    set /a "ran_optimizations+=1"
    )
    cd C:\Vitality
    set "formatted_optimizations=%ran_optimizations%"
    if %formatted_optimizations% LSS 10 set "formatted_optimizations= %formatted_optimizations%"
    echo set "ran_optimizations=%ran_optimizations%"> v.bat
    goto obsend
)

if %gpu1% == AMD (
	(for %%i in (
		"[AdvOut]"
		"RecEncoder=h264_texture_amf"
		"RecRB=true"
		"TrackIndex=1"
		"RecType=Standard"
		"RecFormat=mp4"
		"RecTracks=1"
		"FLVTrack=1"
		"FFOutputToFile=true"
		"FFFormat="
		"FFFormatMimeType="
		"FFVEncoderId=0"
		"FFVEncoder="
		"FFAEncoderId=0"
		"FFAEncoder="
		"FFAudioMixes=1"
		"VodTrackIndex=2"
		.
		"[General]"
		"Name=Untitled"
		.
		"[Video]"
		"BaseCX=!width!"
		"BaseCY=!height!"
		"OutputCX=!width!"
		"OutputCY=!height!"
		"FPSDen=1"
		"FPSType=2"
		"ScaleType=bilinear"
		"FPSNum=180"
		"ColorSpace=sRGB"
		"ColorRange=Partial"
		.
		"[Output]"
		"RecType=Standard"
		"Mode=Advanced"
	) do echo.%%~i)>"%TEMP%\Basic.ini"
	echo.{"cqp":18,"preset":"speed","profile":"baseline","rate_control":"CQP"} >"%TEMP%\RecordEncoder.json"
    move /Y "%TEMP%\basic.ini" "%APPDATA%\obs-studio\basic\profiles\Untitled\" >nul 2>&1
    move /Y "%TEMP%\RecordEncoder.json" "%APPDATA%\obs-studio\basic\profiles\Untitled\" >nul 2>&1
    set "file=C:\Vitality\Info\obs"
    if not exist "%file%" (
    echo Vitality > "%file%"
    set /a "ran_optimizations+=1"
    )
    cd C:\Vitality
    set "formatted_optimizations=%ran_optimizations%"
    if %formatted_optimizations% LSS 10 set "formatted_optimizations= %formatted_optimizations%"
    echo set "ran_optimizations=%ran_optimizations%"> v.bat
    goto obsend
)

if %gpu1% == NaN(
	(for %%i in (
		"[AdvOut]"
		"RecEncoder=obs_x264"
		"RecRB=true"
		"TrackIndex=1"
		"RecType=Standard"
		"RecFormat=mp4"
		"RecTracks=1"
		"FLVTrack=1"
		"FFOutputToFile=true"
		"FFFormat="
		"FFFormatMimeType="
		"FFVEncoderId=0"
		"FFVEncoder="
		"FFAEncoderId=0"
		"FFAEncoder="
		"FFAudioMixes=1"
		"VodTrackIndex=2"
		.
		"[General]"
		"Name=Untitled"
		.
		"[Video]"
		"BaseCX=!width!"
		"BaseCY=!height!"
		"OutputCX=!width!"
		"OutputCY=!height!"
		"FPSDen=1"
		"FPSType=2"
		"ScaleType=bilinear"
		"FPSNum=180"
		"ColorSpace=sRGB"
		"ColorRange=Partial"
		.
		"[Output]"
		"RecType=Standard"
		"Mode=Advanced"
	) do echo.%%~i)>"%TEMP%\Basic.ini"
	echo.{"bitrate":30000,"preset":"veryfast","profile":"baseline","tune":"film"} >"%TEMP%\RecordEncoder.json"
    move /Y "%TEMP%\basic.ini" "%APPDATA%\obs-studio\basic\profiles\Untitled\" >nul 2>&1
    move /Y "%TEMP%\RecordEncoder.json" "%APPDATA%\obs-studio\basic\profiles\Untitled\" >nul 2>&1
    set "file=C:\Vitality\Info\obs"
    if not exist "%file%" (
    echo Vitality > "%file%"
    set /a "ran_optimizations+=1"
    )
    cd C:\Vitality
    set "formatted_optimizations=%ran_optimizations%"
    if %formatted_optimizations% LSS 10 set "formatted_optimizations= %formatted_optimizations%"
    echo set "ran_optimizations=%ran_optimizations%"> v.bat
    goto obsend
)


:skippingmediumquality












if "%LowQuality%"=="false" goto skippinglowquality
echo                                           Applying Low Quality Recording Settings
if not exist "%appdata%\obs-studio" echo                                                        Reinstall OBS
taskkill /f /im obs64.exe >nul 2>&1
for /f %%A in ('powershell.exe -Command "(Get-WmiObject -Class Win32_VideoController).CurrentHorizontalResolution"') do set "horizontal=%%A"
for /f %%A in ('powershell.exe -Command "(Get-WmiObject -Class Win32_VideoController).CurrentVerticalResolution"') do set "vertical=%%A"
if %gpu1% == Nvidia (
	(for %%i in (
		"[AdvOut]"
		"RecEncoder=jim_nvenc"
		"RecRB=true"
		"TrackIndex=1"
		"RecType=Standard"
		"RecFormat=mp4"
		"RecTracks=1"
		"FLVTrack=1"
		"FFOutputToFile=true"
		"FFFormat="
		"FFFormatMimeType="
		"FFVEncoderId=0"
		"FFVEncoder="
		"FFAEncoderId=0"
		"FFAEncoder="
		"FFAudioMixes=1"
		"VodTrackIndex=2"
		.
		"[General]"
		"Name=Untitled"
		.
		"[Video]"
		"BaseCX=!width!"
		"BaseCY=!height!"
		"OutputCX=1280"
		"OutputCY=720"
		"FPSDen=1"
		"FPSType=2"
		"ScaleType=bicubic"
		"FPSNum=180"
		"ColorSpace=sRGB"
		"ColorRange=Partial"
		.
		"[Output]"
		"RecType=Standard"
		"Mode=Advanced"
	) do echo.%%~i)>"%TEMP%\Basic.ini"
	echo.{"bf":0,"cqp":19,"keyint_sec":0,"lookahead":"false","multipass":"disabled","preset2":"p1","profile":"baseline","psycho_aq":"false","rate_control":"CQP"} >"%TEMP%\RecordEncoder.json"
    move /Y "%TEMP%\basic.ini" "%APPDATA%\obs-studio\basic\profiles\Untitled\" >nul 2>&1
    move /Y "%TEMP%\RecordEncoder.json" "%APPDATA%\obs-studio\basic\profiles\Untitled\" >nul 2>&1
    set "file=C:\Vitality\Info\obs"
    if not exist "%file%" (
    echo Vitality > "%file%"
    set /a "ran_optimizations+=1"
    )
    cd C:\Vitality
    set "formatted_optimizations=%ran_optimizations%"
    if %formatted_optimizations% LSS 10 set "formatted_optimizations= %formatted_optimizations%"
    echo set "ran_optimizations=%ran_optimizations%"> v.bat
    goto obsend
)

if %gpu1% == AMD (
	(for %%i in (
		"[AdvOut]"
		"RecEncoder=h264_texture_amf"
		"RecRB=true"
		"TrackIndex=1"
		"RecType=Standard"
		"RecFormat=mp4"
		"RecTracks=1"
		"FLVTrack=1"
		"FFOutputToFile=true"
		"FFFormat="
		"FFFormatMimeType="
		"FFVEncoderId=0"
		"FFVEncoder="
		"FFAEncoderId=0"
		"FFAEncoder="
		"FFAudioMixes=1"
		"VodTrackIndex=2"
		.
		"[General]"
		"Name=Untitled"
		.
		"[Video]"
		"BaseCX=!width!"
		"BaseCY=!height!"
		"OutputCX=1280"
		"OutputCY=720"
		"FPSDen=1"
		"FPSType=2"
		"ScaleType=bicubic"
		"FPSNum=180"
		"ColorSpace=sRGB"
		"ColorRange=Partial"
		.
		"[Output]"
		"RecType=Standard"
		"Mode=Advanced"
	) do echo.%%~i)>"%TEMP%\Basic.ini"
	echo.{"cqp":18,"preset":"speed","profile":"baseline","rate_control":"CQP"} >"%TEMP%\RecordEncoder.json"
    move /Y "%TEMP%\basic.ini" "%APPDATA%\obs-studio\basic\profiles\Untitled\" >nul 2>&1
    move /Y "%TEMP%\RecordEncoder.json" "%APPDATA%\obs-studio\basic\profiles\Untitled\" >nul 2>&1
    set "file=C:\Vitality\Info\obs"
    if not exist "%file%" (
    echo Vitality > "%file%"
    set /a "ran_optimizations+=1"
    )
    cd C:\Vitality
    set "formatted_optimizations=%ran_optimizations%"
    if %formatted_optimizations% LSS 10 set "formatted_optimizations= %formatted_optimizations%"
    echo set "ran_optimizations=%ran_optimizations%"> v.bat
    goto obsend
)

if %gpu1% == NaN (
	(for %%i in (
		"[AdvOut]"
		"RecEncoder=obs_x264"
		"RecRB=true"
		"TrackIndex=1"
		"RecType=Standard"
		"RecFormat=mp4"
		"RecTracks=1"
		"FLVTrack=1"
		"FFOutputToFile=true"
		"FFFormat="
		"FFFormatMimeType="
		"FFVEncoderId=0"
		"FFVEncoder="
		"FFAEncoderId=0"
		"FFAEncoder="
		"FFAudioMixes=1"
		"VodTrackIndex=2"
		.
		"[General]"
		"Name=Untitled"
		.
		"[Video]"
		"BaseCX=!width!"
		"BaseCY=!height!"
		"OutputCX=1280"
		"OutputCY=720"
		"FPSDen=1"
		"FPSType=2"
		"ScaleType=bicubic"
		"FPSNum=180"
		"ColorSpace=sRGB"
		"ColorRange=Partial"
		.
		"[Output]"
		"RecType=Standard"
		"Mode=Advanced"
	) do echo.%%~i)>"%TEMP%\Basic.ini"
	echo.{"bitrate":25000,"preset":"ultrafast","profile":"baseline","tune":"fastdecode"} >"%TEMP%\RecordEncoder.json"
    move /Y "%TEMP%\basic.ini" "%APPDATA%\obs-studio\basic\profiles\Untitled\" >nul 2>&1
    move /Y "%TEMP%\RecordEncoder.json" "%APPDATA%\obs-studio\basic\profiles\Untitled\" >nul 2>&1
    
    set "file=C:\Vitality\Info\obs"
    if not exist "%file%" (
    echo Vitality > "%file%"
    set /a "ran_optimizations+=1"
    )
    cd C:\Vitality
    set "formatted_optimizations=%ran_optimizations%"
    if %formatted_optimizations% LSS 10 set "formatted_optimizations= %formatted_optimizations%"
    echo set "ran_optimizations=%ran_optimizations%"> v.bat
    goto obsend
)




:skippinglowquality





:obsend













if "%PrivacyCleanup%"=="false" goto skippingprivacypleanup
echo                                                   Applying Privacy Cleanup

REM Remove adware, spyware, PUPs
if not exist "%SYSTEMDRIVE%\Vitality\Resources\AdwCleaner" mkdir "%SYSTEMDRIVE%\Vitality\Resources\AdwCleaner"
del /F /Q "%SYSTEMDRIVE%\Vitality\Resources\AdwCleaner\AdwCleaner.exe" >nul 2>&1
curl -g -L -# -o "%SYSTEMDRIVE%\Vitality\Resources\AdwCleaner\AdwCleaner.exe" "https://adwcleaner.malwarebytes.com/adwcleaner?channel=release" >nul 2>&1

REM Startup Cleaner (shell:startup)
if exist "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Vitality-Cleaner.bat" del "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Vitality-Cleaner.bat"
curl -g -L -# -o "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Vitality-Cleaner.bat" "https://cdn.discordapp.com/attachments/1140029335944835152/1140255553873006742/Vitality-Cleaner.bat" >nul 2>&1

REM Delete Listary user data
del /f /s /q %appdata%\Listary\UserData > NUL 2>&1

REM Remove Java cache
rd /s /q "%APPDATA%\Sun\Java\Deployment\cache" > NUL 2>&1

REM Clear Flash Player Data
rd /s /q "%APPDATA%\Macromedia\Flash Player" > NUL 2>&1

REM Delete Steam crash dumps and traces
del /f /q %ProgramFiles(x86)%\Steam\Dumps > NUL 2>&1
del /f /q %ProgramFiles(x86)%\Steam\Traces > NUL 2>&1
del /f /q %ProgramFiles(x86)%\Steam\appcache\*.log > NUL 2>&1

REM Remove Visual Studion Telemtry data
rmdir /s /q "%AppData%\vstelemetry" > NUL 2>&1
rmdir /s /q "%LocalAppData%\Microsoft\VSApplicationInsights" > NUL 2>&1
rmdir /s /q "%ProgramData%\Microsoft\VSApplicationInsights" > NUL 2>&1
rmdir /s /q "%Temp%\Microsoft\VSApplicationInsights" > NUL 2>&1

REM Delete Visual Studio Fault And Feedback logs
rmdir /s /q "%Temp%\VSFaultInfo" > NUL 2>&1
rmdir /s /q "%Temp%\VSFeedbackPerfWatsonData" > NUL 2>&1
rmdir /s /q "%Temp%\VSFeedbackVSRTCLogs" > NUL 2>&1

REM Remove Visual Studio Remote Control And Telemetry data
rmdir /s /q "%Temp%\VSRemoteControl" > NUL 2>&1
rmdir /s /q "%Temp%\VSTelem" > NUL 2>&1
rmdir /s /q "%Temp%\VSTelem.Out" > NUL 2>&1

REM Clear .NET TelemetryStorageService data
rmdir /s /q "%USERPROFILE%\.dotnet\TelemetryStorageService" > NUL 2>&1

REM Delete Recent Registry Entries Related To Regedit
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Applets\Regedit" /va /f > NUL 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Applets\Regedit" /va /f> NUL 2>&1

REM Delete Recent Registry Entries Related To Favorites In Regedit
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Applets\Regedit\Favorites" /va /f > NUL 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Applets\Regedit\Favorites" /va /f > NUL 2>&1

REM Delete Recent Registry Entries Related To ComDlg32
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\LastVisitedPidlMRU" /va /f > NUL 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\LastVisitedPidlMRULegacy" /va /f > NUL 2>&1

REM Delete Recent Registry Entries Related To Adobe MediaBrowser
reg delete "HKCU\Software\Adobe\MediaBrowser\MRU" /va /f > NUL 2>&1

REM Delete Recent Registry Entries Related To Paint And Wordpad
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Applets\Paint\Recent File List" /va /f > NUL 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Applets\Paint\Recent File List" /va /f > NUL 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Applets\Wordpad\Recent File List" /va /f > NUL 2>&1

REM Delete Recent Registry Entries Related To Map Network Drives
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Map Network Drive MRU" /va /f > NUL 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Map Network Drive MRU" /va /f > NUL 2>&1

REM Delete Recent Registry Entries Related To Search Assistand And RecentDocuments
reg delete "HKCU\Software\Microsoft\Search Assistant\ACMru" /va /f > NUL 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs" /va /f > NUL 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs" /va /f > NUL 2>&1

REM Delete Recent Registry Entries Related To OpenSaveMRU And Media Player
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\OpenSaveMRU" /va /f > NUL 2>&1
reg delete "HKCU\Software\Microsoft\MediaPlayer\Player\RecentFileList" /va /f > NUL 2>&1
reg delete "HKCU\Software\Microsoft\MediaPlayer\Player\RecentURLList" /va /f > NUL 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\MediaPlayer\Player\RecentFileList" /va /f > NUL 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\MediaPlayer\Player\RecentURLList" /va /f > NUL 2>&1

REM Delete Recent Registry Entries Related To Direct3D And Explorer
reg delete "HKCU\Software\Microsoft\Direct3D\MostRecentApplication" /va /f > NUL 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Direct3D\MostRecentApplication" /va /f > NUL 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU" /va /f > NUL 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\TypedPaths" /va /f > NUL 2>&1

REM Delete AutomaticDestination And CustomDestinations In Recent Folder
del /f /q "%APPDATA%\Microsoft\Windows\Recent\AutomaticDestinations\*" > NUL 2>&1
del /f /q "%APPDATA%\Microsoft\Windows\Recent\CustomDestinations\*" > NUL 2>&1

REM Remove Opera Browser Data
rd /s /q "%USERPROFILE%\Local Settings\Application Data\Opera\Opera" > NUL 2>&1
rd /s /q "%localappdata%\Opera\Opera" > NUL 2>&1
rd /s /q "%APPDATA%\Opera\Opera" > NUL 2>&1

REM Delete Internet Explorer And Edge Cached Data
del /f /q "%localappdata%\Microsoft\Windows\INetCache\IE\*" > NUL 2>&1
rd /s /q "%localappdata%\Microsoft\Windows\WebCache" > NUL 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Internet Explorer\TypedURLs" /va /f > NUL 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Internet Explorer\TypedURLsTime" /va /f > NUL 2>&1

REM Remove Temporary Internet Files
rd /s /q %userprofile%\Local Settings\Temporary Internet Files > NUL 2>&1
rd /s /q "%localappdata%\Microsoft\Windows\Temporary Internet Files" > NUL 2>&1

REM Take ownership of Temporary Internet Files and grant admin full control
takeown /f "%localappdata%\Temporary Internet Files" /r /d y > NUL 2>&1
icacls "%localappdata%\Temporary Internet Files" /grant administrators:F /t > NUL 2>&1

REM Remove Temporary Internet Files (again)
rd /s /q "%localappdata%\Temporary Internet Files" > NUL 2>&1


REM Clear various browser caches and data
rd /s /q "%localappdata%\Microsoft\Windows\INetCache" > NUL 2>&1
rd /s /q "%localappdata%\Microsoft\Feeds Cache" > NUL 2>&1
rd /s /q "%APPDATA%\Microsoft\Windows\Cookies" > NUL 2>&1
rd /s /q "%localappdata%\Microsoft\Windows\INetCookies" > NUL 2>&1
rd /s /q "%localappdata%\Microsoft\InternetExplorer\DOMStore" > NUL 2>&1
rd /s /q "%localappdata%\Microsoft\Internet Explorer" > NUL 2>&1

REM Clear Google Chrome data
rd /s /q "%localappdata%\Google\Chrome\User Data\Crashpad\reports\" > NUL 2>&1
rd /s /q "%localappdata%\Google\CrashReports\" > NUL 2>&1
del /f /q "%localappdata%\Google\Software Reporter Tool\*.log" > NUL 2>&1
rd /s /q "%USERPROFILE%\Local Settings\Application Data\Google\Chrome\User Data" > NUL 2>&1
rd /s /q "%localappdata%\Google\Chrome\User Data" > NUL 2>&1

REM Clear Mozilla Firefox data
rd /s /q "%localappdata%\Mozilla\Firefox\Profiles" > NUL 2>&1
rd /s /q "%APPDATA%\Mozilla\Firefox\Profiles" > NUL 2>&1

REM Clear Safari data
del /q /s /f "%USERPROFILE%\Local Settings\Application Data\Safari\WebpageIcons.db" > NUL 2>&1
del /q /s /f "%localappdata%\Apple Computer\Safari\WebpageIcons.db" > NUL 2>&1

REM Clear Windows Explorer and Temp files
del /f /s /q /a %LocalAppData%\Microsoft\Windows\Explorer\*.db > NUL 2>&1
del /f /q %localappdata%\Temp\* > NUL 2>&1
rd /s /q "%WINDIR%\Temp" > NUL 2>&1
rd /s /q "%TEMP%" > NUL 2>&1

REM Clear Diagtrack log
if exist "%ProgramData%\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl" (
    takeown /f "%ProgramData%\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl" /r /d y > NUL 2>&1
    icacls "%ProgramData%\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl" /grant administrators:F /t > NUL 2>&1
    echo "" > "%ProgramData%\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl" > NUL 2>&1
    echo Clear successful: "%ProgramData%\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl" > NUL 2>&1
) 

REM Clear Windows Defender scan history
del "%ProgramData%\Microsoft\Windows Defender\Scans\History\" /s /f /q > NUL 2>&1

REM Delete various log files
del /f /q %SystemRoot%\comsetup.log > NUL 2>&1
del /f /q %SystemRoot%\DtcInstall.log > NUL 2>&1
del /f /q %SystemRoot%\PFRO.log > NUL 2>&1

REM Clear Windows Deployment Upgrade Process Logs
del /f /q %SystemRoot%\setupact.log > NUL 2>&1
del /f /q %SystemRoot%\setuperr.log > NUL 2>&1
del /f /q %SystemRoot%\setupapi.log > NUL 2>&1
del /f /q %SystemRoot%\Panther\* > NUL 2>&1
del /f /q %SystemRoot%\inf\setupapi.app.log > NUL 2>&1
del /f /q %SystemRoot%\inf\setupapi.dev.log > NUL 2>&1
del /f /q %SystemRoot%\inf\setupapi.offline.log > NUL 2>&1
del /f /q %SystemRoot%\Performance\WinSAT\winsat.log > NUL 2>&1
del /f /q %SystemRoot%\debug\PASSWD.LOG > NUL 2>&1

REM Clear Windows WebCache
del /f /q %localappdata%\Microsoft\Windows\WebCache\*.* > NUL 2>&1

REM Clear LocalService Temp files
del /f /q %SystemRoot%\ServiceProfiles\LocalService\AppData\Local\Temp\*.* > NUL 2>&1

REM Clear CBS and DISM logs
del /f /q  %SystemRoot%\Logs\CBS\CBS.log > NUL 2>&1
del /f /q  %SystemRoot%\Logs\DISM\DISM.log > NUL 2>&1

REM Clear SIH and CLR traces
del /f /q "%SystemRoot%\Logs\SIH\*" > NUL 2>&1
del /f /q "%LocalAppData%\Microsoft\CLR_v4.0\UsageTraces\*" > NUL 2>&1
del /f /q "%LocalAppData%\Microsoft\CLR_v4.0_32\UsageTraces\*" > NUL 2>&1

REM Clear NetSetup, setupcln, and Temp files
del /f /q "%SystemRoot%\Logs\NetSetup\*" > NUL 2>&1
del /f /q "%SystemRoot%\System32\LogFiles\setupcln\*" > NUL 2>&1
del /f /q %SystemRoot%\Temp\CBS\* > NUL 2>&1

REM Clear waasmedic log
takeown /f %SystemRoot%\Logs\waasmedic /r /d y > NUL 2>&1
icacls %SystemRoot%\Logs\waasmedic /grant administrators:F /t > NUL 2>&1
rd /s /q %SystemRoot%\Logs\waasmedic > NUL 2>&1

REM Clear catroot2 logs and database
del /f /q %SystemRoot%\System32\catroot2\dberr.txt > NUL 2>&1
del /f /q %SystemRoot%\System32\catroot2.log > NUL 2>&1
del /f /q %SystemRoot%\System32\catroot2.jrs > NUL 2>&1
del /f /q %SystemRoot%\System32\catroot2.edb > NUL 2>&1
del /f /q %SystemRoot%\System32\catroot2.chk > NUL 2>&1

REM Clear WindowsUpdate, delete defaultuser0, and modify registry
del /f /q "%SystemRoot%\Traces\WindowsUpdate\*" > NUL 2>&1
net user defaultuser0 /delete  > NUL 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\SideBySide\Configuration" /v "DisableResetbase" /t "REG_DWORD" /d "0" /f > NUL 2>&1

REM Reset default app associations using DISM
dism /online /Remove-DefaultAppAssociations > NUL 2>&1


cd %SYSTEMDRIVE%\Vitality >nul 2>&1
AdwCleaner.exe /eula /clean /noreboot >nul 2>&1

cleanmgr /sagerun:1 >nul 2>&1

set "file=C:\Vitality\Info\privacycleanup"
if not exist "%file%" (
    echo Vitality > "%file%"
    set /a "ran_optimizations+=1"
)
cd C:\Vitality
set "formatted_optimizations=%ran_optimizations%"
if %formatted_optimizations% LSS 10 set "formatted_optimizations= %formatted_optimizations%"
echo set "ran_optimizations=%ran_optimizations%"> v.bat
:skippingprivacypleanup


if "%DataCol%"=="false" goto skippingdatacol
echo                                                   Applying Data Collection
REM Disable CEIP (Customer Experience Improvement Program)
reg add "HKLM\Software\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d "0" /f >nul 2>&1

REM Disable AIT (Application Impact Telemetry)
reg add "HKLM\Software\Policies\Microsoft\Windows\AppCompat" /v "AITEnable" /t REG_DWORD /d "0" /f >nul 2>&1

REM Disable Customer Experience Improvement Program tasks
schtasks /change /TN "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /DISABLE >nul 2>&1
schtasks /change /TN "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /DISABLE >nul 2>&1
schtasks /change /TN "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /DISABLE >nul 2>&1

REM Disable Telemetry at various levels
reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /d 0 /t REG_DWORD /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "LimitEnhancedDiagnosticDataWindowsAnalytics" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f  >nul 2>&1

REM Disable Data Collection
reg add "HKLM\Software\Policies\Microsoft\Windows NT\CurrentVersion\Software Protection Platform" /v "NoGenTicket" /t "REG_DWORD" /d "1" /f >nul 2>&1

REM Disable Windows Error Reporting
reg add "HKLM\Software\Policies\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t "REG_DWORD" /d "1" /f >nul 2>&1
reg add "HKLM\Software\Microsoft\Windows\Windows Error Reporting\Consent" /v "DefaultConsent" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\Software\Microsoft\Windows\Windows Error Reporting\Consent" /v "DefaultOverrideBehavior" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\Software\Microsoft\Windows\Windows Error Reporting" /v "DontSendAdditionalData" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\Software\Microsoft\Windows\Windows Error Reporting" /v "LoggingDisabled" /t REG_DWORD /d "1" /f >nul 2>&1

REM Disable Error Details and Device Information tasks
schtasks /Change /TN "Microsoft\Windows\ErrorDetails\EnableErrorDetailsUpdate" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Windows Error Reporting\QueueReporting" /Disable >nul 2>&1
schtasks /change /TN "Microsoft\Windows\Device Information\Device" /disable >nul 2>&1

REM Modify Debugger for Device Census
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\'DeviceCensus.exe'" /v "Debugger" /t REG_SZ /d "%windir%\System32\taskkill.exe" /f >nul 2>&1

REM Disable Application Experience tasks
schtasks /change /TN "Microsoft\Windows\Application Experience\ProgramDataUpdater" /disable >nul 2>&1
schtasks /change /TN "Microsoft\Windows\Application Experience\AitAgent" /disable >nul 2>&1
schtasks /change /TN "Microsoft\Windows\Application Experience\StartupAppTask" /disable >nul 2>&1
schtasks /change /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /disable >nul 2>&1


REM Modify Debugger for CompatTelRunner.exe
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\'CompatTelRunner.exe'" /v "Debugger" /t REG_SZ /d "%windir%\System32\taskkill.exe" /f >nul 2>&1

REM Prevent device metadata retrieval from network
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v "PreventDeviceMetadataFromNetwork" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Device Metadata" /v "PreventDeviceMetadataFromNetwork" /t REG_DWORD /d 1 /f >nul 2>&1

REM Disable driver searching
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v "SearchOrderConfig" /t REG_DWORD /d 0 /f >nul 2>&1

REM Deny access to location for apps
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" /v "Value" /d "Deny" /f >nul 2>&1

REM Disable 'Geolocation Service'
reg add "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" /v "Status" /d "0" /t REG_DWORD /f >nul 2>&1

REM Configure app privacy settings for location
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessLocation" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessLocation_UserInControlOfTheseApps" /t REG_MULTI_SZ /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessLocation_ForceAllowTheseApps" /t REG_MULTI_SZ /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessLocation_ForceDenyTheseApps" /t REG_MULTI_SZ /f >nul 2>&1

REM Deny access to user account information
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userAccountInformation" /v "Value" /d "Deny" /f >nul 2>&1

REM Deny device access permissions
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{C1D23ACC-752B-43E5-8448-8D0E519CD6D6}" /t REG_SZ /v "Value" /d "Deny" /f >nul 2>&1

REM Configure app privacy settings for account info
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessAccountInfo" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessAccountInfo_UserInControlOfTheseApps" /t REG_MULTI_SZ /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessAccountInfo_ForceAllowTheseApps" /t REG_MULTI_SZ /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessAccountInfo_ForceDenyTheseApps" /t REG_MULTI_SZ /f >nul 2>&1

REM Deny access to activity info
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\activity" /v "Value" /d "Deny" /f >nul 2>&1

REM Configure app privacy settings for motion
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessMotion" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessMotion_UserInControlOfTheseApps" /t REG_MULTI_SZ /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessMotion_ForceAllowTheseApps" /t REG_MULTI_SZ /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessMotion_ForceDenyTheseApps" /t REG_MULTI_SZ /f >nul 2>&1

REM Configure app privacy settings for phone
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessPhone" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessPhone_UserInControlOfTheseApps" /t REG_MULTI_SZ /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessPhone_ForceAllowTheseApps" /t REG_MULTI_SZ /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessPhone_ForceDenyTheseApps" /t REG_MULTI_SZ /f >nul 2>&1

REM Deny access to trusted devices
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{C1D23ACC-752B-43E5-8448-8D0E519CD6D6}" /t REG_SZ /v "Value" /d "Deny" /f >nul 2>&1

REM Configure app privacy settings for trusted devices
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessTrustedDevices" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessTrustedDevices_UserInControlOfTheseApps" /t REG_MULTI_SZ /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessTrustedDevices_ForceAllowTheseApps" /t REG_MULTI_SZ /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessTrustedDevices_ForceDenyTheseApps" /t REG_MULTI_SZ /f >nul 2>&1

REM Configure app privacy settings for syncing with devices
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsSyncWithDevices" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsSyncWithDevices_UserInControlOfTheseApps" /t REG_MULTI_SZ /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsSyncWithDevices_ForceAllowTheseApps" /t REG_MULTI_SZ /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsSyncWithDevices_ForceDenyTheseApps" /t REG_MULTI_SZ /f >nul 2>&1

REM Deny access to webcam
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam" /v "Value" /d "Deny" /t REG_SZ /f >nul 2>&1

REM Deny camera access for specific device
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{E5323777-F976-4f5b-9B55-B94699C46E44}" /t REG_SZ /v "Value" /d "Deny" /f >nul 2>&1

REM Configure app privacy settings for camera
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessCamera" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessCamera_UserInControlOfTheseApps" /t REG_MULTI_SZ /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessCamera_ForceAllowTheseApps" /t REG_MULTI_SZ /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessCamera_ForceDenyTheseApps" /t REG_MULTI_SZ /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{2EEF81BE-33FA-4800-9670-1CD474972C3F}" /v "Value" /t REG_SZ /d "Deny" /f >nul 2>&1

REM Deny access for all loosely coupled devices
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\LooselyCoupled" /t REG_SZ /v "Value" /d "Deny" /f >nul 2>&1

REM Deny app diagnostics consent
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics" /v "Value" /d "Deny" /t REG_SZ /f >nul 2>&1

REM Configure app privacy settings for diagnostic info
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsGetDiagnosticInfo" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsGetDiagnosticInfo_UserInControlOfTheseApps" /t REG_MULTI_SZ /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsGetDiagnosticInfo_ForceAllowTheseApps" /t REG_MULTI_SZ /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsGetDiagnosticInfo_ForceDenyTheseApps" /t REG_MULTI_SZ /f >nul 2>&1

REM Deny access to contacts
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\contacts" /v "Value" /d "Deny" /t REG_SZ /f >nul 2>&1

REM Deny contacts access for specific device
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{7D7E8402-7C54-4821-A34E-AEEFD62DED93}" /t REG_SZ /v "Value" /d "Deny" /f >nul 2>&1

REM Configure app privacy settings for contacts
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessContacts" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessContacts_UserInControlOfTheseApps" /t REG_MULTI_SZ /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessContacts_ForceAllowTheseApps" /t REG_MULTI_SZ /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessContacts_ForceDenyTheseApps" /t REG_MULTI_SZ /f >nul 2>&1

REM Deny user notification listener access
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userNotificationListener" /v "Value" /d "Deny" /t REG_SZ /f >nul 2>&1

REM Deny device access for specific device
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{52079E78-A92B-413F-B213-E8FE35712E72}" /t REG_SZ /v "Value" /d "Deny" /f >nul 2>&1

REM Configure app privacy settings for notifications
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessNotifications" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessNotifications_UserInControlOfTheseApps" /t REG_MULTI_SZ /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessNotifications_ForceAllowTheseApps" /t REG_MULTI_SZ /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessNotifications_ForceDenyTheseApps" /t REG_MULTI_SZ /f >nul 2>&1

REM Deny appointments access
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appointments" /v "Value" /d "Deny" /t REG_SZ /f >nul 2>&1

REM Deny appointments access for specific device
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{D89823BA-7180-4B81-B50C-7E471E6121A3}" /t REG_SZ /v "Value" /d "Deny" /f >nul 2>&1

REM Configure app privacy settings for calendar
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessCalendar" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessCalendar_UserInControlOfTheseApps" /t REG_MULTI_SZ /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessCalendar_ForceAllowTheseApps" /t REG_MULTI_SZ /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessCalendar_ForceDenyTheseApps" /t REG_MULTI_SZ /f >nul 2>&1

REM Deny phone call history access
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCallHistory" /v "Value" /d "Deny" /t REG_SZ /f >nul 2>&1

REM Deny phone call history access for specific device
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{8BC668CF-7728-45BD-93F8-CF2B3B41D7AB}" /t REG_SZ /v "Value" /d "Deny" /f >nul 2>&1

REM Configure app privacy settings for call history
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessCallHistory" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessCallHistory_UserInControlOfTheseApps" /t REG_MULTI_SZ /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessCallHistory_ForceAllowTheseApps" /t REG_MULTI_SZ /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessCallHistory_ForceDenyTheseApps" /t REG_MULTI_SZ /f >nul 2>&1

REM Deny email access
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\email" /v "Value" /d "Deny" /t REG_SZ /f >nul 2>&1

REM Deny email access for specific device
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{9231CB4C-BF57-4AF3-8C55-FDA7BFCC04C5}" /t REG_SZ /v "Value" /d DENY /f >nul 2>&1

REM Configure app privacy settings for email
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessEmail" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessEmail_UserInControlOfTheseApps" /t REG_MULTI_SZ /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessEmail_ForceAllowTheseApps" /t REG_MULTI_SZ /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessEmail_ForceDenyTheseApps" /t REG_MULTI_SZ /f >nul 2>&1

REM Deny user data tasks access
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userDataTasks" /v "Value" /d "Deny" /t REG_SZ /f >nul 2>&1

REM Configure app privacy settings for tasks
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessTasks" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessTasks_UserInControlOfTheseApps" /t REG_MULTI_SZ /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessTasks_ForceAllowTheseApps" /t REG_MULTI_SZ /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessTasks_ForceDenyTheseApps" /t REG_MULTI_SZ /f >nul 2>&1

REM Deny chat access
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\chat" /v "Value" /d "Deny" /t REG_SZ /f >nul 2>&1

REM Deny chat access for specific devices
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{992AFA70-6F47-4148-B3E9-3003349C1548}" /t REG_SZ /v "Value" /d "Deny" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{21157C1F-2651-4CC1-90CA-1F28B02263F6}" /t REG_SZ /v "Value" /d "Deny" /f >nul 2>&1

REM Configure app privacy settings for messaging
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessMessaging" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessMessaging_UserInControlOfTheseApps" /t REG_MULTI_SZ /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessMessaging_ForceAllowTheseApps" /t REG_MULTI_SZ /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessMessaging_ForceDenyTheseApps" /t REG_MULTI_SZ /f >nul 2>&1

REM Deny radios access
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\radios" /v "Value" /d "Deny" /t REG_SZ /f >nul 2>&1

REM Deny radios access for specific device
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{A8804298-2D5F-42E3-9531-9C8C39EB29CE}" /t REG_SZ /v "Value" /d DENY /f >nul 2>&1

REM Configure app privacy settings for radios
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessRadios" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessRadios_UserInControlOfTheseApps" /t REG_MULTI_SZ /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessRadios_ForceAllowTheseApps" /t REG_MULTI_SZ /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessRadios_ForceDenyTheseApps" /t REG_MULTI_SZ /f >nul 2>&1

REM Deny Bluetooth synchronization
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\bluetoothSync" /v "Value" /d "Deny" /t REG_SZ /f >nul 2>&1

REM Deny library access: documents, pictures, videos
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\documentsLibrary" /v "Value" /d "Deny" /t REG_SZ /f >nul 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\picturesLibrary" /v "Value" /d "Deny" /t REG_SZ /f >nul 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\videosLibrary" /v "Value" /d "Deny" /t REG_SZ /f >nul 2>&1

REM Deny broad file system access
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\broadFileSystemAccess" /v "Value" /d "Deny" /t REG_SZ /f >nul 2>&1

REM Disable voice activation
reg add "HKCU\Software\Microsoft\Speech_OneCore\Settings\VoiceActivation\UserPreferenceForAllApps" /v "AgentActivationEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsActivateWithVoice" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Speech_OneCore\Settings\VoiceActivation\UserPreferenceForAllApps" /v "AgentActivationOnLockScreenEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsActivateWithVoiceAboveLock" /t REG_DWORD /d 2 /f >nul 2>&1

REM Disable location and sensors
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableWindowsLocationProvider" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocationScripting" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocation" /d "1" /t REG_DWORD /f >nul 2>&1

REM Deny specific sensor access
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v "SensorPermissionState" /d "0" /t REG_DWORD /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v "Value" /t REG_SZ /d "Deny" /f >nul 2>&1

REM Configure Windows Search settings
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowSearchToUseLocation" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWeb" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\Experience\AllowCortana" /v "value" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCloudSearch" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortanaAboveLock" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "CortanaConsent" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "CanCortanaBeEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "CortanaEnabled" /t REG_DWORD /d 0 /f  >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "CortanaEnabled" /t REG_DWORD /d 0 /f  >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowCortanaButton" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "CortanaInAmbientMode" /t REG_DWORD /d 0 /f >nul 2>&1

REM Disable search history
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "HistoryViewEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "DeviceHistoryEnabled" /t REG_DWORD /d 0 /f >nul 2>&1

REM Disable voice activation above lock screen
reg add "HKCU\Software\Microsoft\Speech_OneCore\Preferences" /v "VoiceActivationOn" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\Software\Microsoft\Speech_OneCore\Preferences" /v "VoiceActivationDefaultOn" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "VoiceShortcut" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Speech_OneCore\Preferences" /v "VoiceActivationEnableAboveLockscreen" /t REG_DWORD /d 0 /f >nul 2>&1

REM Disable Model Donwload For Speech Recognition
reg add "HKCU\Software\Microsoft\Speech_OneCore\Preferences" /v "ModelDownloadAllowed" /t REG_DWORD /d 0 /f >nul 2>&1

REM Disable Voice During Out of Box Experience (OOBE)
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v "DisableVoice" /t REG_DWORD /d 1 /f >nul 2>&1

REM Disable indexing of encrypted stores or items
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowIndexingEncryptedStoresOrItems" /t REG_DWORD /d 0 /f >nul 2>&1

REM Disable automatic language detection for Windows Search
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AlwaysUseAutoLangDetection" /t REG_DWORD /d 0 /f >nul 2>&1

REM Disable personalized ads and ad tracking
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d "0" /f  >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v "DisabledByGroupPolicy" /t REG_DWORD /d "1" /f >nul 2>&1

REM Disable Windows content delivery for specific IDs
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338393Enabled" /d "0" /t REG_DWORD /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353694Enabled" /d "0" /t REG_DWORD /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353696Enabled" /d "0" /t REG_DWORD /f >nul 2>&1

REM Disable Windows Spotlight and cloud content
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableSoftLanding" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsSpotlightFeatures" /t "REG_DWORD" /d "1" /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t "REG_DWORD" /d "1" /f >nul 2>&1

REM Disable biometric features and credential provider
reg add "HKLM\SOFTWARE\Policies\Microsoft\Biometrics" /v "Enabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Biometrics\Credential Provider" /v "Enabled" /t "REG_DWORD" /d "0" /f >nul 2>&1

REM Disable Windows Biometric Service
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceName = 'WbioSrvc'; Write-Host "^""Disabling service: `"^""$serviceName`"^""."^""; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue; if(!$service) {; Write-Host "^""Service `"^""$serviceName`"^"" could not be not found, no need to disable it."^""; Exit 0; }; <# -- 2. Stop if running #>; if ($service.Status -eq [System.ServiceProcess.ServiceControllerStatus]::Running) {; Write-Host "^""`"^""$serviceName`"^"" is running, stopping it."^""; try {; Stop-Service -Name "^""$serviceName"^"" -Force -ErrorAction Stop; Write-Host "^""Stopped `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Warning "^""Could not stop `"^""$serviceName`"^"", it will be stopped after reboot: $_"^""; }; } else {; Write-Host "^""`"^""$serviceName`"^"" is not running, no need to stop."^""; }; <# -- 3. Skip if already disabled #>; $startupType = $service.StartType <# Does not work before .NET 4.6.1 #>; if(!$startupType) {; $startupType = (Get-WmiObject -Query "^""Select StartMode From Win32_Service Where Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; if(!$startupType) {; $startupType = (Get-WmiObject -Class Win32_Service -Property StartMode -Filter "^""Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; }; }; if($startupType -eq 'Disabled') {; Write-Host "^""$serviceName is already disabled, no further action is needed"^""; }; <# -- 4. Disable service #>; try {; Set-Service -Name "^""$serviceName"^"" -StartupType Disabled -Confirm:$false -ErrorAction Stop; Write-Host "^""Disabled `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Error "^""Could not disable `"^""$serviceName`"^"": $_"^""; }" >nul 2>&1

REM Disable Windows Insider Service
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceName = 'wisvc'; Write-Host "^""Disabling service: `"^""$serviceName`"^""."^""; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue; if(!$service) {; Write-Host "^""Service `"^""$serviceName`"^"" could not be not found, no need to disable it."^""; Exit 0; }; <# -- 2. Stop if running #>; if ($service.Status -eq [System.ServiceProcess.ServiceControllerStatus]::Running) {; Write-Host "^""`"^""$serviceName`"^"" is running, stopping it."^""; try {; Stop-Service -Name "^""$serviceName"^"" -Force -ErrorAction Stop; Write-Host "^""Stopped `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Warning "^""Could not stop `"^""$serviceName`"^"", it will be stopped after reboot: $_"^""; }; } else {; Write-Host "^""`"^""$serviceName`"^"" is not running, no need to stop."^""; }; <# -- 3. Skip if already disabled #>; $startupType = $service.StartType <# Does not work before .NET 4.6.1 #>; if(!$startupType) {; $startupType = (Get-WmiObject -Query "^""Select StartMode From Win32_Service Where Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; if(!$startupType) {; $startupType = (Get-WmiObject -Class Win32_Service -Property StartMode -Filter "^""Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; }; }; if($startupType -eq 'Disabled') {; Write-Host "^""$serviceName is already disabled, no further action is needed"^""; }; <# -- 4. Disable service #>; try {; Set-Service -Name "^""$serviceName"^"" -StartupType Disabled -Confirm:$false -ErrorAction Stop; Write-Host "^""Disabled `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Error "^""Could not disable `"^""$serviceName`"^"": $_"^""; }" >nul 2>&1

REM Disable Windows Insider Preview Builds Experimentation
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\PreviewBuilds" /v "EnableExperimentation" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\PreviewBuilds" /v "EnableConfigFlighting" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\System\AllowExperimentation" /v "value" /t "REG_DWORD" /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\PreviewBuilds" /v "AllowBuildPreview" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\WindowsSelfHost\UI\Visibility" /v "HideInsiderPage" /t "REG_DWORD" /d "1" /f >nul 2>&1

REM Disable Windows Sync Settings
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableSettingSync" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableSettingSyncUserOverride" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableSyncOnPaidNetwork" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync" /v "SyncPolicy" /t REG_DWORD /d 5 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableApplicationSettingSync" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableApplicationSettingSyncUserOverride" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableAppSyncSettingSync" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableAppSyncSettingSyncUserOverride" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableCredentialsSettingSync" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableCredentialsSettingSyncUserOverride" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Credentials" /v "Enabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableDesktopThemeSettingSync" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableDesktopThemeSettingSyncUserOverride" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisablePersonalizationSettingSync" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisablePersonalizationSettingSyncUserOverride" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableStartLayoutSettingSync" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableStartLayoutSettingSyncUserOverride" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableWebBrowserSettingSync" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableWebBrowserSettingSyncUserOverride" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableWindowsSettingSync" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableWindowsSettingSyncUserOverride" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Language" /t REG_DWORD /v "Enabled" /d 0 /f >nul 2>&1

REM Disable Online Speech Recognition
reg add "HKCU\Software\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy" /v "HasAccepted" /t "REG_DWORD" /d 0 /f >nul 2>&1

REM Disable Network Connectivity Status Indicator (NCSI) Active Probing
reg add "HKLM\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters\Internet" /v "EnableActiveProbing" /t REG_DWORD /d "0" /f >nul 2>&1

REM Disable System Initiated User Feedback (SIUF)
reg add "HKCU\SOFTWARE\Microsoft\Personalization\Settings" /v "AcceptedPrivacyPolicy" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t REG_DWORD /d 0 /f  >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v "PeriodInNanoSeconds" /f >nul 2>&1


REM Disable Windows Feedback Notifications
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "DoNotShowFeedbackNotifications" /t REG_DWORD /d 1 /f  >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "DoNotShowFeedbackNotifications" /t REG_DWORD /d 1 /f >nul 2>&1

REM Disable Input Personalization
reg add "HKCU\Software\Policies\Microsoft\InputPersonalization" /v "RestrictImplicitInkCollection" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" /v "RestrictImplicitInkCollection" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Policies\Microsoft\InputPersonalization" /v "RestrictImplicitTextCollection" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" /v "RestrictImplicitTextCollection" /t REG_DWORD /d 1 /f >nul 2>&1

REM Disable Handwriting Error Reporting
reg add "HKCU\Software\Policies\Microsoft\Windows\HandwritingErrorReports" /v "PreventHandwritingErrorReports" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows\HandwritingErrorReports" /v "PreventHandwritingErrorReports" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Policies\Microsoft\Windows\TabletPC" /v "PreventHandwritingDataSharing" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\TabletPC" /v "PreventHandwritingDataSharing" /t REG_DWORD /d 1 /f >nul 2>&1

REM Disable Input Personalization
reg add "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" /v "AllowInputPersonalization" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" /v "HarvestContacts" /t REG_DWORD /d 0 /f >nul 2>&1

REM Disable Location and Sensors
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableSensors" /t REG_DWORD /d "1" /f >nul 2>&1

REM Disable Recently Used Programs in Start Menu
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackProgs" /d 0 /t REG_DWORD /f >nul 2>&1

REM Disable Application Compatibility Telemetry
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableInventory" /t REG_DWORD /d 1 /f >nul 2>&1

REM Disable Browser Language Detection
reg add "HKCU\Control Panel\International\User Profile" /v "HttpAcceptLanguageOptOut" /t REG_DWORD /d 1 /f >nul 2>&1

REM Disable Untriggered Network Traffic for Maps
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Maps" /v "AllowUntriggeredNetworkTrafficOnSettingsPage" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Maps" /v "AutoDownloadAndUpdateMapData" /t REG_DWORD /d 0 /f >nul 2>&1

REM Disable User Account Recognition (UAR) and Game DVR
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableUAR" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 0 /f  >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d 0 /f >nul 2>&1

REM Disable Windows Media Digital Rights Management (WMDRM)
reg add "HKLM\SOFTWARE\Policies\Microsoft\WMDRM" /v "DisableOnline" /t REG_DWORD /d 1 /f >nul 2>&1

REM Disable Text Input Processor Capitalization
reg add "HKLM\SOFTWARE\Microsoft\Input\TIPC" /v "Enabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Input\TIPC" /v "Enabled" /t REG_DWORD /d 0 /f >nul 2>&1

REM Disable Windows Activity Feed
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableActivityFeed" /d "0" /t REG_DWORD /f >nul 2>&1
set "file=C:\Vitality\Info\datacol"
if not exist "%file%" (
    echo Vitality > "%file%"
    set /a "ran_optimizations+=1"
)
cd C:\Vitality
set "formatted_optimizations=%ran_optimizations%"
if %formatted_optimizations% LSS 10 set "formatted_optimizations= %formatted_optimizations%"
echo set "ran_optimizations=%ran_optimizations%"> v.bat


:skippingdatacol










if "%SecurityImp%"=="false" goto skippingsecurityimp
echo                                                 Applying Security Improvements
REM Disable SMBv1 Protoco
dism /online /Disable-Feature /FeatureName:"SMB1Protocol" /NoRestart >nul 2>&1
dism /Online /Disable-Feature /FeatureName:"SMB1Protocol-Client" /NoRestart >nul 2>&1
dism /Online /Disable-Feature /FeatureName:"SMB1Protocol-Server" /NoRestart >nul 2>&1

REM Disable PowerShell v2
dism /online /Disable-Feature /FeatureName:"MicrosoftWindowsPowerShellV2Root" /NoRestart >nul 2>&1
dism /online /Disable-Feature /FeatureName:"MicrosoftWindowsPowerShellV2" /NoRestart >nul 2>&1

REM Configure SCHANNEL Registry Settings
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\KeyExchangeAlgorithms\Diffie-Hellman" /f /v ServerMinKeyBitLength /t REG_DWORD /d 0x00001000 >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\KeyExchangeAlgorithms\Diffie-Hellman" /f /v ClientMinKeyBitLength /t REG_DWORD /d 0x00001000 >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\KeyExchangeAlgorithms\Diffie-Hellman" /f /v Enabled /t REG_DWORD /d 0x00000001 >nul 2>&1

REM Disable Weak Ciphers
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC2 40/128" /f /v Enabled /t REG_DWORD /d 0x00000000 >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC2 56/128" /f /v Enabled /t REG_DWORD /d 0x00000000 >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC2 128/128" /f /v Enabled /t REG_DWORD /d 0x00000000 >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 128/128" /f /v Enabled /t REG_DWORD /d 0x00000000 >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 64/128" /f /v Enabled /t REG_DWORD /d 0x00000000 >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 56/128" /f /v Enabled /t REG_DWORD /d 0x00000000 >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 40/128" /f /v Enabled /t REG_DWORD /d 0x00000000 >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\DES 56" /f /v Enabled /t REG_DWORD /d 0x00000000 >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\DES 56/56" /f /v Enabled /t REG_DWORD /d 0x00000000 >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\Triple DES 168" /f /v Enabled /t REG_DWORD /d 0x00000000 >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\Triple DES 168/168" /f /v Enabled /t REG_DWORD /d 0x00000000    >nul 2>&1    

REM Disable Weak Hashes
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Hashes\MD5" /f /v Enabled /t REG_DWORD /d 0x00000000 >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Hashes\SHA" /f /v Enabled /t REG_DWORD /d 0x00000000 >nul 2>&1

REM Disable NULL Cipher
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\NULL" /f /v Enabled /t REG_DWORD /d 0x00000000 >nul 2>&1

REM Configure SCHANNEL Protocol Settings
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL" /f /v AllowInsecureRenegoClients /t REG_DWORD /d 0x00000000 >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL" /f /v AllowInsecureRenegoServers /t REG_DWORD /d 0x00000000 >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL" /f /v DisableRenegoOnServer /t REG_DWORD /d 0x00000001 >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL" /f /v UseScsvForTls /t REG_DWORD /d 0x00000001 >nul 2>&1

REM Disable DTLS Protocols
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\DTLS 1.0\Server" /f /v Enabled /t REG_DWORD /d 0x00000000 >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\DTLS 1.0\Server" /f /v DisabledByDefault /t REG_DWORD /d 0x00000001 >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\DTLS 1.0\Client" /f /v Enabled /t REG_DWORD /d 0x00000000 >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\DTLS 1.0\Client" /f /v DisabledByDefault /t REG_DWORD /d 0x00000001 >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\DTLS 1.1\Server" /f /v Enabled /t REG_DWORD /d 0x00000000 >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\DTLS 1.1\Server" /f /v DisabledByDefault /t REG_DWORD /d 0x00000001 >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\DTLS 1.1\Client" /f /v Enabled /t REG_DWORD /d 0x00000000 >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\DTLS 1.1\Client" /f /v DisabledByDefault /t REG_DWORD /d 0x00000001 >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\DTLS 1.3\Server" /f /v Enabled /t REG_DWORD /d 0x00000001 >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\DTLS 1.3\Server" /f /v DisabledByDefault /t REG_DWORD /d 0x00000000 >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\DTLS 1.3\Client" /f /v Enabled /t REG_DWORD /d 0x00000001 >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\DTLS 1.3\Client" /f /v DisabledByDefault /t REG_DWORD /d 0x00000000 >nul 2>&1

REM Disable TLS 1.0 and 1.1 Protocols
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server" /f /v Enabled /t REG_DWORD /d 0x00000000 >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server" /f /v DisabledByDefault /t REG_DWORD /d 0x00000001 >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client" /f /v Enabled /t REG_DWORD /d 0x00000000 >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client" /f /v DisabledByDefault /t REG_DWORD /d 0x00000001 >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server" /f /v Enabled /t REG_DWORD /d 0x00000000 >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server" /f /v DisabledByDefault /t REG_DWORD /d 0x00000001 >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client" /f /v Enabled /t REG_DWORD /d 0x00000000 >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client" /f /v DisabledByDefault /t REG_DWORD /d 0x00000001 >nul 2>&1

REM Enable Strong Crypto for .NET Framework
reg add "HKLM\SOFTWARE\Microsoft\.NETFramework\v2.0.50727" /f /v SchUseStrongCrypto /t REG_DWORD /d 0x00000001 >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\.NETFramework\v2.0.50727" /f /v SystemDefaultTlsVersions /t REG_DWORD /d 0x00000001 >nul 2>&1
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\.NETFramework\v2.0.50727" /f /v SchUseStrongCrypto /t REG_DWORD /d 0x00000001 >nul 2>&1
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\.NETFramework\v2.0.50727" /f /v SystemDefaultTlsVersions /t REG_DWORD /d 0x00000001 >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\.NETFramework\v3.0" /f /v SchUseStrongCrypto /t REG_DWORD /d 0x00000001 >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\.NETFramework\v3.0" /f /v SystemDefaultTlsVersions /t REG_DWORD /d 0x00000001 >nul 2>&1
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\.NETFramework\v3.0" /f /v SchUseStrongCrypto /t REG_DWORD /d 0x00000001 >nul 2>&1
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\.NETFramework\v3.0" /f /v SystemDefaultTlsVersions /t REG_DWORD /d 0x00000001 >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\.NETFramework\v4.0.30319" /f /v SchUseStrongCrypto /t REG_DWORD /d 0x00000001 >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\.NETFramework\v4.0.30319" /f /v SystemDefaultTlsVersions /t REG_DWORD /d 0x00000001 >nul 2>&1
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\.NETFramework\v4.0.30319" /f /v SchUseStrongCrypto /t REG_DWORD /d 0x00000001 >nul 2>&1
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\.NETFramework\v4.0.30319" /f /v SystemDefaultTlsVersions /t REG_DWORD /d 0x00000001 >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\.NETFramework\v2.0.50727" /f /v SchUseStrongCrypto /t REG_DWORD /d 0x00000001 >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\.NETFramework\v2.0.50727" /f /v SystemDefaultTlsVersions /t REG_DWORD /d 0x00000001 >nul 2>&1
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\.NETFramework\v2.0.50727" /f /v SchUseStrongCrypto /t REG_DWORD /d 0x00000001 >nul 2>&1
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\.NETFramework\v2.0.50727" /f /v SystemDefaultTlsVersions /t REG_DWORD /d 0x00000001 >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\.NETFramework\v3.0" /f /v SchUseStrongCrypto /t REG_DWORD /d 0x00000001 >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\.NETFramework\v3.0" /f /v SystemDefaultTlsVersions /t REG_DWORD /d 0x00000001 >nul 2>&1
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\.NETFramework\v3.0" /f /v SchUseStrongCrypto /t REG_DWORD /d 0x00000001 >nul 2>&1
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\.NETFramework\v3.0" /f /v SystemDefaultTlsVersions /t REG_DWORD /d 0x00000001 >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\.NETFramework\v4.0.30319" /f /v SchUseStrongCrypto /t REG_DWORD /d 0x00000001 >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\.NETFramework\v4.0.30319" /f /v SystemDefaultTlsVersions /t REG_DWORD /d 0x00000001 >nul 2>&1
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\.NETFramework\v4.0.30319" /f /v SchUseStrongCrypto /t REG_DWORD /d 0x00000001 >nul 2>&1
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\.NETFramework\v4.0.30319" /f /v SystemDefaultTlsVersions /t REG_DWORD /d 0x00000001 >nul 2>&1

REM Disable SSL 2.0 Protocol
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Server" /f /v Enabled /t REG_DWORD /d 0x00000000 >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Server" /f /v DisabledByDefault /t REG_DWORD /d 0x00000001 >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Client" /f /v Enabled /t REG_DWORD /d 0x00000000 >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Client" /f /v DisabledByDefault /t REG_DWORD /d 0x00000001 >nul 2>&1

REM Disable SSL 3.0 Protocol
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Server" /f /v Enabled /t REG_DWORD /d 0x00000000 >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Server" /f /v DisabledByDefault /t REG_DWORD /d 0x00000001 >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Client" /f /v Enabled /t REG_DWORD /d 0x00000000 >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Client" /f /v DisabledByDefault /t REG_DWORD /d 0x00000001 >nul 2>&1

REM Disable LanmanServer AutoShareWks
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "AutoShareWks" /t REG_DWORD /d 0 /f >nul 2>&1

REM Disable Data Execution Prevention in Explorer
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "NoDataExecutionPrevention" /t REG_DWORD /d 0 /f >nul 2>&1

REM Disable Hypervisor Debugging in System
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "DisableHHDEP" /t REG_DWORD /d 0 /f >nul 2>&1

REM Disable Remote Assistance
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v "fAllowToGetHelp" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v "fAllowFullControl" /t REG_DWORD /d 0 /f >nul 2>&1

REM Disable Lock Screen Camera
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization" /v "NoLockScreenCamera" /t REG_DWORD /d 1 /f >nul 2>&1

REM Disable LM Hash Storage
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v "NoLMHash" /t REG_DWORD /d 1 /f >nul 2>&1

REM Disable AlwaysInstallElevated
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Installer" /v "AlwaysInstallElevated" /t REG_DWORD /d 0 /f >nul 2>&1

REM Disable Basic Authentication in WinRM
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WinRM\Client" /v "AllowBasic" /t REG_DWORD /d 0 /f >nul 2>&1

REM Restrict Anonymous Access
reg add "HKLM\SYSTEM\CurrentControlSet\Control\LSA" /v "RestrictAnonymous" /t REG_DWORD /d 1 /f >nul 2>&1

REM Set LMCompatibilityLevel
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v "LmCompatibilityLevel" /t REG_DWORD /d 5 /f >nul 2>&1

REM Disable Exception Chain Validation
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "DisableExceptionChainValidation" /t REG_DWORD /d 0 /f >nul 2>&1

REM Restrict Anonymous SAM Connections
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "RestrictAnonymousSAM" /t REG_DWORD /d 1 /f >nul 2>&1

REM Restrict Null Session Access
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanManServer\Parameters" /v "RestrictNullSessAccess" /t REG_DWORD /d 1 /f >nul 2>&1

REM Disable WCN UI
reg add "HKLM\Software\Policies\Microsoft\Windows\WCN\UI" /v "DisableWcnUi" /t REG_DWORD /d 1 /f >nul 2>&1

REM Disable WCN Registrars
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WCN\Registrars" /v "DisableFlashConfigRegistrar" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WCN\Registrars" /v "DisableInBand802DOT11Registrar" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WCN\Registrars" /v "DisableUPnPRegistrar" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WCN\Registrars" /v "DisableWPDRegistrar" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WCN\Registrars" /v "EnableRegistrars" /t REG_DWORD /d 0 /f >nul 2>&1
set "file=C:\Vitality\Info\securityimpr"
if not exist "%file%" (
    echo Vitality > "%file%"
    set /a "ran_optimizations+=1"
)
cd C:\Vitality
set "formatted_optimizations=%ran_optimizations%"
if %formatted_optimizations% LSS 10 set "formatted_optimizations= %formatted_optimizations%"
echo set "ran_optimizations=%ran_optimizations%"> v.bat

:skippingsecurityimp

if "%ConfigurePro%"=="false" goto skippingconfigurepro
echo                                                Applying Programs Configuration

REM Disable Visual Studio Telemetry
reg add "HKCU\Software\Microsoft\VisualStudio\Telemetry" /v "TurnOffSwitch" /t REG_DWORD /d 1 /f >nul 2>&1

REM Disable Visual Studio Feedback
reg add "HKLM\SOFTWARE\Policies\Microsoft\VisualStudio\Feedback" /v "DisableFeedbackDialog" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\VisualStudio\Feedback" /v "DisableEmailInput" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\VisualStudio\Feedback" /v "DisableScreenshotCapture" /t REG_DWORD /d 1 /f >nul 2>&1

REM Disable NVIDIA Telemetry
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceName = 'VSStandardCollectorService150'; Write-Host "^""Disabling service: `"^""$serviceName`"^""."^""; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue; if(!$service) {; Write-Host "^""Service `"^""$serviceName`"^"" could not be not found, no need to disable it."^""; Exit 0; }; <# -- 2. Stop if running #>; if ($service.Status -eq [System.ServiceProcess.ServiceControllerStatus]::Running) {; Write-Host "^""`"^""$serviceName`"^"" is running, stopping it."^""; try {; Stop-Service -Name "^""$serviceName"^"" -Force -ErrorAction Stop; Write-Host "^""Stopped `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Warning "^""Could not stop `"^""$serviceName`"^"", it will be stopped after reboot: $_"^""; }; } else {; Write-Host "^""`"^""$serviceName`"^"" is not running, no need to stop."^""; }; <# -- 3. Skip if already disabled #>; $startupType = $service.StartType <# Does not work before .NET 4.6.1 #>; if(!$startupType) {; $startupType = (Get-WmiObject -Query "^""Select StartMode From Win32_Service Where Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; if(!$startupType) {; $startupType = (Get-WmiObject -Class Win32_Service -Property StartMode -Filter "^""Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; }; }; if($startupType -eq 'Disabled') {; Write-Host "^""$serviceName is already disabled, no further action is needed"^""; }; <# -- 4. Disable service #>; try {; Set-Service -Name "^""$serviceName"^"" -StartupType Disabled -Confirm:$false -ErrorAction Stop; Write-Host "^""Disabled `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Error "^""Could not disable `"^""$serviceName`"^"": $_"^""; }" >nul 2>&1
if %PROCESSOR_ARCHITECTURE%==x86 ( 
    reg add "HKLM\SOFTWARE\Microsoft\VSCommon\14.0\SQM" /v "OptIn" /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\VSCommon\15.0\SQM" /v "OptIn" /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\VSCommon\16.0\SQM" /v "OptIn" /t REG_DWORD /d 0 /f >nul 2>&1
) else (
    reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\VSCommon\14.0\SQM" /v "OptIn" /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\VSCommon\15.0\SQM" /v "OptIn" /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\VSCommon\16.0\SQM" /v "OptIn" /t REG_DWORD /d 0 /f >nul 2>&1
) >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\VisualStudio\SQM" /v "OptIn" /t REG_DWORD /d 0 /f >nul 2>&1
if exist "%ProgramFiles%\NVIDIA Corporation\Installer2\InstallerCore\NVI2.DLL" (
    rundll32 "%PROGRAMFILES%\NVIDIA Corporation\Installer2\InstallerCore\NVI2.DLL",UninstallPackage NvTelemetryContainer >nul 2>&1
    rundll32 "%PROGRAMFILES%\NVIDIA Corporation\Installer2\InstallerCore\NVI2.DLL",UninstallPackage NvTelemetry >nul 2>&1
) >nul 2>&1
del /s %SystemRoot%\System32\DriverStore\FileRepository\NvTelemetry*.dll  >nul 2>&1
rmdir /s /q "%ProgramFiles(x86)%\NVIDIA Corporation\NvTelemetry"  >nul 2>&1
rmdir /s /q "%ProgramFiles%\NVIDIA Corporation\NvTelemetry"  >nul 2>&1
reg add "HKLM\SOFTWARE\NVIDIA Corporation\NvControlPanel2\Client" /v "OptInOrOutPreference" /t REG_DWORD /d 0 /f  >nul 2>&1

REM Disable Office Telemetry and Logging
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID44231" /t REG_DWORD /d 0 /f  >nul 2>&1
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID64640" /t REG_DWORD /d 0 /f  >nul 2>&1
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID66610" /t REG_DWORD /d 0 /f  >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\Startup" /v "SendTelemetryData" /t REG_DWORD /d 0 /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceName = 'NvTelemetryContainer'; Write-Host "^""Disabling service: `"^""$serviceName`"^""."^""; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue; if(!$service) {; Write-Host "^""Service `"^""$serviceName`"^"" could not be not found, no need to disable it."^""; Exit 0; }; <# -- 2. Stop if running #>; if ($service.Status -eq [System.ServiceProcess.ServiceControllerStatus]::Running) {; Write-Host "^""`"^""$serviceName`"^"" is running, stopping it."^""; try {; Stop-Service -Name "^""$serviceName"^"" -Force -ErrorAction Stop; Write-Host "^""Stopped `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Warning "^""Could not stop `"^""$serviceName`"^"", it will be stopped after reboot: $_"^""; }; } else {; Write-Host "^""`"^""$serviceName`"^"" is not running, no need to stop."^""; }; <# -- 3. Skip if already disabled #>; $startupType = $service.StartType <# Does not work before .NET 4.6.1 #>; if(!$startupType) {; $startupType = (Get-WmiObject -Query "^""Select StartMode From Win32_Service Where Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; if(!$startupType) {; $startupType = (Get-WmiObject -Class Win32_Service -Property StartMode -Filter "^""Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; }; }; if($startupType -eq 'Disabled') {; Write-Host "^""$serviceName is already disabled, no further action is needed"^""; }; <# -- 4. Disable service #>; try {; Set-Service -Name "^""$serviceName"^"" -StartupType Disabled -Confirm:$false -ErrorAction Stop; Write-Host "^""Disabled `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Error "^""Could not disable `"^""$serviceName`"^"": $_"^""; }" >nul 2>&1
schtasks /change /TN NvTmMon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8} /DISABLE >nul 2>&1
schtasks /change /TN NvTmRep_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8} /DISABLE >nul 2>&1
schtasks /change /TN NvTmRepOnLogon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8} /DISABLE >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Office\15.0\Outlook\Options\Mail" /v "EnableLogging" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\Outlook\Options\Mail" /v "EnableLogging" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Office\15.0\Outlook\Options\Calendar" /v "EnableCalendarLogging" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\Outlook\Options\Calendar" /v "EnableCalendarLogging" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Office\15.0\Word\Options" /v "EnableLogging" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\Word\Options" /v "EnableLogging" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Policies\Microsoft\Office\15.0\OSM" /v "EnableLogging" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Policies\Microsoft\Office\16.0\OSM" /v "EnableLogging" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Policies\Microsoft\Office\15.0\OSM" /v "EnableUpload" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Policies\Microsoft\Office\16.0\OSM" /v "EnableUpload" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Office\Common\ClientTelemetry" /v "DisableTelemetry" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\Common\ClientTelemetry" /v "DisableTelemetry" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Office\Common\ClientTelemetry" /v "VerboseLogging" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\Common\ClientTelemetry" /v "VerboseLogging" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Office\15.0\Common" /v "QMEnable" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\Common" /v "QMEnable" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Office\15.0\Common\Feedback" /v "Enabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\Common\Feedback" /v "Enabled" /t REG_DWORD /d 0 /f >nul 2>&1
schtasks /change /TN "Microsoft\Office\OfficeTelemetryAgentFallBack" /DISABLE >nul 2>&1
schtasks /change /TN "Microsoft\Office\OfficeTelemetryAgentFallBack2016" /DISABLE >nul 2>&1
schtasks /change /TN "Microsoft\Office\OfficeTelemetryAgentLogOn" /DISABLE >nul 2>&1
schtasks /change /TN "Microsoft\Office\OfficeTelemetryAgentLogOn2016" /DISABLE >nul 2>&1
schtasks /change /TN "Microsoft\Office\Office 15 Subscription Heartbeat" /DISABLE >nul 2>&1
schtasks /change /TN "Microsoft\Office\Office 16 Subscription Heartbeat" /DISABLE >nul 2>&1

REM Configure Microsoft Edge and Internet Explorer Privacy
reg add "HKCU\Software\Policies\Microsoft\MicrosoftEdge\Main" /v "PreventLiveTileDataCollection" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Policies\Microsoft\Windows\EdgeUI" /v "DisableMFUTracking" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Policies\Microsoft\Windows\EdgeUI" /v "DisableRecentApps" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Policies\Microsoft\Windows\EdgeUI" /v "TurnOffBackstack" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\MicrosoftEdge\SearchScopes" /v "ShowSearchSuggestionsGlobal" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "MetricsReportingEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "SendSiteInfoToImproveServices" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\EdgeUpdate" /v "DoNotUpdateToEdgeWithChromium" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Policies\Microsoft\Internet Explorer\Geolocation" /v "PolicyDisableGeolocation" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Internet Explorer\Safety\PrivacIE" /v "DisableLogging" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Internet Explorer\SQM" /v "DisableCustomerImprovementProgram" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings" /v "CallLegacyWCMPolicies" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings" /v "EnableSSL3Fallback" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings" /v "PreventIgnoreCertErrors" /t REG_DWORD /d 1 /f >nul 2>&1

REM Deny specific permissions to the SwReporter folder in Google Chrome user data.
icacls "%localappdata%\Google\Chrome\User Data\SwReporter" /inheritance:r /deny "*S-1-1-0:(OI)(CI)(F)" "*S-1-5-7:(OI)(CI)(F)" >nul 2>&1

REM Remove access to the SwReporter folder for the current user.
cacls "%localappdata%\Google\Chrome\User Data\SwReporter" /e /c /d %username% >nul 2>&1

REM Configure Windows Explorer policy to disallow running applications.
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "DisallowRun" /t REG_DWORD /d 1 /f >nul 2>&1

REM Add a specific application to the disallowed list.
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun" /v "1" /t REG_SZ /d "software_reporter_tool.exe" /f >nul 2>&1

REM Disable various Google Chrome metrics and reporting settings.
reg add "HKLM\SOFTWARE\Policies\Google\Chrome" /v "MetricsReportingEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome" /v "ChromeCleanupReportingEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome" /v "ChromeCleanupEnabled" /t REG_DWORD /d 0 /f >nul 2>&1

REM Disable telemetry and default browser agent in Mozilla Firefox.
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox" /v "DisableTelemetry" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox" /v "DisableDefaultBrowserAgent" /t REG_DWORD /d 1 /f >nul 2>&1

REM Disable scheduled tasks related to Firefox default browser agent.
schtasks.exe /change /disable /tn "\Mozilla\Firefox Default Browser Agent 308046B0AF4A39CB" >nul 2>&1
schtasks.exe /change /disable /tn "\Mozilla\Firefox Default Browser Agent D2CEEC440E2074BD" >nul 2>&1

REM Disable Windows Media Player usage tracking and metadata retrieval.
reg add "HKCU\SOFTWARE\Microsoft\MediaPlayer\Preferences" /v "UsageTracking" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Policies\Microsoft\WindowsMediaPlayer" /v "PreventCDDVDMetadataRetrieval" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Policies\Microsoft\WindowsMediaPlayer" /v "PreventMusicFileMetadataRetrieval" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Policies\Microsoft\WindowsMediaPlayer" /v "PreventRadioPresetsRetrieval" /t REG_DWORD /d 1 /f >nul 2>&1

REM Disable Windows Media DRM online features.
reg add "HKLM\SOFTWARE\Policies\Microsoft\WMDRM" /v "DisableOnline" /t REG_DWORD /d 1 /f >nul 2>&1

REM Disable Windows Media Player Network Sharing Service.
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceName = 'WMPNetworkSvc'; Write-Host "^""Disabling service: `"^""$serviceName`"^""."^""; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue; if(!$service) {; Write-Host "^""Service `"^""$serviceName`"^"" could not be not found, no need to disable it."^""; Exit 0; }; <# -- 2. Stop if running #>; if ($service.Status -eq [System.ServiceProcess.ServiceControllerStatus]::Running) {; Write-Host "^""`"^""$serviceName`"^"" is running, stopping it."^""; try {; Stop-Service -Name "^""$serviceName"^"" -Force -ErrorAction Stop; Write-Host "^""Stopped `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Warning "^""Could not stop `"^""$serviceName`"^"", it will be stopped after reboot: $_"^""; }; } else {; Write-Host "^""`"^""$serviceName`"^"" is not running, no need to stop."^""; }; <# -- 3. Skip if already disabled #>; $startupType = $service.StartType <# Does not work before .NET 4.6.1 #>; if(!$startupType) {; $startupType = (Get-WmiObject -Query "^""Select StartMode From Win32_Service Where Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; if(!$startupType) {; $startupType = (Get-WmiObject -Class Win32_Service -Property StartMode -Filter "^""Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; }; }; if($startupType -eq 'Disabled') {; Write-Host "^""$serviceName is already disabled, no further action is needed"^""; }; <# -- 4. Disable service #>; try {; Set-Service -Name "^""$serviceName"^"" -StartupType Disabled -Confirm:$false -ErrorAction Stop; Write-Host "^""Disabled `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Error "^""Could not disable `"^""$serviceName`"^"": $_"^""; }" >nul 2>&1

REM Disable scheduled tasks related to Google Update.
schtasks /change /disable /tn "GoogleUpdateTaskMachineCore" >nul 2>&1
schtasks /change /disable /tn "GoogleUpdateTaskMachineUA" >nul 2>&1

REM Disable Google Update services using PowerShell
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceName = 'gupdate'; Write-Host "^""Disabling service: `"^""$serviceName`"^""."^""; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue; if(!$service) {; Write-Host "^""Service `"^""$serviceName`"^"" could not be not found, no need to disable it."^""; Exit 0; }; <# -- 2. Stop if running #>; if ($service.Status -eq [System.ServiceProcess.ServiceControllerStatus]::Running) {; Write-Host "^""`"^""$serviceName`"^"" is running, stopping it."^""; try {; Stop-Service -Name "^""$serviceName"^"" -Force -ErrorAction Stop; Write-Host "^""Stopped `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Warning "^""Could not stop `"^""$serviceName`"^"", it will be stopped after reboot: $_"^""; }; } else {; Write-Host "^""`"^""$serviceName`"^"" is not running, no need to stop."^""; }; <# -- 3. Skip if already disabled #>; $startupType = $service.StartType <# Does not work before .NET 4.6.1 #>; if(!$startupType) {; $startupType = (Get-WmiObject -Query "^""Select StartMode From Win32_Service Where Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; if(!$startupType) {; $startupType = (Get-WmiObject -Class Win32_Service -Property StartMode -Filter "^""Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; }; }; if($startupType -eq 'Disabled') {; Write-Host "^""$serviceName is already disabled, no further action is needed"^""; }; <# -- 4. Disable service #>; try {; Set-Service -Name "^""$serviceName"^"" -StartupType Disabled -Confirm:$false -ErrorAction Stop; Write-Host "^""Disabled `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Error "^""Could not disable `"^""$serviceName`"^"": $_"^""; }" >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceName = 'gupdatem'; Write-Host "^""Disabling service: `"^""$serviceName`"^""."^""; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue; if(!$service) {; Write-Host "^""Service `"^""$serviceName`"^"" could not be not found, no need to disable it."^""; Exit 0; }; <# -- 2. Stop if running #>; if ($service.Status -eq [System.ServiceProcess.ServiceControllerStatus]::Running) {; Write-Host "^""`"^""$serviceName`"^"" is running, stopping it."^""; try {; Stop-Service -Name "^""$serviceName"^"" -Force -ErrorAction Stop; Write-Host "^""Stopped `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Warning "^""Could not stop `"^""$serviceName`"^"", it will be stopped after reboot: $_"^""; }; } else {; Write-Host "^""`"^""$serviceName`"^"" is not running, no need to stop."^""; }; <# -- 3. Skip if already disabled #>; $startupType = $service.StartType <# Does not work before .NET 4.6.1 #>; if(!$startupType) {; $startupType = (Get-WmiObject -Query "^""Select StartMode From Win32_Service Where Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; if(!$startupType) {; $startupType = (Get-WmiObject -Class Win32_Service -Property StartMode -Filter "^""Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; }; }; if($startupType -eq 'Disabled') {; Write-Host "^""$serviceName is already disabled, no further action is needed"^""; }; <# -- 4. Disable service #>; try {; Set-Service -Name "^""$serviceName"^"" -StartupType Disabled -Confirm:$false -ErrorAction Stop; Write-Host "^""Disabled `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Error "^""Could not disable `"^""$serviceName`"^"": $_"^""; }" >nul 2>&1

REM Disable Adobe-related services using PowerShell.
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceName = 'AdobeARMservice'; Write-Host "^""Disabling service: `"^""$serviceName`"^""."^""; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue; if(!$service) {; Write-Host "^""Service `"^""$serviceName`"^"" could not be not found, no need to disable it."^""; Exit 0; }; <# -- 2. Stop if running #>; if ($service.Status -eq [System.ServiceProcess.ServiceControllerStatus]::Running) {; Write-Host "^""`"^""$serviceName`"^"" is running, stopping it."^""; try {; Stop-Service -Name "^""$serviceName"^"" -Force -ErrorAction Stop; Write-Host "^""Stopped `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Warning "^""Could not stop `"^""$serviceName`"^"", it will be stopped after reboot: $_"^""; }; } else {; Write-Host "^""`"^""$serviceName`"^"" is not running, no need to stop."^""; }; <# -- 3. Skip if already disabled #>; $startupType = $service.StartType <# Does not work before .NET 4.6.1 #>; if(!$startupType) {; $startupType = (Get-WmiObject -Query "^""Select StartMode From Win32_Service Where Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; if(!$startupType) {; $startupType = (Get-WmiObject -Class Win32_Service -Property StartMode -Filter "^""Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; }; }; if($startupType -eq 'Disabled') {; Write-Host "^""$serviceName is already disabled, no further action is needed"^""; }; <# -- 4. Disable service #>; try {; Set-Service -Name "^""$serviceName"^"" -StartupType Disabled -Confirm:$false -ErrorAction Stop; Write-Host "^""Disabled `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Error "^""Could not disable `"^""$serviceName`"^"": $_"^""; }" >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceName = 'adobeupdateservice'; Write-Host "^""Disabling service: `"^""$serviceName`"^""."^""; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue; if(!$service) {; Write-Host "^""Service `"^""$serviceName`"^"" could not be not found, no need to disable it."^""; Exit 0; }; <# -- 2. Stop if running #>; if ($service.Status -eq [System.ServiceProcess.ServiceControllerStatus]::Running) {; Write-Host "^""`"^""$serviceName`"^"" is running, stopping it."^""; try {; Stop-Service -Name "^""$serviceName"^"" -Force -ErrorAction Stop; Write-Host "^""Stopped `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Warning "^""Could not stop `"^""$serviceName`"^"", it will be stopped after reboot: $_"^""; }; } else {; Write-Host "^""`"^""$serviceName`"^"" is not running, no need to stop."^""; }; <# -- 3. Skip if already disabled #>; $startupType = $service.StartType <# Does not work before .NET 4.6.1 #>; if(!$startupType) {; $startupType = (Get-WmiObject -Query "^""Select StartMode From Win32_Service Where Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; if(!$startupType) {; $startupType = (Get-WmiObject -Class Win32_Service -Property StartMode -Filter "^""Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; }; }; if($startupType -eq 'Disabled') {; Write-Host "^""$serviceName is already disabled, no further action is needed"^""; }; <# -- 4. Disable service #>; try {; Set-Service -Name "^""$serviceName"^"" -StartupType Disabled -Confirm:$false -ErrorAction Stop; Write-Host "^""Disabled `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Error "^""Could not disable `"^""$serviceName`"^"": $_"^""; }" >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceName = 'adobeflashplayerupdatesvc'; Write-Host "^""Disabling service: `"^""$serviceName`"^""."^""; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue; if(!$service) {; Write-Host "^""Service `"^""$serviceName`"^"" could not be not found, no need to disable it."^""; Exit 0; }; <# -- 2. Stop if running #>; if ($service.Status -eq [System.ServiceProcess.ServiceControllerStatus]::Running) {; Write-Host "^""`"^""$serviceName`"^"" is running, stopping it."^""; try {; Stop-Service -Name "^""$serviceName"^"" -Force -ErrorAction Stop; Write-Host "^""Stopped `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Warning "^""Could not stop `"^""$serviceName`"^"", it will be stopped after reboot: $_"^""; }; } else {; Write-Host "^""`"^""$serviceName`"^"" is not running, no need to stop."^""; }; <# -- 3. Skip if already disabled #>; $startupType = $service.StartType <# Does not work before .NET 4.6.1 #>; if(!$startupType) {; $startupType = (Get-WmiObject -Query "^""Select StartMode From Win32_Service Where Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; if(!$startupType) {; $startupType = (Get-WmiObject -Class Win32_Service -Property StartMode -Filter "^""Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; }; }; if($startupType -eq 'Disabled') {; Write-Host "^""$serviceName is already disabled, no further action is needed"^""; }; <# -- 4. Disable service #>; try {; Set-Service -Name "^""$serviceName"^"" -StartupType Disabled -Confirm:$false -ErrorAction Stop; Write-Host "^""Disabled `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Error "^""Could not disable `"^""$serviceName`"^"": $_"^""; }" >nul 2>&1

REM Disable scheduled tasks related to Adobe updates.
schtasks /change /tn "Adobe Acrobat Update Task" /disable >nul 2>&1
schtasks /change /tn "Adobe Flash Player Updater" /disable >nul 2>&1

REM Disable Razer Game Scanner Service.
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceName = 'Razer Game Scanner Service'; Write-Host "^""Disabling service: `"^""$serviceName`"^""."^""; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue; if(!$service) {; Write-Host "^""Service `"^""$serviceName`"^"" could not be not found, no need to disable it."^""; Exit 0; }; <# -- 2. Stop if running #>; if ($service.Status -eq [System.ServiceProcess.ServiceControllerStatus]::Running) {; Write-Host "^""`"^""$serviceName`"^"" is running, stopping it."^""; try {; Stop-Service -Name "^""$serviceName"^"" -Force -ErrorAction Stop; Write-Host "^""Stopped `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Warning "^""Could not stop `"^""$serviceName`"^"", it will be stopped after reboot: $_"^""; }; } else {; Write-Host "^""`"^""$serviceName`"^"" is not running, no need to stop."^""; }; <# -- 3. Skip if already disabled #>; $startupType = $service.StartType <# Does not work before .NET 4.6.1 #>; if(!$startupType) {; $startupType = (Get-WmiObject -Query "^""Select StartMode From Win32_Service Where Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; if(!$startupType) {; $startupType = (Get-WmiObject -Class Win32_Service -Property StartMode -Filter "^""Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; }; }; if($startupType -eq 'Disabled') {; Write-Host "^""$serviceName is already disabled, no further action is needed"^""; }; <# -- 4. Disable service #>; try {; Set-Service -Name "^""$serviceName"^"" -StartupType Disabled -Confirm:$false -ErrorAction Stop; Write-Host "^""Disabled `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Error "^""Could not disable `"^""$serviceName`"^"": $_"^""; }" >nul 2>&1

REM Disable Logitech registry service.
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceName = 'LogiRegistryService'; Write-Host "^""Disabling service: `"^""$serviceName`"^""."^""; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue; if(!$service) {; Write-Host "^""Service `"^""$serviceName`"^"" could not be not found, no need to disable it."^""; Exit 0; }; <# -- 2. Stop if running #>; if ($service.Status -eq [System.ServiceProcess.ServiceControllerStatus]::Running) {; Write-Host "^""`"^""$serviceName`"^"" is running, stopping it."^""; try {; Stop-Service -Name "^""$serviceName"^"" -Force -ErrorAction Stop; Write-Host "^""Stopped `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Warning "^""Could not stop `"^""$serviceName`"^"", it will be stopped after reboot: $_"^""; }; } else {; Write-Host "^""`"^""$serviceName`"^"" is not running, no need to stop."^""; }; <# -- 3. Skip if already disabled #>; $startupType = $service.StartType <# Does not work before .NET 4.6.1 #>; if(!$startupType) {; $startupType = (Get-WmiObject -Query "^""Select StartMode From Win32_Service Where Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; if(!$startupType) {; $startupType = (Get-WmiObject -Class Win32_Service -Property StartMode -Filter "^""Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; }; }; if($startupType -eq 'Disabled') {; Write-Host "^""$serviceName is already disabled, no further action is needed"^""; }; <# -- 4. Disable service #>; try {; Set-Service -Name "^""$serviceName"^"" -StartupType Disabled -Confirm:$false -ErrorAction Stop; Write-Host "^""Disabled `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Error "^""Could not disable `"^""$serviceName`"^"": $_"^""; }" >nul 2>&1

REM Disable Dropbox update tasks.
schtasks /Change /DISABLE /TN "DropboxUpdateTaskMachineCore" >nul 2>&1
schtasks /Change /DISABLE /TN "DropboxUpdateTaskMachineUA"  >nul 2>&1

REM Disable CCleaner monitoring and update features.
reg add "HKCU\Software\Piriform\CCleaner" /v "Monitoring" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Piriform\CCleaner" /v "HelpImproveCCleaner" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Piriform\CCleaner" /v "SystemMonitoring" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Piriform\CCleaner" /v "UpdateAuto" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Piriform\CCleaner" /v "UpdateCheck" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Piriform\CCleaner" /v "CheckTrialOffer" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\Software\Piriform\CCleaner" /v "(Cfg)HealthCheck" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\Software\Piriform\CCleaner" /v "(Cfg)QuickClean" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\Software\Piriform\CCleaner" /v "(Cfg)QuickCleanIpm" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\Software\Piriform\CCleaner" /v "(Cfg)GetIpmForTrial" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\Software\Piriform\CCleaner" /v "(Cfg)SoftwareUpdater" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\Software\Piriform\CCleaner" /v "(Cfg)SoftwareUpdaterIpm" /t REG_DWORD /d 0 /f >nul 2>&1
set "file=C:\Vitality\Info\configprograms"
if not exist "%file%" (
    echo Vitality > "%file%"
    set /a "ran_optimizations+=1"
)
cd C:\Vitality
set "formatted_optimizations=%ran_optimizations%"
if %formatted_optimizations% LSS 10 set "formatted_optimizations= %formatted_optimizations%"
echo set "ran_optimizations=%ran_optimizations%"> v.bat

:skippingconfigurepro

if "%PrivacyOverSec%"=="false" goto skippingprivacyoversec
echo                                                Applying Privacy Over Security
REM Disable Windows Firewall
PowerShell -ExecutionPolicy Unrestricted -Command "if(!(Get-Command 'netsh' -ErrorAction Ignore)) {; throw '"^""netsh"^"" does not exist, is system installed correctly?'; }; $message=netsh advfirewall set allprofiles state off 2>&1; if($?) {; Write-Host "^""Successfully disabled firewall."^""; } else {; if($message -like '*Firewall service*') {; Write-Warning 'Cannot use CLI because MpsSvc or MpsDrv is not running. Try to enable them (revert) -> reboot -> re-run this?'; } else {; throw "^""Cannot disable: $message"^""; }; }" >nul 2>&1

REM Disable Windows Firewall using registry settings for different profiles.
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\StandardProfile" /v "EnableFirewall" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile" /v "EnableFirewall" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\PrivateProfile" /v "EnableFirewall" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\DomainProfile" /v "EnableFirewall" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\StandardProfile" /v "EnableFirewall" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\DomainProfile" /v "EnableFirewall" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\PublicProfile" /v "EnableFirewall" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\PrivateProfile" /v "EnableFirewall" /t REG_DWORD /d 0 /f >nul 2>&1

REM Disable specific Windows Defender settings using PowerShell.
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'PUAProtection'; $value = '0'; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -PUAProtection $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1

REM Disable additional Windows Defender settings using registry entries.
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\MpEngine" /v "MpEnablePus" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender" /v "PUAProtection" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\MpEngine" /v "EnableFileHashComputation" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender" /v "ServiceKeepAlive" /t REG_DWORD /d "1" /f >nul 2>&1

REM Disable Windows Defender Exploit Guard Network Protection and Controlled Folder Access.
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'DisableAutoExclusions'; $value = $True; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -DisableAutoExclusions $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Exclusions" /v "DisableAutoExclusions" /t reg_DWORD /d "1" /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'DisableBlockAtFirstSeen'; $value = $True; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -DisableBlockAtFirstSeen $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\SpyNet" /v "DisableBlockAtFirstSeen" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\MpEngine" /v "MpBafsExtendedTimeout" /t REG_DWORD /d 50 /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\MpEngine" /v "MpCloudBlockLevel" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates" /v "SignatureDisableNotification" /t REG_DWORD /d 0 /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'MAPSReporting'; $value = '0'; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -MAPSReporting $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v "SpynetReporting" /t REG_DWORD /d "0" /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'SubmitSamplesConsent'; $value = '2'; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -SubmitSamplesConsent $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v "SubmitSamplesConsent" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\MRT" /v "DontReportInfectionInformation" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates" /v "RealtimeSignatureDelivery" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\Network Protection" /v "EnableNetworkProtection" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\Controlled Folder Access" /v "EnableControlledFolderAccess" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\NIS" /v "DisableProtocolRecognition" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\NIS\Consumers\IPS" /v "DisableSignatureRetirement" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\NIS\Consumers\IPS" /v "ThrottleDetectionEventsRate" /t REG_DWORD /d "10000000" /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'DisableRealtimeMonitoring'; $value = $True; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -DisableRealtimeMonitoring $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRealtimeMonitoring" /t REG_DWORD /d "1" /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'DisableIntrusionPreventionSystem'; $value = $True; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -DisableIntrusionPreventionSystem $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableIntrusionPreventionSystem" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableInformationProtectionControl" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableScanOnRealtimeEnable" /t REG_DWORD /d "1" /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'DisableBehaviorMonitoring'; $value = $True; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -DisableBehaviorMonitoring $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableBehaviorMonitoring" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRawWriteNotification" /t REG_DWORD /d "1" /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'DisableIOAVProtection'; $value = $True; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -DisableIOAVProtection $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableIOAVProtection" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "IOAVMaxSize" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableOnAccessProtection" /t REG_DWORD /d "1" /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'RealTimeScanDirection'; $value = '1'; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -RealTimeScanDirection $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "RealTimeScanDirection" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender" /v "DisableRoutinelyTakingAction" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Remediation" /v "Scan_ScheduleDay" /t REG_DWORD /d "8" /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'RemediationScheduleDay'; $value = '8'; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -RemediationScheduleDay $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'UnknownThreatDefaultAction'; $value = '9'; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -UnknownThreatDefaultAction $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Threats" /v "Threats_ThreatSeverityDefaultAction" /t "REG_DWORD" /d "1" /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Threats\ThreatSeverityDefaultAction" /v "5" /t "REG_SZ" /d "9" /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Threats\ThreatSeverityDefaultAction" /v "4" /t "REG_SZ" /d "9" /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Threats\ThreatSeverityDefaultAction" /v "3" /t "REG_SZ" /d "9" /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Threats\ThreatSeverityDefaultAction" /v "2" /t "REG_SZ" /d "9" /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Threats\ThreatSeverityDefaultAction" /v "1" /t "REG_SZ" /d "9" /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'QuarantinePurgeItemsAfterDelay'; $value = '1'; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -QuarantinePurgeItemsAfterDelay $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Quarantine" /v "PurgeItemsAfterDelay" /t REG_DWORD /d "1" /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'CheckForSignaturesBeforeRunningScan'; $value = $False; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -CheckForSignaturesBeforeRunningScan $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Scan" /v "CheckForSignaturesBeforeRunningScan" /t REG_DWORD /d "0" /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'DisableRestorePoint'; $value = $True; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -DisableRestorePoint $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Scan" /v "DisableRestorePoint" /t REG_DWORD /d "1" /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'ScanPurgeItemsAfterDelay'; $value = '1'; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -ScanPurgeItemsAfterDelay $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Scan" /v "PurgeItemsAfterDelay" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Scan" /v "MissedScheduledScanCountBeforeCatchup" /t REG_DWORD /d "20" /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'DisableCatchupFullScan'; $value = $True; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -DisableCatchupFullScan $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Scan" /v "DisableCatchupFullScan" /t REG_DWORD /d "1" /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'DisableCatchupQuickScan'; $value = $True; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -DisableCatchupQuickScan $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Scan" /v "DisableCatchupQuickScan" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Scan" /v "DisableHeuristics" /t REG_DWORD /d "1" /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'ScanOnlyIfIdleEnabled'; $value = $True; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -ScanOnlyIfIdleEnabled $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Scan" /v "ScanOnlyIfIdle" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\MRT" /v "DontOfferThroughWUAU" /t REG_DWORD /d 1 /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'ScanAvgCPULoadFactor'; $value = '1'; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -ScanAvgCPULoadFactor $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Scan" /v "AvgCPULoadFactor" /t REG_DWORD /d "1" /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'DisableCpuThrottleOnIdleScans'; $value = $False; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -DisableCpuThrottleOnIdleScans $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Scan" /v "DisableCpuThrottleOnIdleScans" /t REG_DWORD /d "0" /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'DisableEmailScanning'; $value = $True; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -DisableEmailScanning $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Scan" /v "DisableEmailScanning" /t REG_DWORD /d "1" /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'DisableScriptScanning'; $value = $True; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -DisableScriptScanning $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Scan" /v "DisableReparsePointScanning" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Scan" /v "DisableScanningMappedNetworkDrivesForFullScan" /t REG_DWORD /d "1" /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'DisableScanningMappedNetworkDrivesForFullScan'; $value = $True; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -DisableScanningMappedNetworkDrivesForFullScan $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Scan" /v "DisableScanningNetworkFiles" /t REG_DWORD /d "1" /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'DisableScanningNetworkFiles'; $value = $True; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -DisableScanningNetworkFiles $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Scan" /v "DisablePackedExeScanning" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Scan" /v "DisableRemovableDriveScanning" /t REG_DWORD /d "1" /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'DisableRemovableDriveScanning'; $value = $True; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -DisableRemovableDriveScanning $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Scan" /v "DisableArchiveScanning" /t REG_DWORD /d "1" /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'DisableArchiveScanning'; $value = $True; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -DisableArchiveScanning $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Scan" /v "ArchiveMaxDepth" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Scan" /v "ArchiveMaxSize" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Scan" /v "ScheduleDay" /t REG_DWORD /d "8" /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'ScanScheduleDay'; $value = '8'; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -ScanScheduleDay $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender" /v "RandomizeScheduleTaskTimes" /t REG_DWORD /d "0" /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'RandomizeScheduleTaskTimes'; $value = $False; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -RandomizeScheduleTaskTimes $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Scan" /v "ScanParameters" /t REG_DWORD /d "1" /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'ScanParameters'; $value = '1'; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -ScanParameters $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Scan" /v "QuickScanInterval" /t REG_DWORD /d "24" /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates" /v "DisableScanOnUpdate" /t REG_DWORD /d "1" /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'DisableGradualRelease'; $value = $True; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -DisableGradualRelease $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'EngineUpdatesChannel'; $value = 'Broad'; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -EngineUpdatesChannel $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'PlatformUpdatesChannel'; $value = 'Broad'; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -PlatformUpdatesChannel $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'DefinitionUpdatesChannel'; $value = 'Broad'; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -DefinitionUpdatesChannel $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates" /v "ForceUpdateFromMU" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates" /v "DisableScheduledSignatureUpdateOnBattery" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates" /v "UpdateOnStartUp" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates" /v "SignatureUpdateCatchupInterval" /t REG_DWORD /d "0" /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'SignatureUpdateCatchupInterval'; $value = '0'; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -SignatureUpdateCatchupInterval $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates" /v "ASSignatureDue" /t REG_DWORD /d 4294967295 /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates" /v "AVSignatureDue" /t REG_DWORD /d 4294967295 /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates" /v "DisableUpdateOnStartupWithoutEngine" /t REG_DWORD /d 1 /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'SignatureDisableUpdateOnStartupWithoutEngine'; $value = $True; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -SignatureDisableUpdateOnStartupWithoutEngine $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates" /v "ScheduleDay" /t REG_DWORD /d "8" /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'SignatureScheduleDay'; $value = '8'; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -SignatureScheduleDay $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates" /v "SignatureUpdateInterval" /t REG_DWORD /d 24 /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'SignatureUpdateInterval'; $value = '24'; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -SignatureUpdateInterval $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates" /v "CheckAlternateHttpLocation" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates" /v "CheckAlternateDownloadLocation" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Control\WMI\Autologger\DefenderApiLogger" /v "Start" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Control\WMI\Autologger\DefenderAuditLogger" /v "Start" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Windows Defender/Operational" /v "Enabled" /t Reg_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Windows Defender/WHC" /v "Enabled" /t Reg_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Reporting" /v "DisableGenericRePorts" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Reporting" /v "WppTracingLevel" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\AppHVSI" /v "AuditApplicationGuard" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Systray" /v "HideSystray" /t REG_DWORD /d "1" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Classes\CLSID\{09A47860-11B0-4DA5-AFA5-26D86198A780}\InprocServer32" /va /f  >nul 2>&1
reg delete "HKCR\CLSID\{09A47860-11B0-4DA5-AFA5-26D86198A780}" /v "InprocServer32" /f  >nul 2>&1
reg delete "HKCR\*\shellex\ContextMenuHandlers" /v "EPP" /f  >nul 2>&1
reg delete "HKCR\Directory\shellex\ContextMenuHandlers" /v "EPP" /f  >nul 2>&1
reg delete "HKCR\Drive\shellex\ContextMenuHandlers" /v "EPP" /f  >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "SecurityHealth" /f  >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\UX Configuration" /v "UILockdown" /t REG_DWORD /d "1" /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'DisablePrivacyMode'; $value = $True; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -DisablePrivacyMode $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Virus and threat protection" /v "UILockdown" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Virus and threat protection" /v "HideRansomwareRecovery" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Family options" /v "UILockdown" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Device performance and health" /v "UILockdown" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Account protection" /v "UILockdown" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\App and Browser protection" /v "UILockdown" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Firewall and network protection" /v "UILockdown" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Device security" /v "UILockdown" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Device security" /v "DisableClearTpmButton" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Device security" /v "HideSecureBoot" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Device security" /v "HideTPMTroubleshooting" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Device security" /v "DisableTpmFirmwareUpdateWarning" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.SecurityAndMaintenance" /v "Enabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows Defender\UX Configuration" /v "Notification_Suppress" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows Defender\UX Configuration" /v "Notification_Suppress" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\UX Configuration" /v "SuppressRebootNotification" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Notifications" /v "DisableNotifications" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows Defender Security Center\Notifications" /v "DisableNotifications" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Notifications" /v "DisableEnhancedNotifications" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows Defender Security Center\Notifications" /v "DisableEnhancedNotifications" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Reporting" /v "DisableEnhancedNotifications" /t REG_DWORD /d "1" /f >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\ExploitGuard\ExploitGuard MDM policy Refresh" /Disable  >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance" /Disable  >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Windows Defender\Windows Defender Cleanup" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Windows Defender\Windows Defender Verification" /Disable  >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /t REG_SZ /d "Off" /f >nul 2>&1
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /t REG_SZ /d "Off" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "ShellSmartScreenLevel" /t REG_SZ /d "Warn" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "SmartScreenPuaEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter" /v "EnabledV9" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter" /v "PreventOverride" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\PhishingFilter" /v "EnabledV9" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\PhishingFilter" /v "PreventOverride" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "SmartScreenEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "PreventSmartScreenPromptOverride" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\0" /v "2301" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\SmartScreen" /v "ConfigureAppInstallControl" /t REG_SZ /d "Anywhere" /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\SmartScreen" /v "ConfigureAppInstallControlEnabled" /t "REG_DWORD" /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t "REG_DWORD" /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "AUOptions" /t "REG_DWORD" /d "0" /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceName = 'UsoSvc'; Write-Host "^""Disabling service: `"^""$serviceName`"^""."^""; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue; if(!$service) {; Write-Host "^""Service `"^""$serviceName`"^"" could not be not found, no need to disable it."^""; Exit 0; }; <# -- 2. Stop if running #>; if ($service.Status -eq [System.ServiceProcess.ServiceControllerStatus]::Running) {; Write-Host "^""`"^""$serviceName`"^"" is running, stopping it."^""; try {; Stop-Service -Name "^""$serviceName"^"" -Force -ErrorAction Stop; Write-Host "^""Stopped `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Warning "^""Could not stop `"^""$serviceName`"^"", it will be stopped after reboot: $_"^""; }; } else {; Write-Host "^""`"^""$serviceName`"^"" is not running, no need to stop."^""; }; <# -- 3. Skip if already disabled #>; $startupType = $service.StartType <# Does not work before .NET 4.6.1 #>; if(!$startupType) {; $startupType = (Get-WmiObject -Query "^""Select StartMode From Win32_Service Where Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; if(!$startupType) {; $startupType = (Get-WmiObject -Class Win32_Service -Property StartMode -Filter "^""Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; }; }; if($startupType -eq 'Disabled') {; Write-Host "^""$serviceName is already disabled, no further action is needed"^""; }; <# -- 4. Disable service #>; try {; Set-Service -Name "^""$serviceName"^"" -StartupType Disabled -Confirm:$false -ErrorAction Stop; Write-Host "^""Disabled `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Error "^""Could not disable `"^""$serviceName`"^"": $_"^""; }" >nul 2>&1
set "file=C:\Vitality\Info\privacyoversec"
if not exist "%file%" (
    echo Vitality > "%file%"
    set /a "ran_optimizations+=1"
)
cd C:\Vitality
set "formatted_optimizations=%ran_optimizations%"
if %formatted_optimizations% LSS 10 set "formatted_optimizations= %formatted_optimizations%"
echo set "ran_optimizations=%ran_optimizations%"> v.bat
:skippingprivacyoversec


if "%UIForPrivacy%"=="false" goto skippinguiforprivacy
echo                                            Applying UI For Privacy

REM Disable Online Tips
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "AllowOnlineTips" /t REG_DWORD /d 0 /f >nul 2>&1

REM Disable Internet-based file associations
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoInternetOpenWith" /t REG_DWORD /d 1 /f >nul 2>&1

REM Disable online printing wizard
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoOnlinePrintsWizard" /t REG_DWORD /d 1 /f >nul 2>&1

REM Disable publishing wizard
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoPublishingWizard" /t REG_DWORD /d 1 /f >nul 2>&1

REM Disable Windows web services
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoWebServices" /t REG_DWORD /d 1 /f >nul 2>&1

REM Disable recent documents history
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoRecentDocsHistory" /t REG_DWORD /d 1 /f >nul 2>&1

REM Clear recent documents on user logout
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "ClearRecentDocsOnExit" /t REG_DWORD /d 1 /f >nul 2>&1

REM Disable tile application notifications
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "DisableLockScreenAppNotifications" /t REG_DWORD /d 1 /f >nul 2>&1

REM Disable "Open with" from Microsoft Store
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications" /v "NoTileApplicationNotification" /t REG_DWORD /d 1 /f >nul 2>&1

REM Hide recent files in Explorer
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "NoUseStoreOpenWith" /t REG_DWORD /d 1 /f >nul 2>&1

REM Delete specific folder delegate for HomeFolderDesktop
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowRecent" /d 0 /t "REG_DWORD" /f >nul 2>&1

REM Delete specific folder delegate for HomeFolderDesktop (64-bit only)
if not %PROCESSOR_ARCHITECTURE%==x86 ( REM is 64 bit?
    reg delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\HomeFolderDesktop\NameSpace\DelegateFolders\{3134ef9c-6b18-4996-ad04-ed5912e00eb5}" /f >nul 2>&1
)

REM Disable sync provider notifications
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSyncProviderNotifications" /d 0 /t REG_DWORD /f >nul 2>&1

REM Disable physical camera LED
reg add "HKLM\SOFTWARE\Microsoft\OEM\Device\Capture" /v "NoPhysicalCameraLED" /d 1 /t REG_DWORD /f >nul 2>&1
set "file=C:\Vitality\Info\uiforprivacy"
if not exist "%file%" (
    echo Vitality > "%file%"
    set /a "ran_optimizations+=1"
)
cd C:\Vitality
set "formatted_optimizations=%ran_optimizations%"
if %formatted_optimizations% LSS 10 set "formatted_optimizations= %formatted_optimizations%"
echo set "ran_optimizations=%ran_optimizations%"> v.bat
:skippinguiforprivacy





if "%Minecraft%"=="false" goto skippingminecraft
echo                                       Applying Minecraft 1.8.9 Settings
if exist "%appdata%\.minecraft\optionsof.txt-old" del "%appdata%\.minecraft\optionsof.txt-old"
if exist "%appdata%\.minecraft\optionsof.txt" (
    ren "%appdata%\.minecraft\optionsof.txt" "optionsof.txt-old"
)
echo ofFogType:3                 > "%appdata%\.minecraft\optionsof.txt"
echo ofFogStart:0.8              >> "%appdata%\.minecraft\optionsof.txt"
echo ofMipmapType:0              >> "%appdata%\.minecraft\optionsof.txt"
echo ofOcclusionFancy:false      >> "%appdata%\.minecraft\optionsof.txt"
echo ofSmoothFps:false           >> "%appdata%\.minecraft\optionsof.txt"
echo ofSmoothWorld:true          >> "%appdata%\.minecraft\optionsof.txt"
echo ofAoLevel:1.0               >> "%appdata%\.minecraft\optionsof.txt"
echo ofClouds:3                  >> "%appdata%\.minecraft\optionsof.txt"
echo ofCloudsHeight:0.0          >> "%appdata%\.minecraft\optionsof.txt"
echo ofTrees:1                   >> "%appdata%\.minecraft\optionsof.txt"
echo ofDroppedItems:1            >> "%appdata%\.minecraft\optionsof.txt"
echo ofRain:0                    >> "%appdata%\.minecraft\optionsof.txt"
echo ofAnimatedWater:0           >> "%appdata%\.minecraft\optionsof.txt"
echo ofAnimatedLava:0            >> "%appdata%\.minecraft\optionsof.txt"
echo ofAnimatedFire:true         >> "%appdata%\.minecraft\optionsof.txt"
echo ofAnimatedPortal:true       >> "%appdata%\.minecraft\optionsof.txt"
echo ofAnimatedRedstone:true     >> "%appdata%\.minecraft\optionsof.txt"
echo ofAnimatedExplosion:true    >> "%appdata%\.minecraft\optionsof.txt"
echo ofAnimatedFlame:true        >> "%appdata%\.minecraft\optionsof.txt"
echo ofAnimatedSmoke:true        >> "%appdata%\.minecraft\optionsof.txt"
echo ofVoidParticles:true        >> "%appdata%\.minecraft\optionsof.txt"
echo ofWaterParticles:true       >> "%appdata%\.minecraft\optionsof.txt"
echo ofPortalParticles:true      >> "%appdata%\.minecraft\optionsof.txt"
echo ofPotionParticles:true      >> "%appdata%\.minecraft\optionsof.txt"
echo ofFireworkParticles:true    >> "%appdata%\.minecraft\optionsof.txt"
echo ofDrippingWaterLava:true    >> "%appdata%\.minecraft\optionsof.txt"
echo ofAnimatedTerrain:true      >> "%appdata%\.minecraft\optionsof.txt"
echo ofAnimatedTextures:true     >> "%appdata%\.minecraft\optionsof.txt"
echo ofRainSplash:true           >> "%appdata%\.minecraft\optionsof.txt"
echo ofLagometer:false           >> "%appdata%\.minecraft\optionsof.txt"
echo ofShowFps:false             >> "%appdata%\.minecraft\optionsof.txt"
echo ofAutoSaveTicks:4000        >> "%appdata%\.minecraft\optionsof.txt"
echo ofBetterGrass:3             >> "%appdata%\.minecraft\optionsof.txt"
echo ofConnectedTextures:2       >> "%appdata%\.minecraft\optionsof.txt"
echo ofWeather:true              >> "%appdata%\.minecraft\optionsof.txt"
echo ofSky:false                 >> "%appdata%\.minecraft\optionsof.txt"
echo ofStars:false               >> "%appdata%\.minecraft\optionsof.txt"
echo ofSunMoon:false             >> "%appdata%\.minecraft\optionsof.txt"
echo ofVignette:1                >> "%appdata%\.minecraft\optionsof.txt"
echo ofChunkUpdates:1            >> "%appdata%\.minecraft\optionsof.txt"
echo ofChunkUpdatesDynamic:false >> "%appdata%\.minecraft\optionsof.txt"
echo ofTime:0                    >> "%appdata%\.minecraft\optionsof.txt"
echo ofClearWater:false          >> "%appdata%\.minecraft\optionsof.txt"
echo ofAaLevel:0                 >> "%appdata%\.minecraft\optionsof.txt"
echo ofAfLevel:1                 >> "%appdata%\.minecraft\optionsof.txt"
echo ofProfiler:false            >> "%appdata%\.minecraft\optionsof.txt"
echo ofBetterSnow:false          >> "%appdata%\.minecraft\optionsof.txt"
echo ofSwampColors:true          >> "%appdata%\.minecraft\optionsof.txt"
echo ofRandomEntities:true       >> "%appdata%\.minecraft\optionsof.txt"
echo ofSmoothBiomes:true         >> "%appdata%\.minecraft\optionsof.txt"
echo ofCustomFonts:true          >> "%appdata%\.minecraft\optionsof.txt"
echo ofCustomColors:true         >> "%appdata%\.minecraft\optionsof.txt"
echo ofCustomItems:true          >> "%appdata%\.minecraft\optionsof.txt"
echo ofCustomSky:true            >> "%appdata%\.minecraft\optionsof.txt"
echo ofShowCapes:true            >> "%appdata%\.minecraft\optionsof.txt"
echo ofNaturalTextures:false     >> "%appdata%\.minecraft\optionsof.txt"
echo ofEmissiveTextures:true     >> "%appdata%\.minecraft\optionsof.txt"
echo ofLazyChunkLoading:true     >> "%appdata%\.minecraft\optionsof.txt"
echo ofRenderRegions:false       >> "%appdata%\.minecraft\optionsof.txt"
echo ofSmartAnimations:false     >> "%appdata%\.minecraft\optionsof.txt"
echo ofDynamicFov:true           >> "%appdata%\.minecraft\optionsof.txt"
echo ofAlternateBlocks:true      >> "%appdata%\.minecraft\optionsof.txt"
echo ofDynamicLights:3           >> "%appdata%\.minecraft\optionsof.txt"
echo ofScreenshotSize:1          >> "%appdata%\.minecraft\optionsof.txt"
echo ofCustomEntityModels:true   >> "%appdata%\.minecraft\optionsof.txt"
echo ofCustomGuis:true           >> "%appdata%\.minecraft\optionsof.txt"
echo ofShowGlErrors:true         >> "%appdata%\.minecraft\optionsof.txt"
echo ofFullscreenMode:Default    >> "%appdata%\.minecraft\optionsof.txt"
echo ofFastMath:false            >> "%appdata%\.minecraft\optionsof.txt"
echo ofFastRender:false          >> "%appdata%\.minecraft\optionsof.txt"
echo ofTranslucentBlocks:1       >> "%appdata%\.minecraft\optionsof.txt"
echo key_of.key.zoom:46          >> "%appdata%\.minecraft\optionsof.txt"
















:skippingminecraft











:End
cls
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
echo                                             Everything was applied succesfuly
timeout /nobreak /t 3 >nul 2>&1
set "batch_file=%~f0"
goto :Restart


goto %lastpage%


:Restart
start "" "%batch_file%"
exit

