@ECHO OFF

TITLE Automatically connect to a Wi-Fi network when in Safe Mode With Networking
ECHO ^+---------------------------------------------------------------------^+
ECHO ^|          Automatically connect to a Wi-Fi network when in           ^|
ECHO ^|                      Safe Mode with Networking                      ^|
ECHO ^|                                V1.0                                 ^|
ECHO ^+---------------------------------------------------------------------^+
ECHO ^| This script is supposed to circumvent a ^"bug^" that Microsoft        ^|
ECHO ^| obviously forgot it exists. Safe Mode with Networking IS supposed   ^|
ECHO ^| to be just that^: a minimal boot environment with a fully working    ^|
ECHO ^| networking layer.                                                   ^|
ECHO ^|                                                                     ^|
ECHO ^| Well, as far sa Microsoft is concerned, Wi-Fi apparently isn^'t a    ^|
ECHO ^| part of the networking layer. Some systems have the WLAN AutoConfig ^|
ECHO ^| service set to Manual, even if the OS is installed on a laptop and  ^|
ECHO ^| it obviously has a Wi-Fi adapter. Sure, the service boots up when   ^|
ECHO ^| the drivers load and you try to connect to an access point          ^|
ECHO ^| ^(network^), but that^'s when the OS is booted in regular mode ^(not    ^|
ECHO ^| Safe Mode with Networking^).                                         ^|
ECHO ^|                                                                     ^|
ECHO ^| Not only that but Microsoft considers this a FAD, LOL ^:D. According ^|
ECHO ^| to them, not having Wi-Fi access while in Safe Mode with Networking ^|
ECHO ^| is a FAD... I had no idea that Wi-Fi adapters are not networking    ^|
ECHO ^| equpment, LOL ^:D.                                                   ^|
ECHO ^|                                                                     ^|
ECHO ^| Let^'s say you have to do something for a client remotely in Safe    ^|
ECHO ^| Mode. You^'re thinking ^"Hmmm... Safe Mode with Networking^? Should    ^|
ECHO ^| work, right ^:)^?^". Incorrect! On some installs, the service won^'t    ^|
ECHO ^| run Automatically, on other installs, you have to manually connect  ^|
ECHO ^| to the Wi-Fi network that the rig ^(laptop^/PC^) was connected to      ^|
ECHO ^| while the OS was booted in regular mode... which basically means    ^|
ECHO ^| that, if there^'s no one at the other end that you can instruct how  ^|
ECHO ^| to help you connect the rig to the internet, you can^'t continue     ^|
ECHO ^| working on the damn thing. Not only that, but since you probably    ^|
ECHO ^| booted in Safe Mode with Networking through msconfig ^(Win ^+ R --^>   ^|
ECHO ^| msconfig --^> Enter --^> Boot tab --^> Boot options --^> Safe boot --^>  ^|
ECHO ^| Network^), when the person that^'s using the laptop^/PC sits in front  ^|
ECHO ^| of it and thinks the problem you were working on is solved and now  ^|
ECHO ^| he^/she can finally get some work done, guess what... they^'re stuck  ^|
ECHO ^| in Safe Mode with Networking. Yep, no matter how many times they    ^|
ECHO ^| reboot the rig, the setting is permanent unless you manually change ^|
ECHO ^| it back to not boot in any kind of Safe Mode. And how are you       ^|
ECHO ^| supposed to do that if you can^'t actually remote in and switch it   ^|
ECHO ^| back. See what I^'m getting at. You have to harass the client ^(who   ^|
ECHO ^| might not be tech savvy at all^), send videos or screenshots on how  ^|
ECHO ^| to configure back the rig to boot in normal mode, and not only      ^|
ECHO ^| that, but the problem you were working on is not solved^! You can    ^|
ECHO ^| imagine how pissed off you^'d be if this happened to you... I know I ^|
ECHO ^| would be.                                                           ^|
ECHO ^|                                                                     ^|
ECHO ^| Sorry for the rant, but I just had to vent since it has happened to ^|
ECHO ^| me on a number or occasions and I^'m getting pretty tired of having  ^|
ECHO ^| to explain to clients that it^'s not actually my fault, it^'s         ^|
ECHO ^| Microsoft^'s fault.                                                  ^|
ECHO ^|                                                                     ^|
ECHO ^| Anyhow, run the script once to install the ^"hack^" ^(with             ^|
ECHO ^| administrative privileges, right click --^> Run as administrator^)    ^|
ECHO ^| that removes the ^"bug^", run it again to remove the changes and      ^|
ECHO ^| revert everything back to the way it was ^(once again, with          ^|
ECHO ^| administrative privileges^). A detailed explanation on what          ^|
ECHO ^| information the script will need as input follows.                  ^|
ECHO ^+---------------------------------------------------------------------^+
ECHO.
PAUSE
CLS

