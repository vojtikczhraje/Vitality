@echo off

REM Setup Basic Things
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
REM  Check for permissions
    if "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) else (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM If error flag set, we do not have admin.
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
    goto SkipCheck
)
:: Initialize variable
set "SystemType=Unknown"

:: Run PowerShell command and assign output to SystemType
for /f %%i in ('powershell -Command "try {$enclosure = Get-WmiObject Win32_SystemEnclosure; switch ($enclosure.ChassisTypes) { 3 {'Desktop'} 9 {'Laptop'} default {'Unknown'} }} catch {'Error'}"') do (
    set "SystemType=%%i"
)





:: Save the SystemType for future use
echo %SystemType% > "%temp%\SystemType.txt"

:: Relaunch the script
set "batch_file=%~f0"
start "" "%batch_file%"
exit

:SkipCheck
if %SystemType%==Desktop set "SystemType=Desktop            "          
if %SystemType%==Laptop set "SystemType=Laptop             "




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


REM Set Number of Configuration Category Pages
set "CategoryFPS_Pages=1"
set "CategoryLatency_Pages=1"
set "CategoryGPU_Pages=1"
set "CategoryTaskSCH_Pages=1"
set "CategoryKBM_Pages=1"
set "CategoryCPU_Pages=1"
set "CategoryNetwork_Pages=1"
set "CategoryRAM_Pages=1"
set "CategoryDISK_Pages=1"
set "CategoryWindows_Pages=1"



REM Configuration Page 1 [FPS and Input]
set "Visuals=True"
set "WindowsUpdates=True"
set "WindowsDefender=True"
set "ProcessMitigations=True"
set "DebloatWindows=True"
set "FSE=True"
if %SystemType%==Desktop (
	set "PowerPlan=True"
) else (
	set "PowerPlan=False"
)


REM Configuration Page2 [Latency]
set "SpectreMeltdown=True"
if %SystemType%==Desktop (
	set "DisableIDLE=True"
) else (
	set "DisableIDLE=False"
)
set "MMCSS=True"
set "CSRSS=True"
set "LowProcessPriority=True"
set "LowAudioLatency=True"
set "TimerResolution=True"

REM Configuration Page 3 [Network]
set "DisableNaglesAlgorithm=True"
set "NIC=True"
set "DNS=True"
set "WindowsNetworkSettigns=True"
set "Autotunning=False"

REM Set GPU
    set "GameMode=True"
    set "NvidiaTelemetry=True"
    set "P0States=True"
    set "HDCP=True"
    set "Preemption=True"
    set "Logging=True"
    set "NvidiaProfileInspector=True"
    set "GameModeAMD=True"
    set "AMDOptimizedSettings=True"
    set "AMDDebloat=True"

If "!gpu1!"=="Nvidia" (
    set "GameModeAMD=False"
    set "AMDOptimizedSettings=False"
    set "AMDDebloat=False"
)

If "!gpu1!"=="AMD" (
    set "GameMode=False"
    set "NvidiaTelemetry=False"
    set "P0States=False"
    set "HDCP=False"
    set "Preemption=False"
    set "Logging=False"
    set "NvidiaProfileInspector=False"
)

If "!gpu1!"=="NaN" (
    set "GameMode=False"
    set "NvidiaTelemetry=False"
    set "P0States=False"
    set "HDCP=False"
    set "Preemption=False"
    set "Logging=False"
    set "NvidiaProfileInspector=False"
    set "GameModeAMD=False"
    set "AMDOptimizedSettings=False"
    set "AMDDebloat=False"
)

REM Configuration 6 [Disk]
set "FileSystemOptimization=True"
set "Cleaner=True"
set "Startupcleaner=True"

REM Configuration 7 [Windows Settings]
set "DisableTelemetry=True"
set "DisableHibernation=True"
set "BootOptions=True"
set "PasswordOnWakeUp=True"
set "DisableAutomaticMaintenance=True"
set "DisableLocationTracking=True"
set "ShowFileExtension=True"

REM Configuration 8/9
set "IntelCpuVirtualization=False"
set "IntelCoreIsolation=False"
set "IntelCStates=False"
set "IntelPowerThrottling=False"
set "AMDServices=False"
set "IntelTSX=False"

set "AMDCpuVirtualization=False"
set "AMDCoreIsolation=False"
set "AMDCStates=False"
set "AMDPowerThrottling=False"
set "IntelServices=False"
set "AMDTSX=False"

REM Configuration 8 [Intel CPU]
If "%cpu1%"=="Intel" (
    set "Configuration8=:ConfigurationIntel"
    set "IntelCpuVirtualization=True"
    set "IntelCoreIsolation=True"
    if %SystemType%==Desktop (
        set "IntelCStates=True"
        set "IntelPowerThrottling=True"
    ) else (
        set "IntelCStates=False"
        set "IntelPowerThrottling=False"
    )
    set "AMDServices=True"
    set "IntelTSX=True"
) else (
    REM Configuration 8 [AMD CPU]
    set "Configuration8=:ConfigurationAMD"
    set "AMDCpuVirtualization=True"
    set "AMDCoreIsolation=True"
    if %SystemType%==Desktop (
        set "AMDCStates=True"
        set "AMDPowerThrottling=True"
    ) else (
        set "AMDCStates=False"
        set "AMDPowerThrottling=False"
    )
    set "IntelServices=True"
    set "AMDTSX=True"
)

set "ConfigurationsPages=8"




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
) else (
    set welcome1=Welcome to Vitality %r%%username%%e%. Optimize your PC to %r%MAX%l%
    echo Vitality > C:\Vitality\Info\welcome1
)




for /F "tokens=* skip=1" %%n in ('WMIC path Win32_VideoController get Name ^| findstr "."') do set GPU_NAME=%%n >nul
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

REM Go to last know page after applying tweaks
if defined lastpage goto %lastpage%

:Loading
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

cd "C:\Vitality\Backup"
if not exist "%SYSTEMDRIVE%\Vitality\Backup\regbackup.reg" Regedit /e "%SYSTEMDRIVE%\Vitality\Backup\regbackup.reg" >nul 2>&1


if not exist "C:\Vitality\Backup\RestorePoint.bat" (
    echo @echo off > "%SYSTEMDRIVE%\Vitality\Backup\RestorePoint.bat"
    echo reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v "SystemRestorePointCreationFrequency" /t REG_DWORD /d 0 /f >> "C:\Vitality\Backup\RestorePoint.bat"
    echo powershell -ExecutionPolicy Unrestricted -NoProfile Enable-ComputerRestore -Drive 'C:\', 'D:\', 'E:\', 'F:\', 'G:\' >> "C:\Vitality\Backup\RestorePoint.bat"
    echo powershell -ExecutionPolicy Unrestricted -NoProfile Checkpoint-Computer -Description 'Vitality' >> "C:\Vitality\Backup\RestorePoint.bat"
    echo exit >> "%SYSTEMDRIVE%\Vitality\Backup\RestorePoint.bat"
    start /min "" "%SYSTEMDRIVE%\Vitality\Backup\RestorePoint.bat"
)


Ping www.google.nl -n 1 -w 1000 >nul
if %errorlevel% neq 0 (
echo %e%                                   No %r%Internet Connection%e%, press C to continue anyway
echo %l%                                              [ %r%C%l% ] Continue  [ %r%Q%l% ] Quit 
choice /c:"CQ" /n /m " "
if !errorlevel! equ 2 exit /b
echo.
)

if %SystemType%==Unknown (
set MenuItem=%errorlevel%
echo %e%                                   Unknown %r%System Type%e%, please select your System Type
echo %l%                                              [ %r%D%l% ] Desktop  [ %r%L%l% ] Laptop
choice /c:"DL" /n /m " "
if !errorlevel! equ 1 set "SystemType=Desktop            "
if !errorlevel! equ 2 set "SystemType=Laptop             "
echo %SystemType% > "%temp%\SystemType.txt"
echo.
)

If exist "%SYSTEMDRIVE%\Vitality\Backup\regbackup.reg" (
    set "MStatus=Enabled       "
    goto skippingbackupstatus
) else set set "MStatus=Disabled      "

If exist "%SYSTEMDRIVE%\Vitality\Backup\RestorePoint.bat" (
    set "MStatus=Enabled       "
    goto skippingbackupstatus
) else set set "MStatus=Disabled      "


:skippingbackupstatus

set "lastConfiguration=:Configuration"



REM OS informations
set "OSVersion=Unknown         "
systeminfo > temp.txt 2>nul
for /f "delims=" %%i in ('findstr /B /C:"OS Name" temp.txt') do set "OSInfo=%%i"
call :checkOS
:checkOS
if "%OSInfo%"=="OS Name:                   Microsoft Windows 8.1" set "OSVersion=Windows 8.1     "
if "%OSInfo%"=="OS Name:                   Microsoft Windows 10 Home" set "OSVersion=Windows 10      "
if "%OSInfo%"=="OS Name:                   Microsoft Windows 10 Pro" set "OSVersion=Windows 10      "
if "%OSInfo%"=="OS Name:                   Microsoft Windows 10 Enterprise" set "OSVersion=Windows 10      "
if "%OSInfo%"=="OS Name:                   Microsoft Windows 11 Home" set "OSVersion=Windows 11      "
if "%OSInfo%"=="OS Name:                   Microsoft Windows 11 Pro" set "OSVersion=Windows 11      "

REM Configuration Page 1 [FPS and Input]
set "Visuals=True"
set "WindowsUpdates=True"
set "WindowsDefender=True"
set "ProcessMitigations=True"
set "DebloatWindows=True"
set "FSE=True"
if %SystemType%==Desktop (
	set "PowerPlan=True"
) else (
	set "PowerPlan=False"
)

REM Configuration Page2 [Latency]
set "SpectreMeltdown=True"
if %SystemType%==Desktop (
	set "DisableIDLE=True"
) else (
	set "DisableIDLE=False"
)
set "MMCSS=True"
set "CSRSS=True"
set "LowProcessPriority=True"
set "LowAudioLatency=True"
set "TimerResolution=True"

REM Configuration Page 3 [Network]
set "DisableNaglesAlgorithm=True"
set "NIC=True"
set "DNS=True"
set "WindowsNetworkSettigns=True"
set "Autotunning=False"

REM Set GPU
    set "GameMode=True"
    set "NvidiaTelemetry=True"
    set "P0States=True"
    set "HDCP=True"
    set "Preemption=True"
    set "Logging=True"
    set "NvidiaProfileInspector=True"
    set "GameModeAMD=True"
    set "AMDOptimizedSettings=True"
    set "AMDDebloat=True"

If "!gpu1!"=="Nvidia" (
    set "GameModeAMD=False"
    set "AMDOptimizedSettings=False"
    set "AMDDebloat=False"
)

If "!gpu1!"=="AMD" (
    set "GameMode=False"
    set "NvidiaTelemetry=False"
    set "P0States=False"
    set "HDCP=False"
    set "Preemption=False"
    set "Logging=False"
    set "NvidiaProfileInspector=False"
)

If "!gpu1!"=="NaN" (
    set "GameMode=False"
    set "NvidiaTelemetry=False"
    set "P0States=False"
    set "HDCP=False"
    set "Preemption=False"
    set "Logging=False"
    set "NvidiaProfileInspector=False"
    set "GameModeAMD=False"
    set "AMDOptimizedSettings=False"
    set "AMDDebloat=False"
)

REM Configuration 6 [Disk]
set "FileSystemOptimization=True"
set "Cleaner=True"
set "Startupcleaner=True"

REM Configuration 7 [Windows Settings]
set "DisableTelemetry=True"
set "DisableHibernation=True"
set "BootOptions=True"
set "PasswordOnWakeUp=True"
set "DisableAutomaticMaintenance=True"
set "DisableLocationTracking=True"
set "ShowFileExtension=True"

REM Configuration 8/9
set "IntelCpuVirtualization=False"
set "IntelCoreIsolation=False"
set "IntelCStates=False"
set "IntelPowerThrottling=False"
set "AMDServices=False"
set "IntelTSX=False"

set "AMDCpuVirtualization=False"
set "AMDCoreIsolation=False"
set "AMDCStates=False"
set "AMDPowerThrottling=False"
set "IntelServices=False"
set "AMDTSX=False"

REM Configuration 8 [Intel CPU]
If "%cpu1%"=="Intel" (
    set "Configuration8=:ConfigurationIntel"
    set "IntelCpuVirtualization=True"
    set "IntelCoreIsolation=True"
    if %SystemType%==Desktop (
        set "IntelCStates=True"
        set "IntelPowerThrottling=True"
    ) else (
        set "IntelCStates=False"
        set "IntelPowerThrottling=False"
    )
    set "AMDServices=True"
    set "IntelTSX=True"
) else (
    REM Configuration 8 [AMD CPU]
    set "Configuration8=:ConfigurationAMD"
    set "AMDCpuVirtualization=True"
    set "AMDCoreIsolation=True"
    if %SystemType%==Desktop (
        set "AMDCStates=True"
        set "AMDPowerThrottling=True"
    ) else (
        set "AMDCStates=False"
        set "AMDPowerThrottling=False"
    )
    set "IntelServices=True"
    set "AMDTSX=True"
)

set "ConfigurationsPages=8"







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
echo     ^│                             ^│
echo     ^│                             ^│       ┌───────────────────────────────────────────────────────────────────┐
echo     ^│            %r%Home%l%             ^│       │ %ar%▼ %ar%Disclaimers%l%                                                     │
echo     ^│                             ^│       │                                                                   │
echo     ^│                             ^│       │ %ar%•%e% Use at Your Own Risk. %l%                                          │
echo     ^│           Tweaks            ^│       │                                                                   │
echo     ^│                             ^│       │ %ar%•%e% Not guaranteed to be compatible with all configurations. %l%       │
echo     ^│                             ^│       │                                                                   │
echo     ^│       Ingame Settings       ^│       │ %ar%•%e% Create a full system backup before applying any tweaks. %l%        │
echo     ^│                             ^│       │                                                                   │
echo     ^│                             ^│       │ %ar%•%e% Disable antivirus to avoid conflicts. %l%                          │
echo     ^│      Recording Settings     ^│       │                                                                   │
echo     ^│                             ^│       │ %ar%•%e% Understand the implications of each tweak before applying it. %l%  │
echo     ^│                             ^│       └───────────────────────────────────────────────────────────────────┘
echo     ^│           Privacy           ^│
echo     ^│                             ^│       ┌───────────────────────────────────────────────────────────────────┐
echo     ^│                             ^│       │ %r%▼ %r%Informations%l%                                                    │
echo     ^│        Configuration        ^│       │                                                                   │
echo     ^│                             ^│       │ %e%Applied Optimizations: %r%%formatted_optimizations%%l%         %e%Status of Backup: %r%%MStatus%%l%│
echo     ^│                             ^│       │                                                                   │
echo     ^│           Credits           ^│       │ %e%Operating System: %r%%OSVersion%%l%%e%System Type: %r%%SystemType%%l%│
echo     ^│                             ^│       │                                                                   │
echo     ^│                             ^│       └───────────────────────────────────────────────────────────────────┘
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


:Tweaks 
:lasttweaks1
set lastpage=:Tweaks
set lasttweaks1=true
set lasttweaks2=false


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
echo     ^│        Configuration        ^│
echo     ^│                             ^│     %e%[%r% 5 %e%]  %r%•%e%  GPU Tweaks                                  %GPUc%▼%l%
echo     ^│                             ^│             Unlock Peak GPU Performance with our tweaks
echo     ^│           Credits           ^│  
echo     ^│                             ^│          
echo     ^│                             ^│
echo     └─────────────────────────────┘                   %l%┌───────────────┐   %l%┌───────────────┐
echo                                                       %l%│   %e%Apply [%r%X%e%]%l%   │   %l%│ %e%Configure [%r%C%e%]%l% │
echo                                                       └───────────────┘   └───────────────┘
choice /c:WS012345DAXC /n /m " "                                           
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
if "%MenuItem%"=="12" goto %lastConfiguration%














