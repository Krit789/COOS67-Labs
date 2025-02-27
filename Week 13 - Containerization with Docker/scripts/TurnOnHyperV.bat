@echo off

:: Ensure admin privileges
fltmc >nul 2>&1 || (
    echo Administrator privileges are required.
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        echo Right-click on the script and select "Run as administrator".
        pause & exit 1
    )
    exit 0
)

echo Enabling Core Isolation, Hyper-V, Windows Virtualization Features, and WSL...

:: 1. Enable Core Isolation (Memory Integrity)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v "Enabled" /t REG_DWORD /d 1 /f

:: 2. Enable Hyper-V and related virtualization features
dism.exe /Online /Enable-Feature /FeatureName:Microsoft-Hyper-V /All /NoRestart
dism.exe /Online /Enable-Feature /FeatureName:HypervisorPlatform /NoRestart
dism.exe /Online /Enable-Feature /FeatureName:VirtualMachinePlatform /NoRestart
dism.exe /Online /Enable-Feature /FeatureName:Containers /NoRestart

:: 3. Enable Windows Subsystem for Linux (WSL)
dism.exe /Online /Enable-Feature /FeatureName:Microsoft-Windows-Subsystem-Linux /NoRestart

:: 4. Enable WSL 2
:: This is done directly through wsl command if available
where wsl >nul 2>&1 && (
    echo Enabling WSL 2...
    wsl --set-default-version 2
) || echo WSL command not found. Install WSL manually after reboot.

:: 5. Enable Hyper-V services
echo Starting Hyper-V services...

:: Check and enable vmms service if available
sc query vmms >nul 2>&1 && (
    sc config vmms start= auto
    sc start vmms
) || echo vmms service not found.

:: Check and enable hvsocket service if available
sc query hvsocket >nul 2>&1 && (
    sc config hvsocket start= auto
    sc start hvsocket
) || echo hvsocket service not found.

:: Check and enable hvservice service if available
sc query hvservice >nul 2>&1 && (
    sc config hvservice start= auto
    sc start hvservice
) || echo hvservice service not found.

echo Done.
echo You need to reboot your computer for these changes to take effect.
echo After rebooting, you should be able to install Docker Desktop with WSL2.

choice /M "Do you want to reboot now? (Y/N)" /T 10 /D Y
if errorlevel 2 goto noreboot
if errorlevel 1 shutdown /r /t 5
goto end

:noreboot
echo Reboot later to apply changes.

:end
pause