:: Making sure the WLAN AutoConfig service is running and set to Automatic.

SC.exe CONFIG WlanSvc START= AUTO >NUL 2>&1
SC.exe START WlanSvc >NUL 2>&1
SC.exe FAILURE WlanSvc ACTIONS= RESTART/60000/RESTART/60000// RESET= 0 >NUL 2>&1
REG.exe ADD "HKLM\SYSTEM\CurrentControlSet\services\WlanSvc" /V Start /T REG_DWORD /D 2 /F >NUL 2>&1

:: Some instructions.

ECHO Enter the SSID (the display name) and the profile name (in most cases,
ECHO they're the same) of the Wi-Fi network you'd like to automatically
ECHO connect to when in Safe Mode with Networking.
ECHO.
ECHO Remember, you're supposed to be already connected to this network while
ECHO you're in normal operating mode, i.e. if the network is protected (has
ECHO a password), you should've already entered the password and connected
ECHO to this network at least once while runnung the OS in normal mode.
ECHO.
ECHO Caption does matter, so make sure you type in the SSID (name) and the
ECHO profile name of the network correctly. For example, ^"Wi-Fi_NetWork^"
ECHO is not the same as ^"wi-fi_network^".
ECHO.
ECHO If you're not sure what's the SSID's name and the profile name of the
ECHO Wi-Fi network, run the ^"NETSH.exe WLAN SHOW ALL^" (without the double
ECHO quotes) command in a command line (Win + R --^> cmd --^> Enter). The
ECHO information you're looking for is in the ^"SHOW PROFILES NAME=*^" part
ECHO of the command's output. An example output follows.
ECHO.
ECHO ---------------------------- EXAMPLE START ----------------------------
ECHO.
ECHO =======================================================================
ECHO ========================== SHOW PROFILES NAME=* =======================
ECHO =======================================================================
ECHO.
ECHO.
ECHO Profile EXAMPLE-NETWORK on interface Wi-Fi: 
ECHO =======================================================================
ECHO.
ECHO Applied: All User Profile    
ECHO.
ECHO Profile information 
ECHO ------------------- 
ECHO    Version                : 1
ECHO    Type                   : Wireless LAN
ECHO    Name                   : EXAMPLE-NETWORK
ECHO    Control options        : 
ECHO        Connection mode    : Connect automatically
ECHO        Network broadcast  : Connect only if this network is
ECHO                             broadcasting
ECHO        AutoSwitch         : Do not switch to other networks
ECHO.
ECHO Connectivity settings 
ECHO --------------------- 
ECHO    Number of SSIDs        : 1
ECHO    SSID name              : ^"EXAMPLE-NETWORK^"
ECHO    Network type           : Infrastructure
ECHO    Radio type             : [ Any Radio Type ]
ECHO    Vendor extension       : Not present
ECHO.
ECHO Security settings 
ECHO ----------------- 
ECHO    Authentication         : WPA-Personal
ECHO    Cipher                 : TKIP
ECHO    Security key           : Present
ECHO.
ECHO Cost settings 
ECHO ------------- 
ECHO    Cost                   : Unrestricted
ECHO    Congested              : No
ECHO    Approaching Data Limit : No
ECHO    Over Data Limit        : No
ECHO    Roaming                : No
ECHO    Cost Source            : Default
ECHO.
ECHO ---------------------------- EXAMPLE END ------------------------------
ECHO.
ECHO What you need is the string in the ^"Name:^" row (that's the Wi-Fi
ECHO network's profile name) and the the ^"SSID name:^" row (that's the SSID
ECHO of the Wi-Fi access point). In this example, the profile's name is
ECHO ^"EXAMPLE-NETWORK^" and the SSID is ^"EXAMPLE-NETWORK^" as well (in
ECHO both cases, without the double quotes). As I've stated previously, in
ECHO most cases, they're the same, but double check to see if they are using
ECHO the command I mentioned earlier.
ECHO.
ECHO -----------------------------------------------------------------------
ECHO.