:Tweaks2 
:lasttweaks2
set lastpage=:Tweaks2
set lasttweaks1=false
set lasttweaks2=true


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
echo     ^│        Configuration        ^│           
echo     ^│                             ^│             
echo     ^│                             ^│
echo     ^│           Credits           ^│           
echo     ^│                             ^│             
echo     ^│                             ^│
echo     └─────────────────────────────┘                   %l%┌───────────────┐   %l%┌───────────────┐ 
echo                                                       %l%│   %e%Apply [%r%X%e%]%l%   │   %l%│ %e%Configure [%r%C%e%]%l% │
echo                                                       └───────────────┘   └───────────────┘
choice /c:WS6789ADXC /n /m " "                                           
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
if "%MenuItem%"=="10" goto %lastConfiguration%




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
echo     %l%┌─────────────────────────────┐         %r%▲%e% Instruction: Press %r%1-2%e% and the button will turn green%l%
echo     ^│                             ^│  Everything that's %r%green%l% means that will be optimized once you press %r%X%l%
echo     ^│                             ^│   
echo     ^│            Home             ^│         
echo     ^│                             ^│     %e%[%r% 1 %e%]  %r%•%e%  Minecraft  %l%                                 %Minecraftc%▼%l% 
echo     ^│                             ^│             Currently only for 1.8.9
echo     ^│           Tweaks            ^│         
echo     ^│                             ^│     %e%[%r% 2 %e%]  %r%•%e%  Valorant  %l%                                  %Valorantc%▼%l%
echo     ^│                             ^│             Set screen resolution to your own, currently 1920x1080.
echo     ^│       %r%Ingame Settings%l%       ^│            
echo     ^│                             ^│               
echo     ^│                             ^│                       
echo     ^│      Recording Settings     ^│   
echo     ^│                             ^│ 
echo     ^│                             ^│   
echo     ^│           Privacy           ^│              
echo     ^│                             ^│     
echo     ^│                             ^│       
echo     ^│        Configuration        ^│         
echo     ^│                             ^│    
echo     ^│                             ^│
echo     ^│           Credits           ^│  
echo     ^│                             ^│    
echo     ^│                             ^│
echo     └─────────────────────────────┘                                %l%┌───────────────┐
echo                                                                    %l%│   %e%Apply [%r%X%e%]%l%   │
echo                                                                    └───────────────┘
choice /c:WSX12 /n /m " "                                           
set MenuItem=%errorlevel%
if "%MenuItem%"=="1" (
    if "%lasttweaks1%"=="true" (
        goto :lasttweaks1
    ) else (
        goto :lasttweaks2
    )
) 

if "%MenuItem%"=="2" goto RecordingSettings
if "%MenuItem%"=="3" goto TweaksProceed
if "%MenuItem%"=="4" (
    if "%Minecraft%"=="false" (
        set "Minecraft=True"
    ) else (
        set "Minecraft=false"
    )
) && goto IngameSettings

if "%MenuItem%"=="5" (
    if "%Valorant%"=="false" (
        set "Valorant=True"
    ) else (
        set "Valorant=false"
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
echo     ^│        Configuration        ^│         While these recording settings offer exceptionally low storage usage,
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
echo     ^│        Configuration        ^│         
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
if "%MenuItem%"=="2" goto %lastConfiguration%
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









:Configuration
set lastConfiguration=:Configuration


set "Visualsc="
if "%Visuals%"=="False" (
    set "Visualsc=[38;5;203m"
) else (
    set "Visualsc=[38;5;34m"
)

set "WindowsUpdatesc="
if "%WindowsUpdates%"=="False" (
    set "WindowsUpdatesc=[38;5;203m"
) else (
    set "WindowsUpdatesc=[38;5;34m"
)

set "WindowsDefenderc="
if "%WindowsDefender%"=="False" (
    set "WindowsDefenderc=[38;5;203m"
) else (
    set "WindowsDefenderc=[38;5;34m"
)

set "ProcessMitigationsc="
if "%ProcessMitigations%"=="False" (
    set "ProcessMitigationsc=[38;5;203m"
) else (
    set "ProcessMitigationsc=[38;5;34m"
)

set "DebloatWindowsc="
if "%DebloatWindows%"=="False" (
    set "DebloatWindowsc=[38;5;203m"
) else (
    set "DebloatWindowsc=[38;5;34m"
)

set "FSEc="
if "%FSE%"=="False" (
    set "FSEc=[38;5;203m"
) else (
    set "FSEc=[38;5;34m"
)

set "PowerPlanc="
if "%PowerPlan%"=="False" (
    set "PowerPlanc=[38;5;203m"
) else (
    set "PowerPlanc=[38;5;34m"
)


cls
echo.                                
echo     %l%┌─────────────────────────────┐                       
echo     │ %r%W%l% = %e%Up%l%       %r%D%l% = %e%Right%l%      │           %r% _      _  _____   __    _     _  _____  _%l%    
echo     │ %r%S%l% = %e%Down%l%     %r%A%l% = %e%Left%l%       │          %r% \ \  / ^| ^|  ^| ^|   / /\  ^| ^|   ^| ^|  ^| ^|  \ \_/%l%      %r%▲%e% Pages  [%r%1%e%/%ConfigurationsPages%]%l% %e%[%r%1%e%/%CategoryFPS_Pages%]%l%
echo     │ %r%X%l% = %e%Apply%l%                   │            %r%\_\/  ^|_^|  ^|_^|  /_/--\ ^|_^|__ ^|_^|  ^|_^|   ^|_^|%l%     
echo.    │ It's not that hard is it?   │                                                                                
echo     └─────────────────────────────┘                                                        
echo     %l%┌─────────────────────────────┐         %r%▲%e% Configuration: %r%FPS And Input Delay%l% 
echo     ^│                             ^│   Here you can configure all settings that are going to be applied
echo     ^│                             ^│
echo     ^│            Home             ^│ 
echo     ^│                             ^│     %e%[%r% 1 %e%]  %r%•%e%  Visuals%l%                                     %Visualsc%▼%l%
echo     ^│                             ^│          Optimize Windows Visuals 
echo     ^│           Tweaks            ^│      
echo     ^│                             ^│     %e%[%r% 2 %e%]  %r%•%e%  Windows Updates%l%                             %WindowsUpdatesc%▼%l%
echo     ^│                             ^│          Disables Windows Updates
echo     ^│       Ingame Settings       ^│
echo     ^│                             ^│     %e%[%r% 3 %e%]  %r%•%e%  Windows Defender%l%                            %WindowsDefenderc%▼%l%
echo     ^│                             ^│          Disables Windows Defender And Security
echo     ^│      Recording Settings     ^│
echo     ^│                             ^│     %e%[%r% 4 %e%]  %r%•%e%  Process Mitigations%l%                         %ProcessMitigationsc%▼%l%
echo     ^│                             ^│          Disables Process Mitigations
echo     ^│           Privacy           ^│
echo     ^│                             ^│     %e%[%r% 5 %e%]  %r%•%e%  Debloat Windows%l%                             %DebloatWindowsc%▼%l%
echo     ^│                             ^│         Deletes Pre-Installed Windows Apps
echo     ^│        %r%Configuration%l%        ^│ 
echo     ^│                             ^│     %e%[%r% 6 %e%]  %r%•%e%  FSE%l%                                         %FSEc%▼%l%
echo     ^│                             ^│         Disables FSO and Enables FSE
echo     ^│           Credits           ^│
echo     ^│                             ^│             
echo     ^│                             ^│         
echo     └─────────────────────────────┘           %l%┌──────────────────────┐   ┌───────────────────┐     
echo                                               %l%│ %e%Go to Tweaks Tab [%r%G%e%]%l% │   │ %e%Skip Category [%r%N%e%]%l% │
echo                                               └──────────────────────┘   └───────────────────┘
choice /c:WS1234657DA /n /m " "                                           
set MenuItem=%errorlevel%
if "%MenuItem%"=="1" goto Privacy
if "%MenuItem%"=="2" goto Credits

if "%MenuItem%"=="3" (
    if "%Visuals%"=="False" (
        set "Visuals=True"
    ) else (
        set "Visuals=False"
    )
) && goto Configuration

if "%MenuItem%"=="4" (
    if "%WindowsUpdates%"=="False" (
        set "WindowsUpdates=True"
    ) else (
        set "WindowsUpdates=False"
    )
) && goto Configuration

if "%MenuItem%"=="5" (
    if "%WindowsDefender%"=="False" (
        set "WindowsDefender=True"
    ) else (
        set "WindowsDefender=False"
    )
) && goto Configuration

if "%MenuItem%"=="6" (
    if "%ProcessMitigations%"=="False" (
        set "ProcessMitigations=True"
    ) else (
        set "ProcessMitigations=False"
    )
) && goto Configuration

if "%MenuItem%"=="8" (
    if "%DebloatWindows%"=="False" (
        set "DebloatWindows=True"
    ) else (
        set "DebloatWindows=False"
    )
) && goto Configuration

if "%MenuItem%"=="7" (
    if "%FSE%"=="False" (
        set "FSE=True"
    ) else (
        set "FSE=False"
    )
) && goto Configuration

if "%MenuItem%"=="9" (
    if "%PowerPlan%"=="False" (
        set "PowerPlan=True"
    ) else (
        set "PowerPlan=False"
    )
) && goto Configuration









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
echo     ^│                             ^│       %l%We would like to thank these people:
echo     ^│                             ^│ 
echo     ^│            Home             ^│         %r%Amitxv%l% - PC Tuning guide and AMD GPU debloating
echo     ^│                             ^│
echo     ^│                             ^│         %r%Imribiy%l% - AMD GPU tweaks
echo     ^│           Tweaks            ^│
echo     ^│                             ^│         %r%Aiden (UnLovedCookie)%l% - Performance (FPS) and CPU tweaks
echo     ^│                             ^│         
echo     ^│       Ingame Settings       ^│         %r%HoneCTRL%l% - Functionally part, aswell as the backup and recording settings
echo     ^│                             ^│         
echo     ^│                             ^│         %r%undergroundwires%l% - Privacy (privacy.sexy)
echo     ^│      Recording Settings     ^│
echo     ^│                             ^│         %r%Kars%l% - Vitality Website
echo     ^│                             ^│         
echo     ^│           Privacy           ^│         %e%sppdl%l% - Low Audio Latency tweak
echo     ^│                             ^│
echo     ^│                             ^│         %e%CatGamerOP%l% - Various Nvidia GPU d-words
echo     ^│        Configuration        ^│      
echo     ^│                             ^│         %e%Zusier%l% - Various performance (FPS) tweaks
echo     ^│                             ^│          
echo     ^│           %r%Credits%l%           ^│         %e%Melody%l% - Windows settings 
echo     ^│                             ^│
echo     ^│                             ^│         %ic%And More...%l% 
echo     └─────────────────────────────┘        
echo.
echo.
choice /c:WS /n /m " "                                           
set MenuItem=%errorlevel%
if "%MenuItem%"=="1" goto %lastConfiguration%
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
if "%Visuals%" equ "True" (
REM Configure Windows Visuals
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "VisualFXSetting" /t REG_DWORD /d "3" /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /f /v "UserPreferencesMask" /t REG_BINARY /d "9012078012000000" >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v "DragFullWindows" /t REG_SZ /d "1" /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v "FontSmoothing" /t REG_SZ /d "2" /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MinAnimate" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\DWM" /v "EnableAeroPeek" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\DWM" /v "AlwaysHibernateThumbnails" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\DWM" /v "ListviewShadow" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "IconsOnly" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ListviewAlphaSelect" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarAnimations" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ListviewShadow" /t REG_DWORD /d "0" /f >nul 2>&1
)

if "%WindowsUpdate%" equ "True" (
REM Disable Windows Update
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "WUServer" /t REG_SZ /d " " /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "WUStatusServer" /t REG_SZ /d " " /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "UpdateServiceUrlAlternate" /t REG_SZ /d " " /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DisableWindowsUpdateAccess" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "UseWUServer" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "AUOptions" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v "SearchOrderConfig" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v "PreventDeviceMetadataFromNetwork" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" /v "SearchOrderConfig" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" /v "DontSearchWindowsUpdate" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" /v "IncludeRecommendedUpdates" /t REG_DWORD /d "0" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" /v "SetupWizardLaunchTime" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" /v "AcceleratedInstallRequired" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "ExcludeWUDriversInQualityUpdate" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DoNotConnectToWindowsUpdateInternetLocations" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DisableOSUpgrade" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ExcludeWUDriversInQualityUpdate" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "SetDisableUXWUAccess" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\UsoSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
)

REM Configure Windows Services
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
net pause GpuEnergyDr  >nul 2>&1
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
sc config "GpuEnergyDr" start= disabled  >nul 2>&1
sc config "Telemetry" start= disabled  >nul 2>&1
sc config "VerifierExt" start= disabled  >nul 2>&1

REM Configure Win32 Priority Separation (26hex)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d "38" /f >nul 2>&1

REM Disable Search Indexing
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WSearch" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

If "%WindowsDefender%" equ "True" (
REM Disable Windows Defender
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Microsoft Antimalware\Real-Time Protection" /v "DisableScanOnRealtimeEnable" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Microsoft Antimalware\Real-Time Protection" /v "DisableOnAccessProtection" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableScanOnRealtimeEnable" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WinDefend" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\wscsvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SecurityHealthService" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Sense" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "SecurityHealth" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v "Enabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows Defender\Spynet" /v "SpyNetReporting" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows Defender\Spynet" /v "SubmitSamplesConsent" /t REG_DWORD /d "0" /f >nul 2>&1
)


REM Disable Fast Startup
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberbootEnabled" /t REG_DWORD /d "0" /f >nul 2>&1

REM Reserve 10% of CPU Resources For Low-Priority Tasks
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d "10" /f >nul 2>&1

REM Disable Gamebarpresencewriter
reg add "HKLM\SOFTWARE\Microsoft\WindowsRuntime\ActivatableClassId\Windows.Gaming.GameBar.PresenceServer.Internal.PresenceWriter" /v "ActivationType" /t REG_DWORD /d "0" /f >nul 2>&1

If "%ProcessMitigations%"=="Enabled" (
REM Disable Process Mitigations
    Rem Initialize Mask To Get Mask Length
    PowerShell Set-ProcessMitigation -System -Disable CFG >nul 2>&1

    REM Get Current Mask
    for /f "tokens=3 skip=2" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "MitigationAuditOptions"') do (
    set "mitigation_mask=%%a"
    ) 

    REM Set All Values In Current Mask To 2
    for /L %%a in (0,1,9) do (
    set "mitigation_mask=!mitigation_mask:%%a=2!"
    ) 

    REM Apply Mask To Kernel
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "MitigationOptions" /t REG_BINARY /d "%mitigation_mask%" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "MitigationAuditOptions" /t REG_BINARY /d "%mitigation_mask%" /f > nul 2>&1

)

If "%DebloatWindows%" equ "True" (
REM Debloat Windows
    REM Take Full Control of "C:\Program Files\WindowsApps"
    takeown /F "C:\Program Files\WindowsApps" /R /A >nul 2>&1
    icacls "C:\Program Files\WindowsApps" /grant administrators:F >nul 2>&1

    REM Take Full Control of "C:\ProgramData\Packages"
    takeown /F "C:\ProgramData\Packages" /R /A >nul 2>&1
    icacls "C:\ProgramData\Packages" /grant administrators:F >nul 2>&1

    REM Take Full Control of "C:\Users\*\AppData\Local\Microsoft\WindowsApps"
    takeown /F "C:\Users\*\AppData\Local\Microsoft\WindowsApps" /R /A >nul 2>&1
    icacls "C:\Users\*\AppData\Local\Microsoft\WindowsApps" /grant administrators:F >nul 2>&1

    REM Take Full Control of "C:\Users\*\AppData\Local\Packages""
    takeown /F "C:\Users\*\AppData\Local\Packages" /R /A >nul 2>&1
    icacls "C:\Users\*\AppData\Local\Packages" /grant administrators:F >nul 2>&1

    REM Take Full Control of "C:\Windows\SystemApps"
    takeown /F "C:\Windows\SystemApps" /R /A >nul 2>&1
    icacls "C:\Windows\SystemApps" /grant administrators:F >nul 2>&1

    REM Take Full Control of "C:\Windows\System32\smartscreen.exe"
    takeown /F "C:\Windows\System32\smartscreen.exe" >nul 2>&1
    icacls "C:\Windows\System32\smartscreen.exe" /grant administrators:F >nul 2>&1

    REM Take Full Control of "C:\Windows\System32\mobsync.exe"
    takeown /F "C:\Windows\System32\mobsync.exe" >nul 2>&1
    icacls "C:\Windows\System32\mobsync.exe" /grant administrators:F >nul 2>&1

    REM Delete files and folders
    rmdir /s /q "C:\Program Files\WindowsApps" >nul 2>&1
    rmdir /s /q "C:\ProgramData\Packages" >nul 2>&1
    rmdir /s /q "C:\Users\*\AppData\Local\Microsoft\WindowsApps" >nul 2>&1
    rmdir /s /q "C:\Users\*\AppData\Local\Packages" >nul 2>&1
    rmdir /s /q "C:\Windows\SystemApps" >nul 2>&1
    del /f /q "C:\Windows\System32\smartscreen.exe" >nul 2>&1
    del /f /q "C:\Windows\System32\mobsync.exe" >nul 2>&1

    REM Remove Some Pre-Installed Windows Apps
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
)

If "%FSE%" equ "True" (
REM Disable FSO
reg delete "HKCU\System\GameConfigStore" /v "Win32_AutoGameModeDefaultProfile" /f >nul 2>&1
reg delete "HKCU\System\GameConfigStore" /v "Win32_GameModeRelatedProcesses" /f >nul 2>&1

REM Enable FSE
reg add "HKCU\System\GameConfigStore" /v "GameDVR_DSEBehavior" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v "GameDVR_DXGIHonorFSEWindowsCompatible" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v "GameDVR_EFSEFeatureFlags" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehavior" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehaviorMode" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v "GameDVR_HonorUserFSEBehaviorMode" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v "value" /t  >nul 2>&1
)

REM Disable System Energy-Saving Techniques
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Executive" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\ModernSleep" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f >nul 2>&1

REM Set SVCSplitThreshold To User Memory Size
for /f "tokens=2 delims==" %%i in ('wmic os get TotalVisibleMemorySize /format:value') do set mem=%%i
set /a ram=%mem% + 1024000
reg add "HKLM\System\CurrentControlSet\Control" /v "SvcHostSplitThresholdInKB" /t REG_DWORD /d "%ram%" /f >nul 2>&1

REM Disable USB Power Savings
for %%a in (
	EnhancedPowerManagementEnabled
	AllowIdleIrpInD3
	EnableSelectiveSuspend
	DeviceSelectiveSuspended
	SelectiveSuspendEnabled
	SelectiveSuspendOn
	EnumerationRetryCount
	ExtPropDescSemaphore
	WaitWakeEnabled
	D3ColdSupported
	WdfDirectedPowerTransitionEnable
	EnableIdlePowerManagement
	IdleInWorkingState
) do for /f "delims=" %%b in ('reg query "HKLM\SYSTEM\CurrentControlSet\Enum" /s /f "%%a" ^| findstr "HKEY"') do reg add "%%b" /v "%%a" /t REG_DWORD /d "0" /f > NUL 2>&1

REM Enabling MSI Mode For All Suported Devices
for /f "tokens=*" %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Enum\PCI"^| findstr "HKEY"') do (
	for /f "tokens=*" %%a in ('reg query "%%i"^| findstr "HKEY"') do reg add "%%a\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties" /v "MSISupported" /t REG_DWORD /d "1" /f > NUL 2>&1
)

