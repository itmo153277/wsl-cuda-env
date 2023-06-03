@Echo off

Verify Extentions >nul 2>&1
SetLocal EnableExtensions
If ErrorLevel 1 GoTo Unsupported

Path %~dp0;%PATH%
Set ScriptName=%~nx0
Set ScriptPath=%~dp0

Call :Tool cscript.exe
Call :Tool wsl.exe

If Not Exist install MkDir install
Call :InstallAlpine
Call :InstallUbuntu
Call :UninstallAlpine

EndLocal
Echo Press any key to exit
Pause >nul
GoTo :EOF

:: Call :InstallUbuntu
::
:: Install ubuntu
:InstallUbuntu
If Not Exist install\ubuntu MkDir install\ubuntu
Call :ExecuteShow wsl -d alpine docker create --name ubuntu ubuntu:focal
Call :ExecuteShow wsl -d alpine sh -c "docker export ubuntu > install/ubuntu/image.tar"
Call :ExecuteShow wsl --import ubuntu-cuda install\ubuntu install\ubuntu\image.tar --version 2
PushD "%ScriptPath%"
Call :ExecuteShow wsl -d ubuntu-cuda bash init-ubuntu.sh
PopD
Call :ExecuteShow wsl --terminate ubuntu-cuda
GoTo :EOF

:: Call :InstallAlpine
::
:: Install alpine linux
:InstallAlpine
Call :Echo Installing Alpine Linux
If Not Exist install\alpine MkDir install\alpine
Call :Download https://dl-cdn.alpinelinux.org/alpine/v3.18/releases/x86_64/alpine-minirootfs-3.18.0-x86_64.tar.gz install\alpine\image.tar.gz
Call :ExecuteShow wsl --import alpine install\alpine install\alpine\image.tar.gz --version 2
PushD "%ScriptPath%"
Call :ExecuteShow wsl -d alpine sh init-alpine.sh
PopD
GoTo :EOF

:: Call :UninstallAlpine
::
:: Uninstall alpine linux
:UninstallAlpine
Call :Echo Uninstalling Alpine Linux
Call :ExecuteShow wsl --unregister alpine
RmDir /S/Q install\alpine
GoTo :EOF

:: Call :Download url target
::
:: Download file from url to target
:Download
Call :Execute cscript /nologo "%ScriptPath%\download.vbs" %*
Goto :EOF

:: Call :ExecuteShow cmd
::
:: Execute and show command cmd
:ExecuteShow
Call :Echo Execute: %*
GoTo Execute

:: Call :Execute cmd
::
:: Execute command cmd
:Execute
Copy nul nul >nul
%*
If ErrorLevel 1 GoTo Execute_Error
GoTo :EOF
:Execute_Error
(
  Call :Echo Error %ErrorLevel%
  Pause >nul
  Exit %ErrorLevel%
)

:: Call :Tool tool_name
::
:: Ensure tool_name is in the %PATH%
:Tool
SetLocal
Set oldPath=%PATH%
Set newToolPath=
:Tool_Check
If Not Exist "%newToolPath%\*" (
  For /F "delims=" %%a In ("%newToolPath%") Do Set newToolPath=%%~dpa
)
If Not "%newToolPath%" == "" Path %oldPath%;%newToolPath%
For /F "delims=" %%a In ("%~1") Do Set foundPath=%%~f$PATH:a
If "%foundPath%" == "" GoTo :Tool_Prompt
Call :Echo Found %~1: %foundPath%
(
  EndLocal
  Call :SetPath "%PATH%"
)
GoTo :EOF
:Tool_Prompt
Set /p newToolPath="Enter path to %~1: "
Set newToolPath=%newToolPath:"=%
GoTo Tool_Check

:: Call :SetPath path
::
:: Set %PATH% to path
:SetPath
set PATH=%~1
GoTo :EOF

:: Call :Echo msg
::
:: Print msg
:Echo
Echo [%ScriptName%] %*
GoTo :EOF

:Unsupported
Echo Unsupported COMMAND.COM
Pause >nul
