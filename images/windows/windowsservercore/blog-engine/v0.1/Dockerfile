FROM microsoft/windowsservercore

RUN powershell -Command Add-WindowsFeature Web-Server

RUN powershell -Command Add-WindowsFeature NET-Framework-45-ASPNET

RUN powershell -Command Add-WindowsFeature Web-Asp-Net45

RUN mkdir C:\aspnet

ADD ./app /aspnet

RUN icacls C:\aspnet /grant Everyone:(OI)(CI)F
RUN icacls C:\aspnet /grant "IIS APPPOOL\DefaultAppPool":(OI)(CI)F

RUN powershell -NoProfile -Command \
    Import-module IISAdministration; \
    New-IISSite -Name "ASPNET" -PhysicalPath C:\aspnet -BindingInformation "*:8000:"

EXPOSE 8000

CMD ["ping", "localhost", "-t"]