REM Setting All Device's Priority To Undefined
for /f "tokens=*" %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Enum\PCI"^| findstr "HKEY"') do (
	for /f "tokens=*" %%a in ('reg query "%%i"^| findstr "HKEY"') do reg delete "%%a\Device Parameters\Interrupt Management\Affinity Policy" /v "DevicePriority" /f > NUL 2>&1
)

REM Disable Background Apps
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v "GlobalUserDisabled" /t REG_DWORD /d "1" /f  >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsRunInBackground" /t REG_DWORD /d "2" /f  >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "BackgroundAppGlobalToggle" /t REG_DWORD /d "0" /f  >nul 2>&1

REM Set Winlogon to Normal Priority
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\winlogon.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "2" /f > NUL 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\winlogon.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d "2" /f > NUL 2>&1

REM Set CSRSS to High Priority
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\csrss.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "3" /f > NUL 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\csrss.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d "3" /f > NUL 2>&1

REM Delete Intel Micro Code
takeown /f "C:\Windows\System32\mcupdate_GenuineIntel.dll" /r /d y  >nul 2>&1
del "C:\Windows\System32\mcupdate_GenuineIntel.dll" /s /f /q  >nul 2>&1

REM Delete AMD Micro Code
takeown /f "C:\Windows\System32\mcupdate_AuthenticAMD.dll" /r /d y  >nul 2>&1
del "C:\Windows\System32\mcupdate_AuthenticAMD.dll" /s /f /q  >nul 2>&1

REM Enabling Hardware Accelerated GPU Scheduling
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /F /V "HwSchMode" /T REG_DWORD /d "2" >nul 2>&1

REM Disable Settings Synchronization
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableSettingSync" /t REG_DWORD /d "2" /f  >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableSettingSyncUserOverride" /t REG_DWORD /d "1" /f  >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableSyncOnPaidNetwork" /t REG_DWORD /d "1" /f >nul 2>&1

REM Disable Remote Assistance
reg add "HKLM\System\CurrentControlSet\Control\Remote Assistance" /v "fAllowFullControl" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Control\Remote Assistance" /v "fAllowToGetHelp" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Control\Remote Assistance" /v "fEnableChatControl" /t REG_DWORD /d "0" /f >nul 2>&1

If "%PowerPlan%" equ "True" (
REM Power Plan
    REM Remove And Add New "Ultimate Performance" Power Plan
    powercfg /duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb >nul 2>&1
    powercfg /setactive bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb >nul 2>&1
    powercfg /delete eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee >nul 2>&1
    powercfg /duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee >nul 2>&1
    powercfg /setactive eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee >nul 2>&1
    powercfg /delete bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb >nul 2>&1

    REM Throttle States: OFF
    powercfg -setacvalueindex scheme_current sub_processor THROTTLING 0 >nul 2>&1

    REM Device Idle Policy: Performance
    powercfg -setacvalueindex scheme_current sub_none DEVICEIDLE 0 >nul 2>&1

    REM USB 3 Link Power Management: OFF 
    powercfg -setacvalueindex scheme_current 2a737441-1930-4402-8d77-b2bebba308a3 d4e98f31-5ffe-4ce1-be31-1b38b384c009 0 >nul 2>&1

    REM USB selective suspend setting: OFF
    powercfg -setacvalueindex scheme_current 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0 >nul 2>&1

    REM Link State Power Management: OFF
    powercfg -setacvalueindex scheme_current SUB_PCIEXPRESS ASPM 0 >nul 2>&1

    REM AHCI Link Power Management - HIPM/DIPM: OFF
    powercfg -setacvalueindex scheme_current SUB_DISK 0b2d69d7-a2a1-449c-9680-f91c70521c60 0 >nul

    REM NVMe Power State Transition Latency Tolerance
    powercfg -setacvalueindex scheme_current SUB_DISK dbc9e238-6de9-49e3-92cd-8c2b4946b472 1 >nul
    powercfg -setacvalueindex scheme_current SUB_DISK fc95af4d-40e7-4b6d-835a-56d131dbc80e 1 >nul

    REM Interrupt Steering
    echo %PROCESSOR_IDENTIFIER% | find /I "Intel" >nul && powercfg -setacvalueindex scheme_current SUB_INTSTEER MODE 6 >nul

    REM Enable Hardware P-States
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\4d2b0152-7d5c-498b-88e2-34345392a2c5" /v "ValueMax" /t REG_DWORD /d "20000" /f

    REM Dont restrict core boost
    powercfg -setacvalueindex scheme_current sub_processor PERFEPP 0 >nul


    REM Enable Turbo Boost
    powercfg -setacvalueindex scheme_current sub_processor PERFBOOSTMODE 1 >nul
    powercfg -setacvalueindex scheme_current sub_processor PERFBOOSTPOL 100 >nul


    REM Disable Sleep States
    powercfg -setacvalueindex scheme_current SUB_SLEEP AWAYMODE 0 >nul
    powercfg -setacvalueindex scheme_current SUB_SLEEP ALLOWSTANDBY 0 >nul
    powercfg -setacvalueindex scheme_current SUB_SLEEP HYBRIDSLEEP 0 >nul


    REM Disable Core Parking
    echo %PROCESSOR_IDENTIFIER% | find /I "Intel" >nul && (
    call :ControlSet "Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" "ValueMax" "100"
    powercfg -setacvalueindex scheme_current sub_processor CPMINCORES 100 >nul 2>&1
    ) || (
    powercfg -setacvalueindex scheme_current SUB_INTSTEER UNPARKTIME 0
    powercfg -setacvalueindex scheme_current SUB_INTSTEER PERPROCLOAD 10000
    )


    REM Disable Frequency Scaling
    powercfg -setacvalueindex scheme_current sub_processor PROCTHROTTLEMIN 100 >nul


    REM Don't turn off display when plugged in
    powercfg /change standby-timeout-ac 0
    powercfg /change monitor-timeout-ac 0
    powercfg /change hibernate-timeout-ac 0


    REM Apply Changes
    powercfg -setactive scheme_current >nul
)

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
REM Download Timer Resolution (Credits to Amitxv)
if exist "%SYSTEMDRIVE%\SetTimerResolution.exe" del "%SYSTEMDRIVE%\SetTimerResolution.exe" >nul 2>&1
curl -g -k -L -# -o "%SYSTEMDRIVE%\SetTimerResolution.exe" "https://github.com/amitxv/TimerResolution/releases/download/SetTimerResolution-v0.1.3/SetTimerResolution.exe" >nul 2>&1
REM Set TimerResolution Variables
    set "targetPath=C:\SetTimerResolution.exe"
    set "args=--resolution 5000 --no-console"
    set "shortcutName=TimerResolutionShortcut.lnk"


if "%SpectreMeltdown%" equ "True" (
REM Disable Spectre and Meltdown
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettings" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverride" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverrideMask" /t REG_DWORD /d 3 /f >nul 2>&1
)
REM Configure BCD For Low Latency
    REM Disable Dynamic Tick
    bcdedit /set disabledynamictick yes >nul 2>&1

    REM Disable High Precision Event Timer (HPET)
    bcdedit /deletevalue useplatformclock >nul 2>&1

    REM Disable Synthetic Timers
    bcdedit /set useplatformtick yes >nul 2>&1

if "%DisableIDLE%" equ "True" (
REM ONLY FOR DESKTOP (ADD SCRIPT THAT WILL AUTOMATICALLY TELL IF USER IS USING LAPTOP OR DESKTOP)
    REM Disable Idle
    powercfg -setacvalueindex scheme_current sub_processor 5d76a2ca-e8c0-402f-a133-2158492d58ad 1 >nul 2>&1

    REM Apply The Changes
    powercfg -setactive scheme_current >nul 2>&1
)

REM Disable Network Throttling
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d "4294967295" /f >nul 2>&1

if "%MMCSS%" equ "True" (
REM Configure MMCSS
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NoLazyMode" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "AlwaysOn" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d "8" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d "6" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Latency Sensitive" /t REG_SZ /d "True" /f >nul 2>&1
)

if "%CSRSS%" equ "True" (
REM Set CSRSS to High Priority
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\csrss.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "3" /f > NUL 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\csrss.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d "3" /f > NUL 2>&1
)

if "%LowProcessPriority%" equ "True" (
REM Setting Low Process Priority To Processes That Uses Cycles
	REM Splitting Audio Services...
	copy /y "%windir%\System32\svchost.exe" "%windir%\System32\audiosvchost.exe" > NUL 2>&1
	reg add "HKLM\SYSTEM\CurrentControlSet\Services\Audiosrv" /v "ImagePath" /t REG_EXPAND_SZ /d "%SystemRoot%\System32\audiosvchost.exe -k LocalServiceNetworkRestricted -p" /f > NUL 2>&1
	reg add "HKLM\SYSTEM\CurrentControlSet\Services\AudioEndpointBuilder" /v "ImagePath" /t REG_EXPAND_SZ /d "%SystemRoot%\System32\audiosvchost.exe -k LocalSystemNetworkRestricted -p" /f > NUL 2>&1

	REM Setting Process Priority And Disabling Security Mitigations
	for %%i in (
		dwm.exe
		lsass.exe
		svchost.exe
		WmiPrvSE.exe
	) do (
		reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%%i\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f  >nul 2>&1
		reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%%i\PerfOptions" /v "IoPriority" /t REG_DWORD /d "0" /f  >nul 2>&1
	)
)

REM Setting Latency Tolerance
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DXGKrnl" /v "MonitorLatencyTolerance" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DXGKrnl" /v "MonitorRefreshLatencyTolerance" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatency" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatencyCheckEnabled" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "Latency" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceDefault" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceFSVP" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyTolerancePerfOverride" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceScreenOffIR" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceVSyncEnabled" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "RtlCapabilityCheckLatency" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyActivelyUsed" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleLongTime" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleMonitorOff" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleNoContext" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleShortTime" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleVeryLongTime" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceIdle0" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceIdle0MonitorOff" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceIdle1" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceIdle1MonitorOff" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceMemory" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceNoContext" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceNoContextMonitorOff" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceOther" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceTimerPeriod" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultMemoryRefreshLatencyToleranceActivelyUsed" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultMemoryRefreshLatencyToleranceMonitorOff" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultMemoryRefreshLatencyToleranceNoContext" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "Latency" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "MaxIAverageGraphicsLatencyInOneBucket" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "MiracastPerfTrackGraphicsLatency" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "MonitorLatencyTolerance" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "MonitorRefreshLatencyTolerance" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "TransitionLatency" /t REG_DWORD /d "1" /f >nul 2>&1

If "%LowAudioLatency%" equ "True" (
REM Downloading Low Audio Latency (Credits to sppdl)
if exist "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\low_audio_latency_no_console.exe" del "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\low_audio_latency_no_console.exe" >nul 2>&1
curl -g -k -L -# -o "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\low_audio_latency_no_console.exe" "https://github.com/spddl/LowAudioLatency/releases/download/v2.0.1/low_audio_latency_no_console.exe" >nul 2>&1
)


If "%TimerResolution%" equ "True" (
    del "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\TimerResolutionShortcut.lnk" >nul 2>&1
    cd "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup" >nul 2>&1
    set "targetPath=C:\SetTimerResolution.exe"
    set "args=--resolution 5000 --no-console"
    set "shortcutName=TimerResolutionShortcut.lnk"
    powershell -Command "$WshShell = New-Object -ComObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut('%shortcutName%'); $Shortcut.TargetPath = '%targetPath%'; $Shortcut.Arguments = '%args%'; $Shortcut.Save()" >nul 2>&1
    cd "%SYSTEMDRIVE%\Vitality" >nul 2>&1
) else (
    del "%SYSTEMDRIVE%\SetTimerResolution.exe" >nul 2>&1
)



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
if "%DisableNaglesAlgorithm%" equ "True" (
REM Disable Nagle's Algorithm
reg add "HKLM\SOFTWARE\Microsoft\MSMQ\Parameters" /v "TCPNoDelay" /t REG_DWORD /d "1" /f >nul 2>&1  
for /f "tokens=3*" %%i in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkCards" /f "ServiceName" /s ^|findstr /i /l "ServiceName"') do (
		reg add "HKLM\System\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\%%i" /v "TCPNoDelay" /t REG_DWORD /d "1" /f
		reg add "HKLM\System\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\%%i" /v "TcpAckFrequency" /t REG_DWORD /d "1" /f
		reg add "HKLM\System\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\%%i" /v "TcpDelAckTicks" /t REG_DWORD /d "0" /f
) >nul 2>&1
)