:: Checking if the registry value that starts up the script has already been
:: modified by something else (some other program perhaps) and asks the user
:: if he/she want's to save that registry value so that he/she can import it
:: later. The script doesn't automatically import this value when removing
:: the hack because in most cases, malware modifies this key so that it can
:: start automatically something during Windows startup.

ECHO Let's make a few registry checks before we continue.
ECHO.
ECHO -----------------------------------------------------------------------
ECHO.
GOTO REGCHECK1

:: Checking if the value in Shell is explorer.exe.

:REGCHECK1

SETLOCAL ENABLEDELAYEDEXPANSION >NUL 2>&1
FOR /F "USEBACKQ TOKENS=3" %%G IN (`REG.exe QUERY "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V "Shell" 2^>NUL ^| FIND.exe "Shell"`) DO (SET SHLVAL1=%%G)
IF "%SHLVAL1%"=="explorer.exe" (
ECHO The current registry data for the Shell value is as it should be,
ECHO ^"%SHLVAL1%^". Proceeding with changing this registry vale with the
ECHO following data^: ^"%SHLVAL1%, wfautcon.bat^".
ECHO.
REG.exe ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V Shell /T REG_SZ /D "explorer.exe, wfautcon.bat" /F >NUL 2>&1
ECHO Done.
ECHO.
GOTO PROMPTCRED
) ELSE (GOTO REGCHECK2)

:: Checking if you've already ran the script before, so remove the data
:: "explorer.exe, wfautcon.bat" and restore the original value
:: "explorer.exe".

:REGCHECK2

FOR /F "USEBACKQ TOKENS=3,4 DELIMS=, " %%G IN (`REG.exe QUERY "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V "Shell" 2^>NUL ^| FIND.exe "Shell"`) DO (SET SHLVAL2=%%G, %%H)
IF "%SHLVAL2%"=="explorer.exe, wfautcon.bat" (
ECHO You've already installed the registry hack. Restoring back original
ECHO registry value data and removing logon script.
REG.exe ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V Shell /T REG_SZ /D "explorer.exe" /F >NUL 2>&1
TAKEOWN.exe /F "%SYSTEMROOT%\wfautcon.bat" >NUL 2>&1
DEL /F /Q "%SYSTEMROOT%\wfautcon.bat" >NUL 2>&1
ERASE /F /Q "%SYSTEMROOT%\wfautcon.bat" >NUL 2>&1
ECHO.
ECHO Done.
ECHO.
GOTO SCRIPTEND
) ELSE (GOTO REGCHECK3)

:: This is a check if the data in Shell is something other than
:: "expplorer.exe" or "explorer.exe, wfautcon.bat". If it is, ask to save
:: the value as a .reg file for importing later on, after the script is ran
:: for a second time to delete "wfautcon.bat" and restore the default data
:: "explorer.exe" in Shell in the Winlogon key.

