# wsl-docker
Installation script to install docker in Windows subsystem for Linux


Copy into WSL and run with sudo ./wsl-install.sh.
If you cannot run, then add the executable flag by using the command: chmod +x wsl-install.sh

WSL Version 2
    WSL 2 is only available in Windows 10 builds 18917 or higher
    To check the build version of Windows 10, run the command "ver" in command prompt.
    Output: `Microsoft Windows [Version 10.0.19041.153]` 19041 is the build version.
    Convert current WSL distros to WSL 2:
        `wsl --list`
        `wsl --set-version <Distro> 2`
    Set WSL 2 as the default WSL version:
        `wsl --set-default-version 2`