if "%NIC%" equ "True" (
REM NIC
    for /f "tokens=3*" %%a in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkCards" /k /v /f "Description" /s /e ^| findstr /ri "REG_SZ"') do (
    for /f %%g in ('reg query "HKLM\System\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}" /s /f "%%b" /d ^| findstr /C:"HKEY"') do (
    if not exist "%SYSTEMDRIVE%\Backup\(Default) %%b.reg" reg export "%%g" "%SYSTEMDRIVE%\Backup\(Default) %%b.reg" /y

    REM Disable Wake Features
    reg add "%%g" /v "*WakeOnMagicPacket" /t REG_SZ /d "0" /f
    reg add "%%g" /v "*WakeOnPattern" /t REG_SZ /d "0" /f
    reg add "%%g" /v "WakeOnLink" /t REG_SZ /d "0" /f
    reg add "%%g" /v "S5WakeOnLan" /t REG_SZ /d "0" /f
    reg add "%%g" /v "WolShutdownLinkSpeed" /t REG_SZ /d "2" /f
    reg add "%%g" /v "*ModernStandbyWoLMagicPacket	" /t REG_SZ /d "0" /f
    reg add "%%g" /v "*DeviceSleepOnDisconnect" /t REG_SZ /d "0" /f

    REM Disable Power Saving Features
    reg add "%%g" /v "*NicAutoPowerSaver" /t REG_SZ /d "0" /f
    reg add "%%g" /v "*FlowControl" /t REG_SZ /d "0" /f
    reg add "%%g" /v "*EEE" /t REG_SZ /d "0" /f
    reg add "%%g" /v "EnablePME" /t REG_SZ /d "0" /f
    reg add "%%g" /v "EEELinkAdvertisement" /t REG_SZ /d "0" /f
    reg add "%%g" /v "ReduceSpeedOnPowerDown" /t REG_SZ /d "0" /f
    reg add "%%g" /v "PowerSavingMode" /t REG_SZ /d "0" /f
    reg add "%%g" /v "EnableGreenEthernet" /t REG_SZ /d "0" /f
    reg add "%%g" /v "ULPMode" /t REG_SZ /d "0" /f
    reg add "%%g" /v "GigaLite" /t REG_SZ /d "0" /f
    reg add "%%g" /v "EnableSavePowerNow" /t REG_SZ /d "0" /f
    reg add "%%g" /v "EnablePowerManagement" /t REG_SZ /d "0" /f
    reg add "%%g" /v "EnableDynamicPowerGating" /t REG_SZ /d "0" /f
    reg add "%%g" /v "EnableConnectedPowerGating" /t REG_SZ /d "0" /f
    reg add "%%g" /v "AutoPowerSaveModeEnabled" /t REG_SZ /d "0" /f
    reg add "%%g" /v "AutoDisableGigabit" /t REG_SZ /d "0" /f
    reg add "%%g" /v "AdvancedEEE" /t REG_SZ /d "0" /f
    reg add "%%g" /v "PowerDownPll" /t REG_SZ /d "0" /f
    reg add "%%g" /v "S5NicKeepOverrideMacAddrV2" /t REG_SZ /d "0" /f
    reg add "%%g" /v "MIMOPowerSaveMode" /t REG_SZ /d "3" /f
    reg add "%%g" /v "AlternateSemaphoreDelay" /t REG_SZ /d "0" /f

    REM Disable JumboPacket
    reg add "%%g" /v "JumboPacket" /t REG_SZ /d "0" /f

    REM Interrupt Moderation Adaptive (Default)
    reg add "%%g" /v "ITR" /t REG_SZ /d "125" /f

    REM Receive/Transmit Buffers
    reg add "%%g" /v "ReceiveBuffers" /t REG_SZ /d "266" /f
    reg add "%%g" /v "TransmitBuffers" /t REG_SZ /d "266" /f

    REM Enable Throughput Booster
    reg add "%%g" /v "ThroughputBoosterEnabled" /t REG_SZ /d "1" /f

    REM PnPCapabilities
    reg add "%%g" /v "PnPCapabilities" /t REG_DWORD /d "24" /f

    REM Enable LargeSendOffloads
    reg add "%%g" /v "LsoV1IPv4" /t REG_SZ /d "1" /f
    reg add "%%g" /v "LsoV2IPv4" /t REG_SZ /d "1" /f
    reg add "%%g" /v "LsoV2IPv6" /t REG_SZ /d "1" /f

    ::Enable Offloads
    reg add "%%g" /v "TCPUDPChecksumOffloadIPv4" /t REG_SZ /d "3" /f
    reg add "%%g" /v "TCPUDPChecksumOffloadIPv6" /t REG_SZ /d "3" /f
    reg add "%%g" /v "UDPChecksumOffloadIPv4" /t REG_SZ /d "3" /f
    reg add "%%g" /v "UDPChecksumOffloadIPv6" /t REG_SZ /d "3" /f
    reg add "%%g" /v "TCPChecksumOffloadIPv4" /t REG_SZ /d "3" /f
    reg add "%%g" /v "TCPChecksumOffloadIPv6" /t REG_SZ /d "3" /f
    reg add "%%g" /v "IPChecksumOffloadIPv4" /t REG_SZ /d "3" /f
    reg add "%%g" /v "IPsecOffloadV1IPv4" /t REG_SZ /d "3" /f
    reg add "%%g" /v "IPsecOffloadV2" /t REG_SZ /d "3" /f
    reg add "%%g" /v "*IPsecOffloadV2IPv4" /t REG_SZ /d "3" /f
    reg add "%%g" /v "*PMARPOffload" /t REG_SZ /d "1" /f
    reg add "%%g" /v "*PMNSOffload" /t REG_SZ /d "1" /f
    reg add "%%g" /v "*PMWiFiRekeyOffload" /t REG_SZ /d "1" /f
    ) >nul 2>&1
    )
)


if "%DNS%" equ "True" (
REM Setting primary DNS server to 1.1.1.1 
netsh interface ip set dns name="Ethernet" static 1.1.1.1 primary >nul 2>&1

REM Setting secondary DNS server to 1.0.0.1
netsh interface ip add dns name="Ethernet" addr=1.0.0.1 index=2 >nul 2>&1
)

if "%WindowsNetworkSettigns%" equ "True" (
REM Enable Network Task Offloading
Netsh int ip set global taskoffload=enabled >nul 2>&1
reg add HKLM\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters /v DisableTaskOffload /t REG_DWORD /d 0 /f >nul 2>&1

REM Setting global neighbor cache limit
netsh int ip set global neighborcachelimit=4096 >nul 2>&1

REM Setting global route cache limit
netsh int ip set global routecachelimit=4096 >nul 2>&1

REM Disable source routing
netsh int ip set global sourceroutingbehavior=drop >nul 2>&1

REM Disable DHCP Media Sense
netsh int ip set global dhcpmediasense=disabled >nul 2>&1

REM Disable Media Sense event logging
netsh int ip set global mediasenseeventlog=disabled >nul 2>&1

REM Disable MLD for IPv6
netsh int ip set global mldlevel=none >nul 2>&1

REM Set global TCP settings
netsh int tcp set global chimney=enabled congestionprovider=ctcp dca=enabled netdma=disabled >nul 2>&1

REM Disable Teredo tunneling
netsh interface teredo set state disabled >nul 2>&1

REM Disable ISATAP state
netsh int isatap set state disable >nul 2>&1

REM Find network interface number
for /f "tokens=1" %%i in ('netsh int ip show interfaces ^| findstr [0-9]') do set INTERFACE=%%i >nul 2>&1

REM Set interface parameters
netsh int ip set interface %INTERFACE% basereachable=3600000 dadtransmits=0 otherstateful=disabled routerdiscovery=disabled store=persistent >nul 2>&1

REM Disable RSC (Receive Segment Coalescing)
netsh int tcp set global rsc=disabled >nul 2>&1

REM Setting Initial Retransmission Timeout
netsh int tcp set global initialRto=2000 >nul 2>&1

REM Disable TCP heuristics
netsh int tcp set heuristics disabled >nul 2>&1

REM Disable window scaling heuristics
netsh int tcp set heuristics wsh=disabled >nul 2>&1

REM Disable Multipath TCP
netsh int tcp set security mpp=disabled >nul 2>&1

REM Disable TCP security profiles
netsh int tcp set security profiles=disabled >nul 2>&1

REM Setting TCP dynamic port range
netsh int ipv4 set dynamicport tcp start=1025 num=64511 >nul 2>&1

REM Setting UDP dynamic port range
netsh int ipv4 set dynamicport udp start=1025 num=64511 >nul 2>&1

REM Disable Windows Scaling heuristics in PowerShell
powershell Set-NetTCPSetting -SettingName "*" -ForceWS Disabled >nul 2>&1
)

if "%Autotunning%" equ "True" (
REM Disable Autotunning
netsh int tcp set global autotuninglevel=disabled >nul 2>&1
)

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
REM Set KeyboardDataQueueSize To 50 Dec
reg add "HKLM\SYSTEM\CurrentControlSet\services\kbdclass\Parameters" /v "KeyboardDataQueueSize" /t REG_DWORD /d "50" /f >nul 2>&1

REM Adjusts keyboard parameters
reg add "HKCU\Control Panel\Keyboard" /v "KeyboardSpeed" /t REG_SZ /d "31" /f >nul 2>&1
reg add "HKCU\Control Panel\Keyboard" /v "KeyboardDelay" /t REG_SZ /d "0" /f >nul 2>&1

REM Configures keyboard accessibility settings
reg add "HKCU\Control Panel\Accessibility\Keyboard Response" /v "BounceTime" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCU\Control Panel\Accessibility\Keyboard Response" /v "Flags" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCU\Control Panel\Accessibility\Keyboard Response" /v "Last BounceKey Setting" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Control Panel\Accessibility\Keyboard Response" /v "Last Valid Delay" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Control Panel\Accessibility\Keyboard Response" /v "Last Valid Repeat" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Control Panel\Accessibility\Keyboard Response" /v "Last Valid Wait" /t REG_DWORD /d "1000" /f >nul 2>&1

REM Set MouseDataQueueSize To 50 Dec
reg add "HKLM\SYSTEM\CurrentControlSet\services\mouclass\Parameters" /v "MouseDataQueueSize" /t REG_DWORD /d "50" /f >nul 2>&1

REM Disable Pointer Acceleration
reg add "HKCU\Control Panel\Mouse" /v "MouseSpeed" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v "MouseThreshold1" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v "MouseThreshold2" /t REG_SZ /d "0" /f >nul 2>&1

REM Configures mouse accessibility settings
reg add "HKCU\Control Panel\Accessibility\MouseKeys" /v "Flags" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCU\Control Panel\Accessibility\MouseKeys" /v "MaximumSpeed" /t REG_SZ /d "80" /f >nul 2>&1
reg add "HKCU\Control Panel\Accessibility\MouseKeys" /v "TimeToMaximumSpeed" /t REG_SZ /d "3000" /f >nul 2>&1

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
schtasks /Change /TN "Microsoft\Windows\AppID\SmartScreenSpecific" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Application Experience\ProgramDataUpdater" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Application Experience\StartupAppTask" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\MemoryDiagnostic\ProcessMemoryDiagnosticEvent" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Uploader" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Shell\FamilySafetyUpload" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Office\OfficeTelemetryAgentLogOn" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Office\OfficeTelemetryAgentFallBack" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Office\OfficeTelemetryAgentFallBack2016" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Office\OfficeTelemetryAgentLogOn2016" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Office\Office 15 Subscription Heartbeat" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Office\Office 16 Subscription Heartbeat" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Windows Error Reporting\QueueReporting" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\WindowsUpdate\Automatic App Update" /Disable >nul 2>&1
schtasks /Change /TN "NIUpdateServiceStartupTask" /Disable >nul 2>&1
schtasks /Change /TN "CCleaner Update" /Disable >nul 2>&1
schtasks /Change /TN "CCleanerSkipUAC - %username%" /Disable >nul 2>&1
schtasks /Change /TN "Adobe Acrobat Update Task" /Disable >nul 2>&1
schtasks /Change /TN "AMDLinkUpdate" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Office\Office Automatic Updates 2.0" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Office\Office Feature Updates" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Office\Office Feature Updates Logon" /Disable >nul 2>&1
schtasks /Change /TN "GoogleUpdateTaskMachineCore" /Disable >nul 2>&1
schtasks /Change /TN "GoogleUpdateTaskMachineUA" /Disable >nul 2>&1
schtasks /DELETE /TN "AMDInstallLauncher" /f >nul 2>&1
schtasks /DELETE /TN "AMDLinkUpdate" /f >nul 2>&1
schtasks /DELETE /TN "AMDRyzenMasterSDKTask" /f >nul 2>&1
schtasks /DELETE /TN "DUpdaterTask" /f >nul 2>&1
schtasks /DELETE /TN "ModifyLinkUpdate" /f >nul 2>&1

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

If %gpu1%==Nvidia (
    goto nvidia
) else (
    goto checkforradeon
)

:checkforradeon
If %gpu1%==AMD (
    goto radeon
) else (
    goto nullgpu
)

:nullgpu
echo                                            Your GPU is not supported by Vitality.
goto skippinggpu

:nvidia
if "%GameMode%" equ "True" (
echo                                                   Applying Nvidia Tweaks
REM Enable Game Mode
reg add "HKCU\Software\Microsoft\GameBar" /v "AllowAutoGameMode" /t REG_DWORD /d "1" /f > nul 2>&1
reg add "HKCU\Software\Microsoft\GameBar" /v "AutoGameModeEnabled" /t REG_DWORD /d "1" /f > nul 2>&1
)

if "%NvidiaTelemetry%" equ "True" (
REM Remove Nvidia Telemetry
reg add "HKLM\SOFTWARE\NVIDIA Corporation\NvControlPanel2\Client" /v "OptInOrOutPreference" /t REG_DWORD /d 0 /f > nul 2>&1
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID44231" /t REG_DWORD /d 0 /f > nul 2>&1
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID64640" /t REG_DWORD /d 0 /f > nul 2>&1
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID66610" /t REG_DWORD /d 0 /f > nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "NvBackend" /f > nul 2>&1
schtasks /change /disable /tn "NvTmRep_CrashReport1_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}" > nul 2>&1
schtasks /change /disable /tn "NvTmRep_CrashReport2_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}" > nul 2>&1
schtasks /change /disable /tn "NvTmRep_CrashReport3_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}" > nul 2>&1
schtasks /change /disable /tn "NvTmRep_CrashReport4_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}" > nul 2>&1
rmdir /s /q "C:\Windows\System32\drivers\NVIDIA Corporation" > nul 2>&1
cd /d "C:\Windows\System32\DriverStore\FileRepository\" > nul 2>&1
dir NvTelemetry64.dll /a /b /s > nul 2>&1
del NvTelemetry64.dll /a /s > nul 2>&1
)


REM Registry Key For NVIDIA Card
for /f %%a in ('reg query "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}" /t REG_SZ /s /e /f "NVIDIA" ^| findstr "HKEY"') do (

REM Disalbe Tiled Display
reg add "%%a" /v "EnableTiledDisplay" /t REG_DWORD /d "0" /f > nul 2>&1

REM Disable TCC
reg add "%%a" /v "TCCSupported" /t REG_DWORD /d "0" /f > nul 2>&1

REM Force contiguous memory allocation
reg add "%%a" /v "PreferSystemMemoryContiguous" /t REG_DWORD /d "1" /f > nul 2>&1


REM KBoost
reg add "%%a" /v "PowerMizerEnable" /t REG_DWORD /d "1" /f > nul 2>&1
reg add "%%a" /v "PowerMizerLevel" /t REG_DWORD /d "1" /f > nul 2>&1
reg add "%%a" /v "PowerMizerLevelAC" /t REG_DWORD /d "1" /f> nul 2>&1
reg add "%%a" /v "PerfLevelSrc" /t REG_DWORD /d "8738" /f > nul 2>&1
)

REM Disable Scaling
for /f %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /s /f "Scaling"^| findstr "HKEY"') do reg add "%%i" /v "Scaling" /t REG_DWORD /d "1" /f >nul 2>&1

if "%P0States%" equ "True" (
REM Force P0-State
for /f %%i in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
	for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Enum\%%i" /v "Driver"') do (
		for /f %%i in ('echo %%a ^| findstr "{"') do (
		     reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "DisableDynamicPstate" /t REG_DWORD /d "1" /f > nul 2>&1
                   )
                )
             )
)

if "%HDCP%" equ "True" (
REM Disable HDCP
for /f %%i in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
	for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Enum\%%i" /v "Driver"') do (
		for /f %%i in ('echo %%a ^| findstr "{"') do (
		     reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "RMHdcpKeyglobZero" /t REG_DWORD /d "1" /f > nul 2>&1
                   )
                )
             )
)

REM No ECC
cd C:\Program Files\NVIDIA Corporation\NVSMI > nul 2>&1
nvidia-smi.exe -e 0 > nul 2>&1

REM Unrestricted Clock Policy
cd C:\Program Files\NVIDIA Corporation\NVSMI > nul 2>&1
nvidia-smi.exe -acp 0 > nul 2>&1

if "%Preemption%" equ "True" (
REM Disable Preemption
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "DisablePreemption" /t REG_DWORD /d "1" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "DisableCudaContextPreemption" /t REG_DWORD /d "1" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "EnableCEPreemption" /t REG_DWORD /d "0" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "DisablePreemptionOnS3S4" /t REG_DWORD /d "1" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "ComputePreemption" /t REG_DWORD /d "0" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "EnableMidGfxPreemption" /t REG_DWORD /d "0" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "EnableMidGfxPreemptionVGPU" /t REG_DWORD /d "0" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "EnableMidBufferPreemptionForHighTdrTimeout" /t REG_DWORD /d "0" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "EnableMidBufferPreemption" /t REG_DWORD /d "0" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "EnableAsyncMidBufferPreemption" /t REG_DWORD /d "0" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "DisableCudaContextPreemption" /t REG_DWORD /d "1" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\NVTweak" /v "DisplayPowerSaving" /t REG_DWORD /d "0" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnablePreemption" /t REG_DWORD /d "0" /f > nul 2>&1
)

if "%Logging%" equ "True" (
REM Disable Logging
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "LogWarningEntries" /t REG_DWORD /d "0" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "LogPagingEntries" /t REG_DWORD /d "0" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "LogEventEntries" /t REG_DWORD /d "0" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "LogErrorEntries" /t REG_DWORD /d "0" /f > nul 2>&1
)