:REGCHECK3

REG.exe EXPORT "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" "%SYSTEMROOT%\Temp\Winlogon.reg" /Y >NUL 2>&1
FOR /F "USEBACKQ TOKENS=2 DELIMS=^=" %%G IN (`FIND.exe /I """Shell""=" "%SYSTEMROOT%\Temp\Winlogon.reg"`) DO (SET SHLVAL3=%%G)
IF %SHLVAL3%=="explorer.exe" (GOTO PROMPTCRED) ELSE (GOTO SHELLDATA)

:: OK, so the data in Shell differs from either "explorer.exe" or
:: "explorer.exe, wfautcon.bat". Let's see what you'd like to do next.

:SHELLDATA

ECHO The Shell value data in the Winlogon key is^:
ECHO.
ECHO ^"Shell^"^=%SHLVAL3%
ECHO.
ECHO This value data isn't standard and you probably shouldn't have that in
ECHO your Shell value. Most commmon cause for having a nonstandard data in
ECHO the Shell value is malware. If you're absolutely sure that this data
ECHO has nothing to do with malware^/viruses and that there is a legitimate
ECHO reason for having this data in the Shell value, you can choose to save
ECHO this data as a registry file ^(.reg file^) so that you can import it
ECHO later when you run this script for a second time to remove the ^"hack^".
ECHO The file will be saved in the same directory from where you're running
ECHO this script from.
ECHO.

TAKEOWN.exe /F "%SYSTEMROOT%\Temp\Winlogon.reg" >NUL 2>&1
DEL /F /Q "%SYSTEMROOT%\Temp\Winlogon.reg" >NUL 2>&1
ERASE /F /Q "%SYSTEMROOT%\Temp\Winlogon.reg" >NUL 2>&1

CHOICE.exe /M "Would you like to save this value as a .reg file"
ECHO.
IF /I %ERRORLEVEL%==1 (GOTO SAVEREGVAL)
IF /I %ERRORLEVEL%==2 (GOTO NOTSAVEREGVAL) ELSE (GOTO SCRIPTEND)

:: Save the registry data to a .reg file and ask if you'd like to proceed
:: running the script or not.

:SAVEREGVAL

ECHO Backing up registry data.
ECHO.

TAKEOWN.exe /F "%~dp0Winlogon-Backup.reg" >NUL 2>&1
DEL /F /Q "%~dp0Winlogon-Backup.reg" >NUL 2>&1
ERASE /F /Q "%~dp0Winlogon-Backup.reg" >NUL 2>&1

ECHO | SET /P DUMMYVAR5="Windows Registry Editor Version 5.00">>"%~dp0Winlogon-Backup.reg"
ECHO.>>"%~dp0Winlogon-Backup.reg"
ECHO.>>"%~dp0Winlogon-Backup.reg"
ECHO | SET /P DUMMYVAR6="[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon]">>"%~dp0Winlogon-Backup.reg"
ECHO.>>"%~dp0Winlogon-Backup.reg"
ECHO | SET /P DUMMYVAR7=""Shell"=%SHLVAL3%">>"%~dp0Winlogon-Backup.reg"
ECHO Done.
ECHO.
ECHO OK, now that the registry data is backed up, you can either proceed
ECHO with installing this ^"hack^" or leave everything as it is and just
ECHO exit.
ECHO.
CHOICE.exe /M "Would you like to proceed with installing this ""hack"""
ECHO.
IF /I %ERRORLEVEL%==1 (GOTO REGCHANGE)
IF /I %ERRORLEVEL%==2 (GOTO SCRIPTEND) ELSE (GOTO SCRIPTEND)

:: Don't save the registry data and ask if you'd like to proceed running the
:: script or not.

:NOTSAVEREGVAL

