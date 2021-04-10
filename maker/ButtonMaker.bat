@echo off

rem ########## FILL IN VARIABLES BELOW ##########

rem # the name of your .exe file and shortcut
set button_name=MyLightButtonExample

rem # actual message content data
set mqtt_topic=desktop/button/light
set mqtt_data=on

rem # usually one time only setup
set device_name=desktop
set host_address=192.168.1.1
set user_login=your-broker-login
set user_pass=your-broker-password

rem ########## FILL IN VARIABLES ABOVE ##########

mkdir "compiled"
cd "compiled"
call pyinstaller -w -F "%cd%\..\..\src\main.py"

cd dist
ren main.exe %button_name%.exe

set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"
echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "%cd%\%button_name%.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "%cd%\%button_name%.exe" >> %SCRIPT%
echo oLink.Arguments = "%device_name% %host_address% %user_login% %user_pass% %mqtt_topic% %mqtt_data%" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%
cscript /nologo %SCRIPT%
del %SCRIPT%

move %button_name%.lnk ../..

pause 