if "%NvidiaProfileInspector%" equ "True" (
REM Applying Custon Nvidia Profile Inspector Config
if exist "%SYSTEMDRIVE%\Vitality\Resources\nvidiaProfileInspector" (
    rd /s /q "%SYSTEMDRIVE%\Vitality\Resources\nvidiaProfileInspector"  >nul 2>&1
) 
if not exist "%SYSTEMDRIVE%\Vitality\Resources\nvidiaProfileInspector" md "%SYSTEMDRIVE%\Vitality\Resources\nvidiaProfileInspector"  >nul 2>&1
curl -g -L -# -o "%SYSTEMDRIVE%\Vitality\Resources\nvidiaProfileInspector\nvidiaProfileInspector.zip" "https://github.com/Orbmu2k/nvidiaProfileInspector/releases/latest/download/nvidiaProfileInspector.zip"  >nul 2>&1
powershell -NoProfile Expand-Archive '%SYSTEMDRIVE%\Vitality\Resources\nvidiaProfileInspector\nvidiaProfileInspector.zip' -DestinationPath '%SYSTEMDRIVE%\Vitality\Resources\nvidiaProfileInspector' >nul 2>&1
del /F /Q "%SYSTEMDRIVE%\Vitality\Resources\nvidiaProfileInspector\nvidiaProfileInspector.zip"  >nul 2>&1
curl -g -L -# -o "%SYSTEMDRIVE%\Vitality\Resources\nvidiaProfileInspector\Vitality.nip" "https://cdn.discordapp.com/attachments/1140029335944835152/1155469748755247135/Vitality.nip"  >nul 2>&1
cd "%SYSTEMDRIVE%\Vitality\Resources\nvidiaProfileInspector\"  >nul 2>&1
nvidiaProfileInspector.exe "Vitality.nip" >nul 2>&1
)



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
if "%GameModeAMD%" equ "True" (
REM Disable Gamemode
reg add "HKCU\Software\Microsoft\GameBar" /v "AllowAutoGameMode" /t REG_DWORD /d "0" /f > nul 2>&1 
reg add "HKCU\Software\Microsoft\GameBar" /v "AutoGameModeEnabled" /t REG_DWORD /d "0" /f > nul 2>&1 
)

if "%AMDOptimizedSettings%" equ "True" (
REM AMD Optimized Settings
reg add "HKCU\Software\AMD\CN" /v "AutoUpdateTriggered" /t REG_DWORD /d "0" /f > nul 2>&1 
reg add "HKCU\Software\AMD\CN" /v "PowerSaverAutoEnable_CUR" /t REG_DWORD /d "0" /f > nul 2>&1
reg add "HKCU\Software\AMD\CN" /v "WindowSize" /t REG_SZ /d "1440,960" /f > nul 2>&1
reg add "HKCU\Software\AMD\CN" /v "BuildType" /t REG_DWORD /d "0" /f > nul 2>&1
reg add "HKCU\Software\AMD\CN" /v "WizardProfile" /t REG_SZ /d "PROFILE_CUSTOM" /f > nul 2>&1
reg add "HKCU\Software\AMD\CN" /v "UserTypeWizardShown" /t REG_DWORD /d "1" /f > nul 2>&1
reg add "HKCU\Software\AMD\CN" /v "LastPage" /t REG_SZ /d "settings/graphics/0/" /f > nul 2>&1
reg add "HKCU\Software\AMD\CN" /v "AutoUpdate" /t REG_DWORD /d "0" /f > nul 2>&1
reg add "HKCU\Software\AMD\CN" /v "RSXBrowserUnavailable" /t REG_SZ /d "true" /f > nul 2>&1
reg add "HKCU\Software\AMD\CN" /v "SYSTEMTray" /t REG_SZ /d "false" /f > nul 2>&1
reg add "HKCU\Software\AMD\CN" /v "AllowWebContent" /t REG_SZ /d "false" /f > nul 2>&1
reg add "HKCU\Software\AMD\CN" /v "CN_Hide_Toast_Notification" /t REG_SZ /d "true" /f > nul 2>&1
reg add "HKCU\Software\AMD\CN" /v "AnimationEffect" /t REG_SZ /d "false" /f > nul 2>&1
reg add "HKCU\Software\AMD\CN\OverlayNotification" /v "AlreadyNotified" /t REG_DWORD /d "1" /f > nul 2>&1
reg add "HKCU\Software\AMD\CN\VirtualSuperResolution" /v "AlreadyNotified" /t REG_DWORD /d "1" /f > nul 2>&1
reg add "HKCU\Software\AMD\DVR" /v "PerformanceMonitorOpacityWA" /t REG_DWORD /d "0" /f > nul 2>&1
reg add "HKCU\Software\AMD\DVR" /v "CaptureFileOutput" /t REG_SZ /d "C:\Users\Emre\Videos\Radeon ReLive" /f > nul 2>&1
reg add "HKCU\Software\AMD\DVR" /v "DvrEnabled" /t REG_DWORD /d "1" /f > nul 2>&1
reg add "HKCU\Software\AMD\DVR" /v "ActiveSceneId" /t REG_SZ /d "0" /f > nul 2>&1
reg add "HKCU\Software\AMD\DVR" /v "AVCCaps" /t REG_SZ /d "256,1,4096,4096,100000000,244800,0;" /f > nul 2>&1
reg add "HKCU\Software\AMD\DVR" /v "HEVCCaps" /t REG_SZ /d "256,1,4096,4096,2147483647,979200,0;" /f > nul 2>&1
reg add "HKCU\Software\AMD\DVR" /v "AvcEfcSupport" /t REG_SZ /d "0;" /f > nul 2>&1
reg add "HKCU\Software\AMD\DVR" /v "HevcEfcSupport" /t REG_SZ /d "0;" /f > nul 2>&1
reg add "HKCU\Software\AMD\DVR" /v "PrevInstantReplayEnable" /t REG_DWORD /d "0" /f > nul 2>&1
reg add "HKCU\Software\AMD\DVR" /v "PrevInGameReplayEnabled" /t REG_DWORD /d "0" /f > nul 2>&1
reg add "HKCU\Software\AMD\DVR" /v "PrevInstantGifEnabled" /t REG_DWORD /d "0" /f > nul 2>&1
reg add "HKCU\Software\AMD\DVR" /v "DvrDesktops" /t REG_SZ /d "\\.\DISPLAY19" /f > nul 2>&1
reg add "HKCU\Software\AMD\DVR" /v "RemoteServerStatus" /t REG_DWORD /d "0" /f > nul 2>&1
reg add "HKCU\Software\AMD\DVR" /v "ShowRSOverlay" /t REG_SZ /d "false" /f > nul 2>&1
reg add "HKCU\Software\AMD\SCENE\0" /v "CameraSize" /t REG_DWORD /d "3" /f > nul 2>&1
reg add "HKCU\Software\AMD\SCENE\0" /v "CameraEnabled" /t REG_DWORD /d "1" /f > nul 2>&1
reg add "HKCU\Software\AMD\SCENE\0" /v "CameraOpacity" /t REG_DWORD /d "100" /f > nul 2>&1
reg add "HKCU\Software\AMD\SCENE\0" /v "CameraAnchor" /t REG_DWORD /d "3" /f > nul 2>&1
reg add "HKCU\Software\AMD\SCENE\0" /v "CameraShownOnScreen" /t REG_DWORD /d "1" /f > nul 2>&1
reg add "HKCU\Software\AMD\SCENE\0" /v "IndicatorPosition" /t REG_DWORD /d "0" /f > nul 2>&1
reg add "HKCU\Software\AMD\SCENE\0" /v "TimerEnabled" /t REG_DWORD /d "1" /f > nul 2>&1
reg add "HKCU\Software\AMD\SCENE\0" /v "ChatOverlayEnabled" /t REG_DWORD /d "0" /f > nul 2>&1
reg add "HKCU\Software\AMD\SCENE\0" /v "ChatCustomOffset" /t REG_SZ /d "0.0260,0.0462" /f > nul 2>&1
reg add "HKCU\Software\AMD\SCENE\0" /v "ChatOverlayAnchor" /t REG_DWORD /d "4" /f > nul 2>&1
reg add "HKCU\Software\AMD\SCENE\0" /v "ChatBackgroundBlur" /t REG_DWORD /d "0" /f > nul 2>&1
reg add "HKCU\Software\AMD\SCENE\0" /v "ChatFontSize" /t REG_DWORD /d "1" /f > nul 2>&1
reg add "HKCU\Software\AMD\SCENE\0" /v "RelativeCoords" /t REG_DWORD /d "1" /f > nul 2>&1
reg add "HKCU\Software\AMD\SCENE\0" /v "CameraOffset" /t REG_SZ /d "0.0208,0.0370" /f > nul 2>&1
reg add "HKCU\Software\AMD\SCENE\0" /v "CameraCustomOffset" /t REG_SZ /d "0.0208,0.0370" /f > nul 2>&1
reg add "HKCU\Software\AMD\SCENE\0" /v "CameraRect" /t REG_SZ /d "0.1667,0.2222" /f > nul 2>&1
reg add "HKCU\Software\AMD\SCENE\0" /v "CameraCustomRect" /t REG_SZ /d "0.1667,0.2222" /f > nul 2>&1
reg add "HKCU\Software\AMD\SCENE\0" /v "ChatCustomRect" /t REG_SZ /d "0.1562,0.1562" /f > nul 2>&1
reg add "HKCU\Software\AMD\SCENE\0" /v "ChatOverlaySize" /t REG_DWORD /d "3" /f > nul 2>&1
reg add "HKCU\Software\ATI\ACE\Settings\ADL\AppProfiles" /v "AplReloadCounter" /t REG_DWORD /d "0" /f > nul 2>&1
reg add "HKLM\SOFTWARE\AMD\Install" /v "AUEP" /t REG_DWORD /d "1" /f > nul 2>&1
reg add "HKLM\SOFTWARE\AUEP" /v "RSX_AUEPStatus" /t REG_DWORD /d "2" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "NotifySubscription" /t REG_BINARY /d "3000" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "IsComponentControl" /t REG_BINARY /d "00000000" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "KMD_USUEnable" /t REG_DWORD /d "0" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "KMD_RadeonBoostEnabled" /t REG_DWORD /d "0" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "IsAutoDefault" /t REG_BINARY /d "01000000" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "KMD_ChillEnabled" /t REG_DWORD /d "0" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "KMD_DeLagEnabled" /t REG_DWORD /d "0" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "ACE" /t REG_BINARY /d "3000" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "AnisoDegree_SET" /t REG_BINARY /d "3020322034203820313600" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "Main3D_SET" /t REG_BINARY /d "302031203220332034203500" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "Tessellation_OPTION" /t REG_BINARY /d "3200" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "Tessellation" /t REG_BINARY /d "3100" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "AAF" /t REG_BINARY /d "30000000" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "GI" /t REG_BINARY /d "31000000" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "CatalystAI" /t REG_BINARY /d "31000000" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "TemporalAAMultiplier_NA" /t REG_BINARY /d "3100" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "ForceZBufferDepth" /t REG_BINARY /d "30000000" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "EnableTripleBuffering" /t REG_BINARY /d "3000" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "ExportCompressedTex" /t REG_BINARY /d "31000000" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "PixelCenter" /t REG_BINARY /d "30000000" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "ZFormats_NA" /t REG_BINARY /d "3100" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "DitherAlpha_NA" /t REG_BINARY /d "3100" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "SwapEffect_D3D_SET" /t REG_BINARY /d "3020312032203320342038203900" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "TFQ" /t REG_BINARY /d "3200" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "VSyncControl" /t REG_BINARY /d "3100" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "TextureOpt" /t REG_BINARY /d "30000000" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "TextureLod" /t REG_BINARY /d "30000000" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "ASE" /t REG_BINARY /d "3000" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "ASD" /t REG_BINARY /d "3000" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "ASTT" /t REG_BINARY /d "3000" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "AntiAliasSamples" /t REG_BINARY /d "3000" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "AntiAlias" /t REG_BINARY /d "3100" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "AnisoDegree" /t REG_BINARY /d "3000" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "AnisoType" /t REG_BINARY /d "30000000" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "AntiAliasMapping_SET" /t REG_BINARY /d "3028303A302C313A3029203228303A322C313A3229203428303A342C313A3429203828303A382C313A382900" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "AntiAliasSamples_SET" /t REG_BINARY /d "3020322034203800" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "ForceZBufferDepth_SET" /t REG_BINARY /d "3020313620323400" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "SwapEffect_OGL_SET" /t REG_BINARY /d "3020312032203320342035203620372038203920313120313220313320313420313520313620313700" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "Tessellation_SET" /t REG_BINARY /d "31203220342036203820313620333220363400" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "HighQualityAF" /t REG_BINARY /d "3100" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "DisplayCrossfireLogo" /t REG_BINARY /d "3000" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "AppGpuId" /t REG_BINARY /d "300078003000310030003000" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "SwapEffect" /t REG_BINARY /d "30000000" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "PowerState" /t REG_BINARY /d "3000" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "AntiStuttering" /t REG_BINARY /d "3100" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "TurboSync" /t REG_BINARY /d "3000" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "SurfaceFormatReplacements" /t REG_BINARY /d "3100" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "EQAA" /t REG_BINARY /d "3000" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "ShaderCache" /t REG_BINARY /d "3100" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "MLF" /t REG_BINARY /d "3000" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "TruformMode_NA" /t REG_BINARY /d "3100" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "LRTCEnable" /t REG_BINARY /d "30000000" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "3to2Pulldown" /t REG_BINARY /d "31000000" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "MosquitoNoiseRemoval_ENABLE" /t REG_BINARY /d "30000000" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "MosquitoNoiseRemoval" /t REG_BINARY /d "350030000000" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "Deblocking_ENABLE" /t REG_BINARY /d "30000000" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "Deblocking" /t REG_BINARY /d "350030000000" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "DemoMode" /t REG_BINARY /d "30000000" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "OverridePA" /t REG_BINARY /d "30000000" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "DynamicRange" /t REG_BINARY /d "30000000" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "StaticGamma_ENABLE" /t REG_BINARY /d "30000000" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "BlueStretch_ENABLE" /t REG_BINARY /d "31000000" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "BlueStretch" /t REG_BINARY /d "31000000" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "LRTCCoef" /t REG_BINARY /d "3100300030000000" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "DynamicContrast_ENABLE" /t REG_BINARY /d "30000000" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "WhiteBalanceCorrection" /t REG_BINARY /d "30000000" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "Fleshtone_ENABLE" /t REG_BINARY /d "30000000" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "Fleshtone" /t REG_BINARY /d "350030000000" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "ColorVibrance_ENABLE" /t REG_BINARY /d "31000000" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "ColorVibrance" /t REG_BINARY /d "340030000000" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "Detail_ENABLE" /t REG_BINARY /d "30000000" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "Detail" /t REG_BINARY /d "310030000000" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "Denoise_ENABLE" /t REG_BINARY /d "30000000" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "Denoise" /t REG_BINARY /d "360034000000" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "TrueWhite" /t REG_BINARY /d "30000000" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "OvlTheaterMode" /t REG_BINARY /d "30000000" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "StaticGamma" /t REG_BINARY /d "3100300030000000" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "InternetVideo" /t REG_BINARY /d "30000000" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdwddmg" /v "ChillEnabled" /t REG_DWORD /d "0" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "Main3D_DEF" /t REG_SZ /d "1" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "Main3D" /t REG_BINARY /d "3100" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DisableDMACopy" /t REG_DWORD /d "1" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DisableBlockWrite" /t REG_DWORD /d "0" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "PP_ThermalAutoThrottlingEnable" /t REG_DWORD /d "0" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DisableDrmdmaPowerGating" /t REG_DWORD /d "1" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\AMD Crash Defender Service" /v "Start" /t REG_DWORD /d "4" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\AMD External Events Utility" /v "Start" /t REG_DWORD /d "4" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdfendr" /v "Start" /t REG_DWORD /d "4" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdfendrmgr" /v "Start" /t REG_DWORD /d "4" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdlog" /v "Start" /t REG_DWORD /d "4" /f > nul 2>&1
)

if "%AMDDebloat%" equ "True" (
REM Debloat AMD Drivers
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
)
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
REM Configure Memory Managment 
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "ClearPageFileAtShutdown" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "DisablePagingExecutive" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "DisablePageCombining" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "NonPagedPoolQuota" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "NonPagedPoolSize" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "PagedPoolQuota" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "PagedPoolSize" /t REG_DWORD /d "192" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "SecondLevelDataCache" /t REG_DWORD /d "1024" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "SessionPoolSize" /t REG_DWORD /d "192" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "SessionViewSize" /t REG_DWORD /d "192" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "SystemPages" /t REG_DWORD /d "4294967295" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "PhysicalAddressExtension" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettings" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverride" /t REG_DWORD /d "3" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverrideMask" /t REG_DWORD /d "3" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "IoPageLockLimit" /t REG_DWORD /d "16710656" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "PoolUsageMaximum" /t REG_DWORD /d "96" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "EnablePrefetcher" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "EnableSuperfetch" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnablePrefetcher" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnableSuperfetch" /t REG_DWORD /d "0" /f >nul 2>&1

