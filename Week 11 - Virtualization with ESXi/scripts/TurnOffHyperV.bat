
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

echo Disabling Core Isolation, Hyper-V, Windows Virtualization Features, and WSL...

:: 1. Disable Core Isolation (Memory Integrity)
:: In Windows 11, Core Isolation and Memory Integrity might be handled differently.
:: This setting is controlled by the registry key.
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v "Enabled" /t REG_DWORD /d 0 /f

:: 2. Disable Hyper-V (For Windows 11, it's important to disable all relevant virtualization features)
dism.exe /Online /Disable-Feature /FeatureName:Microsoft-Hyper-V /NoRestart
dism.exe /Online /Disable-Feature /FeatureName:HypervisorPlatform /NoRestart
dism.exe /Online /Disable-Feature /FeatureName:VirtualMachinePlatform /NoRestart
dism.exe /Online /Disable-Feature /FeatureName:Containers /NoRestart

:: 3. Disable Windows Subsystem for Linux (WSL)
:: Trying the correct feature name for WSL
dism.exe /Online /Disable-Feature /FeatureName:Microsoft-Windows-Subsystem-Linux /NoRestart
dism.exe /Online /Disable-Feature /FeatureName:Microsoft-Windows-Subsystem-Linux-Optional /NoRestart

:: 4. Additional check to ensure Hyper-V services are stopped (only if they exist)
echo Stopping Hyper-V services...

:: Check and stop vmms service if available
sc query vmms > nul 2>&1 && (
    sc stop vmms
    sc config vmms start= disabled
) || echo vmms service not found.

:: Check and stop hvsocket service if available
sc query hvsocket > nul 2>&1 && (
    sc stop hvsocket
    sc config hvsocket start= disabled
) || echo hvsocket service not found.

:: Check and stop hvservice service if available
sc query hvservice > nul 2>&1 && (
    sc stop hvservice
    sc config hvservice start= disabled
) || echo hvservice service not found.

echo Done.

echo You must reboot your computer for these changes to take effect.
choice /M "Do you want to reboot now? (Y/N)" /T 10 /D Y
if errorlevel 2 goto noreboot
if errorlevel 1 shutdown /r /t 5
goto end

:noreboot
echo Reboot later to apply changes.

:end
pause