@echo off
echo Disabling Core Isolation, Hyper-V, Windows Virtualization Features, and WSL...

:: 1. Disable Core Isolation (Memory Integrity)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v "Enabled" /t REG_DWORD /d 0 /f

:: 2. Disable Hyper-V
dism.exe /Online /Disable-Feature /FeatureName:Microsoft-Hyper-V /All
dism.exe /Online /Disable-Feature /FeatureName:HypervisorPlatform /All

:: 3. Disable Windows Virtualization Platform Features
dism.exe /Online /Disable-Feature /FeatureName:VirtualMachinePlatform /All
dism.exe /Online /Disable-Feature /FeatureName:Containers /All

:: 4. Disable Windows Subsystem for Linux
dism.exe /Online /Disable-Feature /FeatureName:Microsoft-Windows-Subsystem-Linux /All

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