REM LargePageDrivers
set WHITELIST=ACPI AcpiDev AcpiPmi AFD AMDPCIDev amdgpio2 amdgpio3 AmdPPM amdpsp amdsata amdsbs amdxata asmtxhci atikmdag BasicDisplay BasicRender dc1-controll Disk DXGKrnl e1iexpress e1rexpress genericusbfn hwpolicy IntcAzAudAdd kbdclass kbdhid MMCSS monitor mouclass mouhid mountmgr mt7612US MTConfig NDIS nvdimm nvlddmkm pci PktMon Psched rt640x64 RTCore64 RzCommon RzDev_0244 Tcpip usbehci usbhub USBHUB3 USBXHCI Wdf01000 xboxgip xinputhid
for /f %%i in ('driverquery ^| findstr "!WHITELIST!"') do set "DRIVERLIST=!DRIVERLIST!%%i\0"
reg add "HKLM\SYSTEM\currentcontrolset\control\session manager\Memory Management" /v "LargePageDrivers" /t REG_MULTI_SZ /d "!DRIVERLIST!" /f >nul 2>&1
:skippingram

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
if "%FileSystemOptimization%" equ "True" (
REM File System Optimization
fsutil behavior set allowextchar 0 > NUL 2>&1
fsutil behavior set Bugcheckoncorrupt 0 > NUL 2>&1
fsutil repair set C: 0 > NUL 2>&1
fsutil behavior set disable8dot3 1 > NUL 2>&1
fsutil behavior set disablecompression 1 > NUL 2>&1
fsutil behavior set disableencryption 1 > NUL 2>&1
fsutil behavior set disablelastaccess 1 > NUL 2>&1
fsutil behavior set disablespotcorruptionhandling 1 > NUL 2>&1
fsutil behavior set encryptpagingfile 0 > NUL 2>&1
fsutil behavior set quotanotify 86400 > NUL 2>&1
fsutil behavior set symlinkevaluation L2L:1 > NUL 2>&1
fsutil behavior set disabledeletenotify 0 > NUL 2>&1
)

if "%Cleaner%" equ "True" (
REM Cleaner
del /s /f /q c:\windows\temp\*.* > NUL 2>&1
rd /s /q c:\windows\temp  > NUL 2>&1
md c:\windows\temp > NUL 2>&1
del /s /f /q C:\WINDOWS\Prefetch > NUL 2>&1
del /s /f /q %temp%\*.* > NUL 2>&1
rd /s /q %temp% > NUL 2>&1
md %temp% > NUL 2>&1
deltree /y c:\windows\tempor~1 > NUL 2>&1
deltree /y c:\windows\temp > NUL 2>&1
deltree /y c:\windows\tmp > NUL 2>&1
deltree /y c:\windows\ff*.tmp > NUL 2>&1
deltree /y c:\windows\history > NUL 2>&1
deltree /y c:\windows\cookies > NUL 2>&1
deltree /y c:\windows\recent > NUL 2>&1
deltree /y c:\windows\spool\printers > NUL 2>&1
del c:\WIN386.SWP > NUL 2>&1
)

if "%Startupcleaner%" equ "True" (
REM Startup Cleaner (shell:startup)
if exist "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Vitality-Cleaner.bat" del "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Vitality-Cleaner.bat"
curl -g -L -# -o "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Vitality-Cleaner.bat" "https://cdn.discordapp.com/attachments/1140029335944835152/1140255553873006742/Vitality-Cleaner.bat" >nul 2>&1
)

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
REM Disable push notifications for applications
reg add "HKCU\Software\Policies\Microsoft\Windows\CurrentVersion\PushNotifications" /v "NoToastApplicationNotification" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\Software\Policies\Microsoft\Windows\CurrentVersion\PushNotifications" /v "NoToastApplicationNotificationOnLockScreen" /t REG_DWORD /d "1" /f >nul 2>&1

REM Disable driver searching for Windows Update
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" /v "SearchOrderConfig" /t REG_DWORD /d "0" /f >nul 2>&1

If "%DisableHibernation%" equ "True" (
REM Disable Hibernation
powercfg /h off >nul 2>&1
)


REM Disable Windows Notifications Center
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "DisableNotificationCenter" /t REG_DWORD /d "1" /f >nul 2>&1

REM Disable transparency in themes
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "EnableTransparency" /t REG_DWORD /d "0" /f >nul 2>&1

If "%DisableAutomaticMaintenance%" equ "True" (
REM Disable automatic maintenance
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v "MaintenanceDisabled" /t REG_DWORD /d "1" /f >nul 2>&1
)

REM Pause Maps Updates/Downloads
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Maps" /v "AutoDownloadAndUpdateMapData" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Maps" /v "AllowUntriggeredNetworkTrafficOnSettingsPage" /t REG_DWORD /d "0" /f >nul 2>&1

REM Disable Settings Sync
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableSettingSync" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableSettingSyncUserOverride" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableSyncOnPaidNetwork" /t REG_DWORD /d "1" /f >nul 2>&1

REM Disable Advertising ID
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v "DisabledByGroupPolicy" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d "0" /f >nul 2>&1

If "%DisableLocationTracking%" equ "True" (
REM Location Tracking
reg add "HKLM\SOFTWARE\Policies\Microsoft\FindMyDevice" /v "AllowFindMyDevice" /t REG_DWORD /d "0" /F >nul 2>&1
)

REM Disable Web in Search
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWeb" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d "0" /f >nul 2>&1

REM Disable Remote Assistance
reg add "HKLM\System\CurrentControlSet\Control\Remote Assistance" /v "fAllowFullControl" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Control\Remote Assistance" /v "fAllowToGetHelp" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Control\Remote Assistance" /v "fEnableChatControl" /t REG_DWORD /d "0" /f >nul 2>&1

REM Turn off Inventory Collector
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableInventory" /t REG_DWORD /d "1" /f >nul 2>&1

REM Turn off Windows Error Reporting
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d "1" /f >nul 2>&1

If "%DisableTelemetry%" equ "True" (
REM Disable Application Telemetry
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "AITEnable" /t REG_DWORD /d "0" /f >nul 2>&1

REM Disable Telemetry
reg add "HKLM\SOFTWARE\Policies\Microsoft\MSDeploy\3" /v "EnableTelemetry" /t REG_DWORD /d "0" /f >nul 2>&1

REM Configure Data Collection
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /F /V "AllowCommercialDataPipeline" /T REG_DWORD /d 0  >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /F /V "AllowDesktopAnalyticsProcessing" /T REG_DWORD /d 0  >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /F /V "AllowDeviceNameInTelemetry" /T REG_DWORD /d 0  >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /F /V "AllowTelemetry" /T REG_DWORD /d 0  >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /F /V "AllowUpdateComplianceProcessing" /T REG_DWORD /d 0  >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /F /V "AllowWUfBCloudProcessing" /T REG_DWORD /d 0  >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /F /V "DisableEnterpriseAuthProxy" /T REG_DWORD /d 1  >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /F /V "MicrosoftEdgeDataOptIn" /T REG_DWORD /d 0  >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /F /V "DisableTelemetryOptInChangeNotification" /T REG_DWORD /d 1  >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /F /V "DisableTelemetryOptInSettingsUx" /T REG_DWORD /d 1  >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /F /V "DisableDiagnosticDataViewer" /T REG_DWORD /d 1  >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /F /V "EnableConfigFlighting" /T REG_DWORD /d 0  >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /F /V "DoNotShowFeedbackNotifications" /T REG_DWORD /d 1  >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /F /V "LimitEnhancedDiagnosticDataWindowsAnalytics" /T REG_DWORD /d 0  >nul 2>&1
)

REM Disable the Customer Experience Improvement program 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Internet Explorer\SQM" /v "DisableCustomerImprovementProgram" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\AppV\CEIP" /v "CEIPEnable" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Messenger\Client" /v "CEIP" /t REG_DWORD /d "2" /f >nul 2>&1

REM Disable Text/Ink/Handwriting Telemetry
reg add "HKCU\Software\Microsoft\Input\TIPC" /v Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" /v "RestrictImplicitTextCollection" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" /v "RestrictImplicitInkCollection" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\TabletPC" /v "PreventHandwritingDataSharing" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\HandwritingErrorReports" /v "PreventHandwritingErrorReports" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Personalization\Settings" /v AcceptedPrivacyPolicy /t REG_DWORD /d 0 /f >nul 2>&1

REM Disable OneDrive Sync
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSyncNGSC" /t REG_DWORD /d "1" /f >nul 2>&1

REM Disable Biometrics
reg add "HKLM\SOFTWARE\Policies\Microsoft\Biometrics" /v "Enabled" /t REG_DWORD /d "0" /f >nul 2>&1

REM Deny capability access for specific apps.
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics" /F /V "Value" /T REG_SZ /d "Deny"  >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appointments" /F /V "Value" /T REG_SZ /d "Deny"  >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\email" /F /V "Value" /T REG_SZ /d "Deny"  >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCall" /F /V "Value" /T REG_SZ /d "Deny"  >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userDataTasks" /F /V "Value" /T REG_SZ /d "Deny"  >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\chat" /F /V "Value" /T REG_SZ /d "Deny"  >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\contacts" /F /V "Value" /T REG_SZ /d "Deny"  >nul 2>&1

REM Disable location services
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocation" /t REG_DWORD /d 1 /f >nul 2>&1      
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocationScripting" /t REG_DWORD /d 1 /f >nul 2>&1   
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableSensors" /t REG_DWORD /d 1 /f >nul 2>&1      
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableWindowsLocationProvider" /t REG_DWORD /d 1 /f >nul 2>&1


If "%BootOptions%" equ "True" (
REM Configure Boot Options
    REM  Disables boot graphics.
    bcdedit /set bootux disabled > NUL 2>&1

    REM Set Boot Menu to Standard Instead Of Legacy
    bcdedit /set bootmenupolicy standard > NUL 2>&1

    REM Disable Hyper-V
    bcdedit /set hypervisorlaunchtype off > NUL 2>&1

    REM Disable TPM
    bcdedit /set tpmbootentropy ForceDisable > NUL 2>&1
    
    REM Enable Quietboot
    bcdedit /set quietboot yes > NUL 2>&1

    REM Disable Boot Logo
    bcdedit /set {globalsettings} custom:16000067 true > NUL 2>&13

    REM Disable Spinning Animation
    bcdedit /set {globalsettings} custom:16000069 true > NUL 2>&1

    REM Disable Boot Message
    bcdedit /set {globalsettings} custom:16000068 true > NUL 2>&1

    REM Disable Automatic Repair
    bcdedit /set {current} recoveryenabled no > NUL 2>&1

    REM Avoid the use of uncontiguous portions of low-memory from the OS
    bcdedit /set firstmegabytepolicy UseAll >nul 2>&1
    bcdedit /set avoidlowmemory 0x8000000 >nul 2>&1
    bcdedit /set nolowmem Yes >nul 2>&1

    REM Disable Some Kernel Memory Mitigations
    bcdedit /set allowedinmemorysettings 0x0 >nul 2>&1
    bcdedit /set isolatedcontext No >nul 2>&1
 
    REM Disable DMA Memory Protection And Cores Isolation
    bcdedit /set vsmlaunchtype Off >nul 2>&1
    bcdedit /set vm No >nul 2>&1

    REM Enable X2Apic And Enable Memory Mapping
    bcdedit /set x2apicpolicy Enable >nul 2>&1
    bcdedit /set configaccesspolicy Default >nul 2>&1
    bcdedit /set MSI Default >nul 2>&1
    bcdedit /set usephysicaldestination No >nul 2>&1
    bcdedit /set usefirmwarepcisettings No >nul 2>&1
)

If "%PasswordOnWakeUp%" equ "True" (
REM Require a password on wakeup: OFF
powercfg -setacvalueindex scheme_current sub_none CONSOLELOCK 0 >nul
)

REM Prevent Windows Marking File Attachments With Informations About Their Zone Of Origin
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" /v "SaveZoneInformation" /t REG_DWORD /d "1" /f >nul 2>&1

REM Disable Language Bar
reg add "HKCU\Keyboard Layout\Toggle" /v "Layout Hotkey" /t REG_SZ /d "3" /f >nul 2>&1
reg add "HKCU\Keyboard Layout\Toggle" /v "Language Hotkey" /t REG_SZ /d "3" /f >nul 2>&1
reg add "HKCU\Keyboard Layout\Toggle" /v "Hotkey" /t REG_SZ /d "3" /f >nul 2>&1

REM Disable Sticky Keys
reg add "HKCU\Control Panel\Accessibility\StickyKeys" /v "Flags" /t REG_SZ /d "506" /f >nul 2>&1

REM Disable Program Compatibility Assistant
reg add "HKCU\Software\Policies\Microsoft\Windows\AppCompat" /v "DisablePCA" /t REG_DWORD /d "1" /f >nul 2>&1

REM Disable Custumer Experience Improvement Program
reg add "HKLM\SOFTWARE\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\VSCommon\15.0\SQM" /v "OptIn" /t REG_DWORD /d "0" /f >nul 2>&1

REM Disable Fault Tolerant Heap
reg add "HKLM\SOFTWARE\Microsoft\FTH" /v "Enabled" /t REG_DWORD /d "0" /f >nul 2>&1

REM Disable PowerShell Telemetry
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v "POWERSHELL_TELEMETRY_OPTOUT" /t REG_SZ /d "1" /f >nul 2>&1

REM Disable Windows Error Reporting
reg add "HKLM\SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting" /v "DoReport" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d "1" /f >nul 2>&1

REM Disable Remote Assistance
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v "fAllowToGetHelp" /t REG_DWORD /d "0" /f >nul 2>&1

If "%ShowFileExtension%" equ "True" (
REM Show File Extensions
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d "0" /f >nul 2>&1
)

REM Remove 3D Objects From Explorer Pane
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f >nul 2>&1

REM Disable Sing-In And Lock Last Interactive User 
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "DisableAutomaticRestartSignOn" /t REG_DWORD /d "1" /f >nul 2>&1

REM Disable Disable Online Tips
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "AllowOnlineTips" /t REG_DWORD /d "0" /f >nul 2>&1

REM Disable Typing Insights
reg add "HKCU\Software\Microsoft\input\Settings" /v "InsightsEnabled" /t REG_DWORD /d "0" /f >nul 2>&1

REM Disable Suggestions In The Search Box And In Search Home
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\SearchSettings" /v "IsDynamicSearchBoxEnabled" /t REG_DWORD /d "0" /f >nul 2>&1

REM Resotre Old Context Menu
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /ve /t REG_SZ /d "" /f >nul 2>&1
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /ve /t REG_SZ /d "" /f >nul 2>&1

REM Remove Pin TO Quick Access In Context Menu
reg delete "HKCR\Folder\shell\pintohome" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Classes\Folder\shell\pintohome" /f >nul 2>&1

REM Hide Folders In Quick Access
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowFrequent" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowRecent" /t REG_DWORD /d "0" /f >nul 2>&1

REM Hide Quick Access From File Explorer
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "HubMode" /t REG_DWORD /d "1" /f >nul 2>&1

REM Launch FIle Explorer To This PC
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d "1" /f >nul 2>&1

REM Turn Off Display Of Recent Search Entries In The File Explorer Search Box
reg add "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v "DisableSearchBoxSuggestions" /t REG_DWORD /d "1" /f >nul 2>&1

REM Clear History Of Recently Opened Documents On Exit
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "ClearRecentDocsOnExit" /t REG_DWORD /d "1" /f >nul 2>&1

REM Disable Recent Items And Frequent Places In File Explorer and Quick Access
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackDocs" /t REG_DWORD /d "0" /f >nul 2>&1
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
echo                                                   Applying Intel CPU Tweaks
REM Disable CPU Virtualization
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v "EnableVirtualizationBasedSecurity" /t REG_DWORD /d "0" /f > NUL 2>&1 

REM Disable Core Isolation
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v "Enabled" /t REG_DWORD /d "0" /f > NUL 2>&1

REM Configure C-States
powercfg -setacvalueindex scheme_current sub_processor IDLEPROMOTE 100 > NUL 2>&1
powercfg -setacvalueindex scheme_current sub_processor IDLEDEMOTE 100 > NUL 2>&1
powercfg -setacvalueindex scheme_current sub_processor IDLECHECK 100000 > NUL 2>&1
powercfg -setacvalueindex scheme_current sub_processor IDLESCALING 0 > NUL 2>&1