ECHO OK, since you've opted not to backup^/save the registry data, you can
ECHO proceed with installing the ^"hack^"... just remember that that data
ECHO might be crucial. Take a look at the data once again before you make
ECHO your choice.
ECHO.
CHOICE.exe /M "Would you like to proceed with installing this ""hack"""
ECHO.
IF /I %ERRORLEVEL%==1 (GOTO REGCHANGE)
IF /I %ERRORLEVEL%==2 (GOTO SCRIPTEND) ELSE (GOTO SCRIPTEND)

:: Change registry value from "explorer.exe" to
:: "explorer.exe, wfautcon.bat".

:REGCHANGE

ECHO.
ECHO Proceeding with changing this registry vale with this data^:
ECHO ^"explorer.exe, wfautcon.bat^".
REG.exe ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V Shell /T REG_SZ /D "explorer.exe, wfautcon.bat" /F >NUL 2>&1
ECHO.
ECHO Done.
ECHO.
GOTO PROMPTCRED

:: Prompt for Wi-Fi profile name and SSID.

:PROMPTCRED

ECHO -----------------------------------------------------------------------
ECHO.
ECHO Now, you'll be prompted to enter the Wi-Fi profile's name and SSDI.
ECHO.
SET /P PRONAME="Wi-Fi Profile Name: "
ECHO.
SET /P SSIDN="Wi-Fi SSID: "
ECHO.
ECHO -----------------------------------------------------------------------
ECHO.

:: Generating the startup script that's supposed to automatically connect to
:: the desired Wi-Fi network.

TAKEOWN.exe /F "%SYSTEMROOT%\wfautcon.bat" >NUL 2>&1
DEL /F /Q "%SYSTEMROOT%\wfautcon.bat" >NUL 2>&1
ERASE /F /Q "%SYSTEMROOT%\wfautcon.bat" >NUL 2>&1

ECHO Generating script.
ECHO @ECHO OFF>>"%SYSTEMROOT%\wfautcon.bat"
ECHO.>>"%SYSTEMROOT%\wfautcon.bat"
ECHO TITLE Connecting to ^^^"%SSIDN%^^^" Wi-Fi Network>>"%SYSTEMROOT%\wfautcon.bat"
ECHO.>>"%SYSTEMROOT%\wfautcon.bat"
ECHO ECHO Connecting to ^^^"%SSIDN%^^^" Wi-Fi Network...>>"%SYSTEMROOT%\wfautcon.bat"
ECHO.>>"%SYSTEMROOT%\wfautcon.bat"
ECHO | SET /P DUMMYVAR1="TIMEOUT.exe /T 30 /NOBREAK >NUL 2>&1">>"%SYSTEMROOT%\wfautcon.bat"
ECHO.>>"%SYSTEMROOT%\wfautcon.bat"
ECHO.>>"%SYSTEMROOT%\wfautcon.bat"
ECHO | SET /P DUMMYVAR2="SC.exe START WlanSvc >NUL 2>&1">>"%SYSTEMROOT%\wfautcon.bat"
ECHO.>>"%SYSTEMROOT%\wfautcon.bat"
ECHO.>>"%SYSTEMROOT%\wfautcon.bat"
ECHO | SET /P DUMMYVAR3="NETSH.exe WLAN CONNECT NAME="%PRONAME%" SSID="%SSIDN%" >NUL 2>&1">>"%SYSTEMROOT%\wfautcon.bat"
ECHO.>>"%SYSTEMROOT%\wfautcon.bat"
ECHO.>>"%SYSTEMROOT%\wfautcon.bat"
ECHO | SET /P DUMMYVAR4="ECHO Done!">>"%SYSTEMROOT%\wfautcon.bat"
ECHO.
ECHO Done.
ECHO.
GOTO SCRIPTEND

:: End of the script.

:SCRIPTEND
ECHO -----------------------------------------------------------------------
ECHO.
SETLOCAL DISABLEDELAYEDEXPANSION >NUL 2>&1
ECHO Batch script end. Press any key to exit.
ECHO.
PAUSE