REM Disable Throttling
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v "PowerThrottlingOff" /t REG_DWORD /d "1" /f > NUL 2>&1

REM Disable AMD Services
reg add "HKLM\System\CurrentControlSet\Services\AmdK8" /v "Start" /t REG_DWORD /d "4" /f > NUL 2>&1
reg add "HKLM\System\CurrentControlSet\Services\amdsata" /v "Start" /t REG_DWORD /d "4" /f > NUL 2>&1
reg add "HKLM\System\CurrentControlSet\Services\amdsbs" /v "Start" /t REG_DWORD /d "4" /f > NUL 2>&1
reg add "HKLM\System\CurrentControlSet\Services\amdxata" /v "Start" /t REG_DWORD /d "4" /f > NUL 2>&1

REM Disable TSX
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "DisableTsx" /t REG_DWORD /d "0" /f > NUL 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "EnableTsx" /t REG_DWORD /d "1" /f > NUL 2>&1
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
echo                                                   Applying AMD CPU Tweaks
REM Disable CPU Virtualization
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v "EnableVirtualizationBasedSecurity" /t REG_DWORD /d "0" /f > NUL 2>&1

REM Disable Core Isolation
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v "Enabled" /t REG_DWORD /d "0" /f > NUL 2>&1

REM Configure C-States
powercfg -setacvalueindex scheme_current sub_processor IDLEPROMOTE 100 > NUL 2>&1
powercfg -setacvalueindex scheme_current sub_processor IDLEDEMOTE 100 > NUL 2>&1
powercfg -setacvalueindex scheme_current sub_processor IDLECHECK 100000 > NUL 2>&1
powercfg -setacvalueindex scheme_current sub_processor IDLESCALING 0 > NUL 2>&1

REM Disable Throttling
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v "PowerThrottlingOff" /t REG_DWORD /d "1" /f

REM Disable Intel Services
reg add "HKLM\System\CurrentControlSet\Services\iagpio" /v "Start" /t REG_DWORD /d "4" /f > NUL 2>&1
reg add "HKLM\System\CurrentControlSet\Services\iai2c" /v "Start" /t REG_DWORD /d "4" /f > NUL 2>&1
reg add "HKLM\System\CurrentControlSet\Services\iaLPSS2i_GPIO2" /v "Start" /t REG_DWORD /d "4" /f > NUL 2>&1
reg add "HKLM\System\CurrentControlSet\Services\iaLPSS2i_GPIO2_BXT_P" /v "Start" /t REG_DWORD /d "4" /f > NUL 2>&1
reg add "HKLM\System\CurrentControlSet\Services\iaLPSS2i_I2C" /v "Start" /t REG_DWORD /d "4" /f > NUL 2>&1	 
reg add "HKLM\System\CurrentControlSet\Services\iaLPSSi_GPIO" /v "Start" /t REG_DWORD /d "4" /f > NUL 2>&1	 
reg add "HKLM\System\CurrentControlSet\Services\iaStorAVC" /v "Start" /t REG_DWORD /d "4" /f > NUL 2>&1
reg add "HKLM\System\CurrentControlSet\Services\iaStorV" /v "Start" /t REG_DWORD /d "4" /f > NUL 2>&1
reg add "HKLM\System\CurrentControlSet\Services\intelide" /v "Start" /t REG_DWORD /d "4" /f > NUL 2>&1
reg add "HKLM\System\CurrentControlSet\Services\intelpep" /v "Start" /t REG_DWORD /d "4" /f > NUL 2>&1

REM Disable TSX
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "DisableTsx" /t REG_DWORD /d "1" /f > NUL 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "EnableTsx" /t REG_DWORD /d "0" /f > NUL 2>&1

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
if not exist "%appdata%\obs-studio" echo                                                   Please Reinstall OBS
taskkill /f /im obs64.exe >nul 2>&1
for /f %%A in ('powershell -Command "(Get-WmiObject -Class Win32_VideoController).CurrentHorizontalResolution"') do set "horizontal=%%A"
for /f %%A in ('powershell -Command "(Get-WmiObject -Class Win32_VideoController).CurrentVerticalResolution"') do set "vertical=%%A"
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
for /f %%A in ('powershell -Command "(Get-WmiObject -Class Win32_VideoController).CurrentHorizontalResolution"') do set "horizontal=%%A"
for /f %%A in ('powershell -Command "(Get-WmiObject -Class Win32_VideoController).CurrentVerticalResolution"') do set "vertical=%%A"
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
for /f %%A in ('powershell -Command "(Get-WmiObject -Class Win32_VideoController).CurrentHorizontalResolution"') do set "horizontal=%%A"
for /f %%A in ('powershell -Command "(Get-WmiObject -Class Win32_VideoController).CurrentVerticalResolution"') do set "vertical=%%A"
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
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Applets\Wordpad\Recent File List" /va /f > NUL 2>&1

REM Delete Recent Registry Entries Related To Map Network Drives
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Map Network Drive MRU" /va /f > NUL 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Map Network Drive MRU" /va /f > NUL 2>&1

REM Delete Recent Registry Entries Related To Search Assistand And RecentDocuments
reg delete "HKCU\Software\Microsoft\Search Assistant\ACMru" /va /f > NUL 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs" /va /f > NUL 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs" /va /f > NUL 2>&1

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
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\TypedPaths" /va /f > NUL 2>&1

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
reg delete "HKCU\Software\Microsoft\Internet Explorer\TypedURLs" /va /f > NUL 2>&1
reg delete "HKCU\Software\Microsoft\Internet Explorer\TypedURLsTime" /va /f > NUL 2>&1

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
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\SideBySide\Configuration" /v "DisableResetbase" /t "REG_DWORD" /d "0" /f > NUL 2>&1

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
reg add "HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d "0" /f >nul 2>&1

REM Disable AIT (Application Impact Telemetry)
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "AITEnable" /t REG_DWORD /d "0" /f >nul 2>&1

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
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\CurrentVersion\Software Protection Platform" /v "NoGenTicket" /t "REG_DWORD" /d "1" /f >nul 2>&1

REM Disable Windows Error Reporting
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t "REG_DWORD" /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting\Consent" /v "DefaultConsent" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting\Consent" /v "DefaultOverrideBehavior" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "DontSendAdditionalData" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "LoggingDisabled" /t REG_DWORD /d "1" /f >nul 2>&1

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
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{C1D23ACC-752B-43E5-8448-8D0E519CD6D6}" /t REG_SZ /v "Value" /d "Deny" /f >nul 2>&1

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
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{C1D23ACC-752B-43E5-8448-8D0E519CD6D6}" /t REG_SZ /v "Value" /d "Deny" /f >nul 2>&1

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
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{E5323777-F976-4f5b-9B55-B94699C46E44}" /t REG_SZ /v "Value" /d "Deny" /f >nul 2>&1

REM Configure app privacy settings for camera
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessCamera" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessCamera_UserInControlOfTheseApps" /t REG_MULTI_SZ /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessCamera_ForceAllowTheseApps" /t REG_MULTI_SZ /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessCamera_ForceDenyTheseApps" /t REG_MULTI_SZ /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{2EEF81BE-33FA-4800-9670-1CD474972C3F}" /v "Value" /t REG_SZ /d "Deny" /f >nul 2>&1

REM Deny access for all loosely coupled devices
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\LooselyCoupled" /t REG_SZ /v "Value" /d "Deny" /f >nul 2>&1

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
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{7D7E8402-7C54-4821-A34E-AEEFD62DED93}" /t REG_SZ /v "Value" /d "Deny" /f >nul 2>&1

REM Configure app privacy settings for contacts
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessContacts" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessContacts_UserInControlOfTheseApps" /t REG_MULTI_SZ /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessContacts_ForceAllowTheseApps" /t REG_MULTI_SZ /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessContacts_ForceDenyTheseApps" /t REG_MULTI_SZ /f >nul 2>&1

REM Deny user notification listener access
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userNotificationListener" /v "Value" /d "Deny" /t REG_SZ /f >nul 2>&1

REM Deny device access for specific device
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{52079E78-A92B-413F-B213-E8FE35712E72}" /t REG_SZ /v "Value" /d "Deny" /f >nul 2>&1

REM Configure app privacy settings for notifications
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessNotifications" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessNotifications_UserInControlOfTheseApps" /t REG_MULTI_SZ /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessNotifications_ForceAllowTheseApps" /t REG_MULTI_SZ /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessNotifications_ForceDenyTheseApps" /t REG_MULTI_SZ /f >nul 2>&1

REM Deny appointments access
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appointments" /v "Value" /d "Deny" /t REG_SZ /f >nul 2>&1

REM Deny appointments access for specific device
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{D89823BA-7180-4B81-B50C-7E471E6121A3}" /t REG_SZ /v "Value" /d "Deny" /f >nul 2>&1

REM Configure app privacy settings for calendar
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessCalendar" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessCalendar_UserInControlOfTheseApps" /t REG_MULTI_SZ /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessCalendar_ForceAllowTheseApps" /t REG_MULTI_SZ /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessCalendar_ForceDenyTheseApps" /t REG_MULTI_SZ /f >nul 2>&1

REM Deny phone call history access
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCallHistory" /v "Value" /d "Deny" /t REG_SZ /f >nul 2>&1

REM Deny phone call history access for specific device
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{8BC668CF-7728-45BD-93F8-CF2B3B41D7AB}" /t REG_SZ /v "Value" /d "Deny" /f >nul 2>&1

REM Configure app privacy settings for call history
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessCallHistory" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessCallHistory_UserInControlOfTheseApps" /t REG_MULTI_SZ /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessCallHistory_ForceAllowTheseApps" /t REG_MULTI_SZ /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessCallHistory_ForceDenyTheseApps" /t REG_MULTI_SZ /f >nul 2>&1

REM Deny email access
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\email" /v "Value" /d "Deny" /t REG_SZ /f >nul 2>&1

REM Deny email access for specific device
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{9231CB4C-BF57-4AF3-8C55-FDA7BFCC04C5}" /t REG_SZ /v "Value" /d DENY /f >nul 2>&1

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
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{992AFA70-6F47-4148-B3E9-3003349C1548}" /t REG_SZ /v "Value" /d "Deny" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{21157C1F-2651-4CC1-90CA-1F28B02263F6}" /t REG_SZ /v "Value" /d "Deny" /f >nul 2>&1

REM Configure app privacy settings for messaging
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessMessaging" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessMessaging_UserInControlOfTheseApps" /t REG_MULTI_SZ /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessMessaging_ForceAllowTheseApps" /t REG_MULTI_SZ /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessMessaging_ForceDenyTheseApps" /t REG_MULTI_SZ /f >nul 2>&1

REM Deny radios access
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\radios" /v "Value" /d "Deny" /t REG_SZ /f >nul 2>&1

REM Deny radios access for specific device
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{A8804298-2D5F-42E3-9531-9C8C39EB29CE}" /t REG_SZ /v "Value" /d DENY /f >nul 2>&1

REM Configure app privacy settings for radios
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessRadios" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessRadios_UserInControlOfTheseApps" /t REG_MULTI_SZ /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessRadios_ForceAllowTheseApps" /t REG_MULTI_SZ /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessRadios_ForceDenyTheseApps" /t REG_MULTI_SZ /f >nul 2>&1

REM Deny Bluetooth synchronization
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\bluetoothSync" /v "Value" /d "Deny" /t REG_SZ /f >nul 2>&1

REM Deny library access: documents, pictures, videos
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\documentsLibrary" /v "Value" /d "Deny" /t REG_SZ /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\picturesLibrary" /v "Value" /d "Deny" /t REG_SZ /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\videosLibrary" /v "Value" /d "Deny" /t REG_SZ /f >nul 2>&1

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
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v "Value" /t REG_SZ /d "Deny" /f >nul 2>&1

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
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "CanCortanaBeEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "CortanaEnabled" /t REG_DWORD /d 0 /f  >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "CortanaEnabled" /t REG_DWORD /d 0 /f  >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowCortanaButton" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "CortanaInAmbientMode" /t REG_DWORD /d 0 /f >nul 2>&1

REM Disable search history
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "HistoryViewEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "DeviceHistoryEnabled" /t REG_DWORD /d 0 /f >nul 2>&1

REM Disable voice activation above lock screen
reg add "HKCU\Software\Microsoft\Speech_OneCore\Preferences" /v "VoiceActivationOn" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Speech_OneCore\Preferences" /v "VoiceActivationDefaultOn" /t REG_DWORD /d 0 /f >nul 2>&1
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
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d "0" /f  >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v "DisabledByGroupPolicy" /t REG_DWORD /d "1" /f >nul 2>&1

REM Disable Windows content delivery for specific IDs
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338393Enabled" /d "0" /t REG_DWORD /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353694Enabled" /d "0" /t REG_DWORD /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353696Enabled" /d "0" /t REG_DWORD /f >nul 2>&1

REM Disable Windows Spotlight and cloud content
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableSoftLanding" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsSpotlightFeatures" /t "REG_DWORD" /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t "REG_DWORD" /d "1" /f >nul 2>&1

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
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\SettingSync" /v "SyncPolicy" /t REG_DWORD /d 5 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableApplicationSettingSync" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableApplicationSettingSyncUserOverride" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableAppSyncSettingSync" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableAppSyncSettingSyncUserOverride" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableCredentialsSettingSync" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableCredentialsSettingSyncUserOverride" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Credentials" /v "Enabled" /t REG_DWORD /d 0 /f >nul 2>&1
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
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Language" /t REG_DWORD /v "Enabled" /d 0 /f >nul 2>&1

REM Disable Online Speech Recognition
reg add "HKCU\Software\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy" /v "HasAccepted" /t "REG_DWORD" /d 0 /f >nul 2>&1

REM Disable Network Connectivity Status Indicator (NCSI) Active Probing
reg add "HKLM\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters\Internet" /v "EnableActiveProbing" /t REG_DWORD /d "0" /f >nul 2>&1

REM Disable System Initiated User Feedback (SIUF)
reg add "HKCU\Software\Microsoft\Personalization\Settings" /v "AcceptedPrivacyPolicy" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t REG_DWORD /d 0 /f  >nul 2>&1
reg delete "HKCU\Software\Microsoft\Siuf\Rules" /v "PeriodInNanoSeconds" /f >nul 2>&1


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
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\HandwritingErrorReports" /v "PreventHandwritingErrorReports" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Policies\Microsoft\Windows\TabletPC" /v "PreventHandwritingDataSharing" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\TabletPC" /v "PreventHandwritingDataSharing" /t REG_DWORD /d 1 /f >nul 2>&1

REM Disable Input Personalization
reg add "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" /v "AllowInputPersonalization" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\InputPersonalization\TrainedDataStore" /v "HarvestContacts" /t REG_DWORD /d 0 /f >nul 2>&1

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
reg add "HKCU\Software\Microsoft\Input\TIPC" /v "Enabled" /t REG_DWORD /d 0 /f >nul 2>&1

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
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WCN\UI" /v "DisableWcnUi" /t REG_DWORD /d 1 /f >nul 2>&1

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
reg add "HKLM\SOFTWARE\Policies\Microsoft\VisualStudio\SQM" /v "OptIn" /t REG_DWORD /d 0 /f >nul 2>&1
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
reg add "HKCU\Software\Microsoft\Office\15.0\Outlook\Options\Mail" /v "EnableLogging" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Office\16.0\Outlook\Options\Mail" /v "EnableLogging" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Office\15.0\Outlook\Options\Calendar" /v "EnableCalendarLogging" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Office\16.0\Outlook\Options\Calendar" /v "EnableCalendarLogging" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Office\15.0\Word\Options" /v "EnableLogging" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Office\16.0\Word\Options" /v "EnableLogging" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Policies\Microsoft\Office\15.0\OSM" /v "EnableLogging" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Policies\Microsoft\Office\16.0\OSM" /v "EnableLogging" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Policies\Microsoft\Office\15.0\OSM" /v "EnableUpload" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Policies\Microsoft\Office\16.0\OSM" /v "EnableUpload" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Office\Common\ClientTelemetry" /v "DisableTelemetry" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Office\16.0\Common\ClientTelemetry" /v "DisableTelemetry" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Office\Common\ClientTelemetry" /v "VerboseLogging" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Office\16.0\Common\ClientTelemetry" /v "VerboseLogging" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Office\15.0\Common" /v "QMEnable" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Office\16.0\Common" /v "QMEnable" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Office\15.0\Common\Feedback" /v "Enabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Office\16.0\Common\Feedback" /v "Enabled" /t REG_DWORD /d 0 /f >nul 2>&1
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
reg add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "UsageTracking" /t REG_DWORD /d 0 /f >nul 2>&1
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
reg add "HKLM\SOFTWARE\Piriform\CCleaner" /v "(Cfg)HealthCheck" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Piriform\CCleaner" /v "(Cfg)QuickClean" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Piriform\CCleaner" /v "(Cfg)QuickCleanIpm" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Piriform\CCleaner" /v "(Cfg)GetIpmForTrial" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Piriform\CCleaner" /v "(Cfg)SoftwareUpdater" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Piriform\CCleaner" /v "(Cfg)SoftwareUpdaterIpm" /t REG_DWORD /d 0 /f >nul 2>&1
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
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\MpEngine" /v "MpEnablePus" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "PUAProtection" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\MpEngine" /v "EnableFileHashComputation" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "ServiceKeepAlive" /t REG_DWORD /d "1" /f >nul 2>&1

REM Disable Windows Defender Exploit Guard Network Protection and Controlled Folder Access.
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'DisableAutoExclusions'; $value = $True; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -DisableAutoExclusions $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Exclusions" /v "DisableAutoExclusions" /t reg_DWORD /d "1" /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'DisableBlockAtFirstSeen'; $value = $True; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -DisableBlockAtFirstSeen $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\SpyNet" /v "DisableBlockAtFirstSeen" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\MpEngine" /v "MpBafsExtendedTimeout" /t REG_DWORD /d 50 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\MpEngine" /v "MpCloudBlockLevel" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Signature Updates" /v "SignatureDisableNotification" /t REG_DWORD /d 0 /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'MAPSReporting'; $value = '0'; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -MAPSReporting $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v "SpynetReporting" /t REG_DWORD /d "0" /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'SubmitSamplesConsent'; $value = '2'; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -SubmitSamplesConsent $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v "SubmitSamplesConsent" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\MRT" /v "DontReportInfectionInformation" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Signature Updates" /v "RealtimeSignatureDelivery" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\Network Protection" /v "EnableNetworkProtection" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\Controlled Folder Access" /v "EnableControlledFolderAccess" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\NIS" /v "DisableProtocolRecognition" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\NIS\Consumers\IPS" /v "DisableSignatureRetirement" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\NIS\Consumers\IPS" /v "ThrottleDetectionEventsRate" /t REG_DWORD /d "10000000" /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'DisableRealtimeMonitoring'; $value = $True; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -DisableRealtimeMonitoring $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRealtimeMonitoring" /t REG_DWORD /d "1" /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'DisableIntrusionPreventionSystem'; $value = $True; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -DisableIntrusionPreventionSystem $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableIntrusionPreventionSystem" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableInformationProtectionControl" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableScanOnRealtimeEnable" /t REG_DWORD /d "1" /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'DisableBehaviorMonitoring'; $value = $True; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -DisableBehaviorMonitoring $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableBehaviorMonitoring" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRawWriteNotification" /t REG_DWORD /d "1" /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'DisableIOAVProtection'; $value = $True; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -DisableIOAVProtection $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableIOAVProtection" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "IOAVMaxSize" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableOnAccessProtection" /t REG_DWORD /d "1" /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'RealTimeScanDirection'; $value = '1'; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -RealTimeScanDirection $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "RealTimeScanDirection" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableRoutinelyTakingAction" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Remediation" /v "Scan_ScheduleDay" /t REG_DWORD /d "8" /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'RemediationScheduleDay'; $value = '8'; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -RemediationScheduleDay $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'UnknownThreatDefaultAction'; $value = '9'; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -UnknownThreatDefaultAction $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Threats" /v "Threats_ThreatSeverityDefaultAction" /t "REG_DWORD" /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Threats\ThreatSeverityDefaultAction" /v "5" /t "REG_SZ" /d "9" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Threats\ThreatSeverityDefaultAction" /v "4" /t "REG_SZ" /d "9" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Threats\ThreatSeverityDefaultAction" /v "3" /t "REG_SZ" /d "9" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Threats\ThreatSeverityDefaultAction" /v "2" /t "REG_SZ" /d "9" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Threats\ThreatSeverityDefaultAction" /v "1" /t "REG_SZ" /d "9" /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'QuarantinePurgeItemsAfterDelay'; $value = '1'; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -QuarantinePurgeItemsAfterDelay $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Quarantine" /v "PurgeItemsAfterDelay" /t REG_DWORD /d "1" /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'CheckForSignaturesBeforeRunningScan'; $value = $False; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -CheckForSignaturesBeforeRunningScan $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" /v "CheckForSignaturesBeforeRunningScan" /t REG_DWORD /d "0" /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'DisableRestorePoint'; $value = $True; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -DisableRestorePoint $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" /v "DisableRestorePoint" /t REG_DWORD /d "1" /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'ScanPurgeItemsAfterDelay'; $value = '1'; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -ScanPurgeItemsAfterDelay $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" /v "PurgeItemsAfterDelay" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" /v "MissedScheduledScanCountBeforeCatchup" /t REG_DWORD /d "20" /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'DisableCatchupFullScan'; $value = $True; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -DisableCatchupFullScan $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" /v "DisableCatchupFullScan" /t REG_DWORD /d "1" /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'DisableCatchupQuickScan'; $value = $True; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -DisableCatchupQuickScan $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" /v "DisableCatchupQuickScan" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" /v "DisableHeuristics" /t REG_DWORD /d "1" /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'ScanOnlyIfIdleEnabled'; $value = $True; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -ScanOnlyIfIdleEnabled $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" /v "ScanOnlyIfIdle" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\MRT" /v "DontOfferThroughWUAU" /t REG_DWORD /d 1 /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'ScanAvgCPULoadFactor'; $value = '1'; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -ScanAvgCPULoadFactor $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" /v "AvgCPULoadFactor" /t REG_DWORD /d "1" /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'DisableCpuThrottleOnIdleScans'; $value = $False; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -DisableCpuThrottleOnIdleScans $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" /v "DisableCpuThrottleOnIdleScans" /t REG_DWORD /d "0" /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'DisableEmailScanning'; $value = $True; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -DisableEmailScanning $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" /v "DisableEmailScanning" /t REG_DWORD /d "1" /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'DisableScriptScanning'; $value = $True; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -DisableScriptScanning $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" /v "DisableReparsePointScanning" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" /v "DisableScanningMappedNetworkDrivesForFullScan" /t REG_DWORD /d "1" /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'DisableScanningMappedNetworkDrivesForFullScan'; $value = $True; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -DisableScanningMappedNetworkDrivesForFullScan $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" /v "DisableScanningNetworkFiles" /t REG_DWORD /d "1" /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'DisableScanningNetworkFiles'; $value = $True; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -DisableScanningNetworkFiles $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" /v "DisablePackedExeScanning" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" /v "DisableRemovableDriveScanning" /t REG_DWORD /d "1" /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'DisableRemovableDriveScanning'; $value = $True; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -DisableRemovableDriveScanning $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" /v "DisableArchiveScanning" /t REG_DWORD /d "1" /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'DisableArchiveScanning'; $value = $True; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -DisableArchiveScanning $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" /v "ArchiveMaxDepth" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" /v "ArchiveMaxSize" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" /v "ScheduleDay" /t REG_DWORD /d "8" /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'ScanScheduleDay'; $value = '8'; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -ScanScheduleDay $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "RandomizeScheduleTaskTimes" /t REG_DWORD /d "0" /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'RandomizeScheduleTaskTimes'; $value = $False; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -RandomizeScheduleTaskTimes $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" /v "ScanParameters" /t REG_DWORD /d "1" /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'ScanParameters'; $value = '1'; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -ScanParameters $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" /v "QuickScanInterval" /t REG_DWORD /d "24" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Signature Updates" /v "DisableScanOnUpdate" /t REG_DWORD /d "1" /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'DisableGradualRelease'; $value = $True; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -DisableGradualRelease $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'EngineUpdatesChannel'; $value = 'Broad'; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -EngineUpdatesChannel $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'PlatformUpdatesChannel'; $value = 'Broad'; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -PlatformUpdatesChannel $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'DefinitionUpdatesChannel'; $value = 'Broad'; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -DefinitionUpdatesChannel $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Signature Updates" /v "ForceUpdateFromMU" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Signature Updates" /v "DisableScheduledSignatureUpdateOnBattery" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Signature Updates" /v "UpdateOnStartUp" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Signature Updates" /v "SignatureUpdateCatchupInterval" /t REG_DWORD /d "0" /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'SignatureUpdateCatchupInterval'; $value = '0'; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -SignatureUpdateCatchupInterval $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Signature Updates" /v "ASSignatureDue" /t REG_DWORD /d 4294967295 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Signature Updates" /v "AVSignatureDue" /t REG_DWORD /d 4294967295 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Signature Updates" /v "DisableUpdateOnStartupWithoutEngine" /t REG_DWORD /d 1 /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'SignatureDisableUpdateOnStartupWithoutEngine'; $value = $True; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -SignatureDisableUpdateOnStartupWithoutEngine $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Signature Updates" /v "ScheduleDay" /t REG_DWORD /d "8" /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'SignatureScheduleDay'; $value = '8'; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -SignatureScheduleDay $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Signature Updates" /v "SignatureUpdateInterval" /t REG_DWORD /d 24 /f >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "$propertyName = 'SignatureUpdateInterval'; $value = '24'; if((Get-MpPreference -ErrorAction Ignore).$propertyName -eq $value) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is already `"^""$value`"^"" as desired."^""; exit 0; }; $command = Get-Command 'Set-MpPreference' -ErrorAction Ignore; if (!$command) {; Write-Warning 'Skipping. Command not found: "^""Set-MpPreference"^"".'; exit 0; }; if(!$command.Parameters.Keys.Contains($propertyName)) {; Write-Host "^""Skipping. `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; }; try {; Invoke-Expression "^""$($command.Name) -Force -$propertyName `$value -ErrorAction Stop"^""; Set-MpPreference -Force -SignatureUpdateInterval $value -ErrorAction Stop; Write-Host "^""Successfully set `"^""$propertyName`"^"" to `"^""$value`"^""."^""; exit 0; } catch {; if ( $_.FullyQualifiedErrorId -like '*0x800106ba*') {; Write-Warning "^""Cannot $($command.Name): Defender service (WinDefend) is not running. Try to enable it (revert) and re-run this?"^""; exit 0; } elseif (($_ | Out-String) -like '*Cannot convert*') {; Write-Host "^""Skipping. Argument `"^""$value`"^"" for property `"^""$propertyName`"^"" is not supported for `"^""$($command.Name)`"^""."^""; exit 0; } else {; Write-Error "^""Failed to set using $($command.Name): $_"^""; exit 1; }; }" >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Signature Updates" /v "CheckAlternateHttpLocation" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Signature Updates" /v "CheckAlternateDownloadLocation" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Control\WMI\Autologger\DefenderApiLogger" /v "Start" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Control\WMI\Autologger\DefenderAuditLogger" /v "Start" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Windows Defender/Operational" /v "Enabled" /t Reg_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Windows Defender/WHC" /v "Enabled" /t Reg_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Reporting" /v "DisableGenericRePorts" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Reporting" /v "WppTracingLevel" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\AppHVSI" /v "AuditApplicationGuard" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Systray" /v "HideSystray" /t REG_DWORD /d "1" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Classes\CLSID\{09A47860-11B0-4DA5-AFA5-26D86198A780}\InprocServer32" /va /f  >nul 2>&1
reg delete "HKCR\CLSID\{09A47860-11B0-4DA5-AFA5-26D86198A780}" /v "InprocServer32" /f  >nul 2>&1
reg delete "HKCR\*\shellex\ContextMenuHandlers" /v "EPP" /f  >nul 2>&1
reg delete "HKCR\Directory\shellex\ContextMenuHandlers" /v "EPP" /f  >nul 2>&1
reg delete "HKCR\Drive\shellex\ContextMenuHandlers" /v "EPP" /f  >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "SecurityHealth" /f  >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\UX Configuration" /v "UILockdown" /t REG_DWORD /d "1" /f >nul 2>&1
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
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.SecurityAndMaintenance" /v "Enabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Policies\Microsoft\Windows Defender\UX Configuration" /v "Notification_Suppress" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows Defender\UX Configuration" /v "Notification_Suppress" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\UX Configuration" /v "SuppressRebootNotification" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Notifications" /v "DisableNotifications" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows Defender Security Center\Notifications" /v "DisableNotifications" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Notifications" /v "DisableEnhancedNotifications" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows Defender Security Center\Notifications" /v "DisableEnhancedNotifications" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Reporting" /v "DisableEnhancedNotifications" /t REG_DWORD /d "1" /f >nul 2>&1
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
reg add "HKCU\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\PhishingFilter" /v "EnabledV9" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\PhishingFilter" /v "PreventOverride" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "SmartScreenEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "PreventSmartScreenPromptOverride" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\0" /v "2301" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\SmartScreen" /v "ConfigureAppInstallControl" /t REG_SZ /d "Anywhere" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\SmartScreen" /v "ConfigureAppInstallControlEnabled" /t "REG_DWORD" /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /t REG_DWORD /d "0" /f >nul 2>&1
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
reg add "HKCU\Software\Policies\Microsoft\Windows\CurrentVersion\PushNotifications" /v "NoTileApplicationNotification" /t REG_DWORD /d 1 /f >nul 2>&1

REM Hide recent files in Explorer
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "NoUseStoreOpenWith" /t REG_DWORD /d 1 /f >nul 2>&1

REM Delete specific folder delegate for HomeFolderDesktop
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowRecent" /d 0 /t "REG_DWORD" /f >nul 2>&1

REM Delete specific folder delegate for HomeFolderDesktop (64-bit only)
if not %PROCESSOR_ARCHITECTURE%==x86 ( REM is 64 bit?
    reg delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\HomeFolderDesktop\NameSpace\DelegateFolders\{3134ef9c-6b18-4996-ad04-ed5912e00eb5}" /f >nul 2>&1
)

REM Disable sync provider notifications
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSyncProviderNotifications" /d 0 /t REG_DWORD /f >nul 2>&1

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





if "%Valorant%"=="false" goto skippingvalorant
:: Initialize the root directory for search
set "rootDir=C:\Users\voj\AppData\Local\VALORANT\Saved\Config"

:: Initialize the target file name
set "targetFile=GameUserSettings.ini"

:: Initialize a flag variable to indicate whether the file was found
set "fileFound=false"

:: Check if the root directory exists
if not exist "%rootDir%\" (
    REM echo Root directory does not exist or cannot be accessed.
    goto EndScript
)  >nul 2>&1

:: Recursive search for the file
for /r "%rootDir%" %%a in (%targetFile%) do (
    if exist "%%~fa" (
        REM echo File found at: %%~fa
        set "fileFound=true"
        
        :: Define a temporary file name
        set "tempFile=%%~dpaTempGameUserSettings.ini"

        :: Create a new GameUserSettings.ini file with the specified content
        > "!tempFile!" (
            echo [/Script/ShooterGame.ShooterGameUserSettings]
            echo bShouldLetterbox=False
            echo bLastConfirmedShouldLetterbox=False
            echo bUseVSync=False
            echo bUseDynamicResolution=False
            echo ResolutionSizeX=1920
            echo ResolutionSizeY=1080
            echo LastUserConfirmedResolutionSizeX=1920
            echo LastUserConfirmedResolutionSizeY=1080
            echo WindowPosX=0
            echo WindowPosY=0
            echo LastConfirmedFullscreenMode=0
            echo PreferredFullscreenMode=0
            echo AudioQualityLevel=0
            echo LastConfirmedAudioQualityLevel=0
            echo FrameRateLimit=0.000000
            echo DesiredScreenWidth=1920
            echo DesiredScreenHeight=1080
            echo LastUserConfirmedDesiredScreenWidth=1920
            echo LastUserConfirmedDesiredScreenHeight=1080
            echo.
            echo [/Script/Engine.GameUserSettings]
            echo bUseDesiredScreenHeight=False
            echo.
            echo [ScalabilityGroups]
            echo sg.ResolutionQuality=100.000000
            echo sg.ViewDistanceQuality=2
            echo sg.AntiAliasingQuality=2
            echo sg.ShadowQuality=2
            echo sg.PostProcessQuality=2
            echo sg.TextureQuality=2
            echo sg.EffectsQuality=2
            echo sg.FoliageQuality=2
            echo sg.ShadingQuality=2
            echo.
            echo [ShaderPipelineCache.CacheFile]
            echo LastOpened=ShooterGame
        ) 

        :: Rename the original file and replace with the new file
        move /y "%%~fa" "%%~dpaGameUserSettings.ini.old"  >nul 2>&1
        move /y "!tempFile!" "%%~fa"  >nul 2>&1
    ) >nul 2>&1
) >nul 2>&1

:: Check if the file was not found
if "%fileFound%"=="false" (
    REM echo File not found.
) 

:: End of script
:EndScript
:skippingvalorant







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

