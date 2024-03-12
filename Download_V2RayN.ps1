<#
 .SYNOPSIS

 .SCRIPT NAME                : GetV2RayN
                            
 .AUTHOR                     : MICHELE-TN
                            
 .NOTES                      : V2RayN — Checks the release version, downloads it, configures it in English and runs it.
#>

Function GetV2RayN([bool]$PreRelease, [string]$FileName){

    $repo = "2dust/v2rayN"
    $filenamePattern = "*zz_v2rayN-With-Core-SelfContained.7z"
    $UriPattern = "*/" +
                  $Vs  +
                  "/*"

    #https://api.github.com/repos/2dust/v2rayN/releases

    if ($PreRelease) {
        $releasesUri = "https://api.github.com/repos/$repo/releases"   # Nightly version!!!
        
        [Net.ServicePointManager]::SecurityProtocol = "Tls, Tls11, Tls12, Ssl3"
        $downloadUri = ((Invoke-RestMethod -Method GET -Uri $releasesUri).assets | Where-Object { $_.name -like $filenamePattern  -and  $_.browser_download_url -like $UriPattern}).browser_download_url
    } else {
        $releasesUri = "https://api.github.com/repos/$repo/releases/latest" # Latest version!!!
       
        [Net.ServicePointManager]::SecurityProtocol = "Tls, Tls11, Tls12, Ssl3"
        $downloadUri = ((Invoke-RestMethod -Method GET -Uri $releasesUri).assets | Where-Object name -like $filenamePattern ).browser_download_url
    }
    
    Invoke-WebRequest -Uri $downloadUri -Out $FileName -ErrorAction Stop
}

Function ConfigV2RayN(){


$nl = [Environment]::NewLine
$n2 = $nl + $nl

$CustomConfig  = '{'+
'  "indexId": null,'+
'  "subIndexId": null,'+
'  "sysProxyType": 0,'+
'  "systemProxyExceptions": null,'+
'  "systemProxyAdvancedProtocol": null,'+
'  "coreBasicItem": {'+
'    "logEnabled": false,'+
'    "loglevel": "warning",'+
'    "muxEnabled": false,'+
'    "defAllowInsecure": false,'+
'    "defFingerprint": null,'+
'    "defUserAgent": null'+
'  },'+
'  "tunModeItem": {'+
'    "enableTun": false,'+
'    "strictRoute": true,'+
'    "stack": null,'+
'    "mtu": 9000,'+
'    "enableExInbound": false,'+
'    "enableIPv6Address": true'+
'  },'+
'  "kcpItem": {'+
'    "mtu": 1350,'+
'    "tti": 50,'+
'    "uplinkCapacity": 12,'+
'    "downlinkCapacity": 100,'+
'    "congestion": false,'+
'    "readBufferSize": 2,'+
'    "writeBufferSize": 2'+
'  },'+
'  "grpcItem": {'+
'    "idle_timeout": 60,'+
'    "health_check_timeout": 20,'+
'    "permit_without_stream": false,'+
'    "initial_windows_size": 0'+
'  },'+
'  "routingBasicItem": {'+
'    "domainStrategy": "AsIs",'+
'    "domainStrategy4Singbox": null,'+
'    "domainMatcher": null,'+
'    "routingIndexId": "5049855252020194081",'+
'    "enableRoutingAdvanced": true'+
'  },'+
'  "guiItem": {'+
'    "autoRun": false,'+
'    "enableStatistics": false,'+
'    "keepOlderDedupl": false,'+
'    "ignoreGeoUpdateCore": true,'+
'    "autoUpdateInterval": 10,'+
'    "checkPreReleaseUpdate": false,'+
'    "enableSecurityProtocolTls13": false,'+
'    "trayMenuServersLimit": 20,'+
'    "enableHWA": false,'+
'    "enableLog": true'+
'  },'+
'  "uiItem": {'+
'    "enableAutoAdjustMainLvColWidth": true,'+
'    "enableUpdateSubOnlyRemarksExist": false,'+
'    "mainWidth": 900,'+
'    "mainHeight": 700,'+
'    "mainGirdHeight1": 254,'+
'    "mainGirdHeight2": 254,'+
'    "colorModeDark": false,'+
'    "followSystemTheme": false,'+
'    "colorPrimaryName": null,'+
'    "currentLanguage": "en",'+
'    "currentFontFamily": null,'+
'    "currentFontSize": 0,'+
'    "enableDragDropSort": false,'+
'    "doubleClick2Activate": false,'+
'    "autoHideStartup": true,'+
'    "mainMsgFilter": null,'+
'    "mainColumnItem": ['+
'      {'+
'        "Name": "configType",'+
'        "Width": 80,'+
'        "Index": 0'+
'      },'+
'      {'+
'        "Name": "remarks",'+
'        "Width": 150,'+
'        "Index": 1'+
'      },'+
'      {'+
'        "Name": "address",'+
'        "Width": 120,'+
'        "Index": 2'+
'      },'+
'      {'+
'        "Name": "port",'+
'        "Width": 60,'+
'        "Index": 3'+
'      },'+
'      {'+
'        "Name": "network",'+
'        "Width": 100,'+
'        "Index": 4'+
'      },'+
'      {'+
'        "Name": "streamSecurity",'+
'        "Width": 100,'+
'        "Index": 5'+
'      },'+
'      {'+
'        "Name": "subRemarks",'+
'        "Width": 100,'+
'        "Index": 6'+
'      },'+
'      {'+
'        "Name": "delayVal",'+
'        "Width": 100,'+
'        "Index": 7'+
'      },'+
'      {'+
'        "Name": "speedVal",'+
'        "Width": 100,'+
'        "Index": 8'+
'      },'+
'      {'+
'        "Name": "todayUp",'+
'        "Width": -1,'+
'        "Index": 9'+
'      },'+
'      {'+
'        "Name": "todayDown",'+
'        "Width": -1,'+
'        "Index": 10'+
'      },'+
'      {'+
'        "Name": "totalUp",'+
'        "Width": -1,'+
'        "Index": 11'+
'      },'+
'      {'+
'        "Name": "totalDown",'+
'        "Width": -1,'+
'        "Index": 12'+
'      }'+
'    ]'+
'  },'+
'  "constItem": {'+
'    "defIEProxyExceptions": "localhost;127.*;10.*;172.16.*;172.17.*;172.18.*;172.19.*;172.20.*;172.21.*;172.22.*;172.23.*;172.24.*;172.25.*;172.26.*;172.27.*;172.28.*;172.29.*;172.30.*;172.31.*;192.168.*",'+
'    "subConvertUrl": ""'+
'  },'+
'  "speedTestItem": {'+
'    "speedTestTimeout": 10,'+
'    "speedTestUrl": "https://speed.cloudflare.com/__down?bytes=100000000",'+
'    "speedPingTestUrl": "https://www.google.com/generate_204"'+
'  },'+
'  "mux4SboxItem": {'+
'    "protocol": "h2mux",'+
'    "max_connections": 4'+
'  },'+
'  "hysteriaItem": {'+
'    "up_mbps": 100,'+
'    "down_mbps": 100'+
'  },'+
'  "inbound": ['+
'    {'+
'      "localPort": 10808,'+
'      "protocol": "socks",'+
'      "udpEnabled": true,'+
'      "sniffingEnabled": true,'+
'      "routeOnly": false,'+
'      "allowLANConn": false,'+
'      "newPort4LAN": false,'+
'      "user": null,'+
'      "pass": null'+
'    }'+
'  ],'+
'  "globalHotkeys": null,'+
'  "coreTypeItem": null'+
'}'
Set-Content .\MK\zz_v2rayN-With-Core-SelfContained\guiConfigs\guiNConfig.json $CustomConfig
}


# MAIN ***********************************************************  //>>
cls
# Run as administrator and stays in the current directory
if (-Not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
        Start-Process PowerShell -Verb RunAs -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"cd '$pwd'; & '$PSCommandPath';`"";
    }
}


$Vs = Read-Host -Prompt "Enter the release version you want to download"  #6.38

switch ($Vs){

    #GetV2RayN 1 V2RayN_$Vs.7z
    #GetV2RayN 0 V2RayN_latest.7z

    {$Vs -match '\d.\d{2,2}'} { ################
                                try {
                                            $Response = GetV2RayN 1 V2RayN_$Vs.7z
                                            # This will only execute if the Invoke-WebRequest is successful.
                                            #$StatusCode = $Response.StatusCode
                                } catch [System.Exception] {
                                            #$StatusCode = $_.Exception.Response.StatusCode.value__
                                            Write-Host ''
                                            clear
                                            Write-Host 'Release version does not exists!! '
                                            exit
                                }
                                ################
                              }

    {$Vs -match 'latest'}     {Write-Host 'latest'
                               GetV2RayN 0 V2RayN_latest.7z}

    Default                   {Write-Host ''
                               Write-Host 'Release version does not match pattern!!  —>  \d.\d{2,2}'
                               exit
                                    
                              }
}


# Check if Exists 7Zip4PowerShell..  ***************************************//>>
if (Get-Module -ListAvailable -Name 7Zip4PowerShell) {
    Write-Host "Module exists"
    #   Extract 7zip file
    $sourcefile = ".\V2RayN_"+$Vs+".7z"
    Expand-7Zip -ArchiveFileName $sourcefile -TargetPath '.\MK\'
} 
else {
    Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
    Set-PSRepository -Name 'PSGallery' -SourceLocation "https://www.powershellgallery.com/api/v2" -InstallationPolicy Trusted
    Install-Module -Name 7Zip4PowerShell -Force
    #   Extract 7zip file
    $sourcefile = ".\V2RayN_"+$Vs+".7z"
    Expand-7Zip -ArchiveFileName $sourcefile -TargetPath '.\MK\'
}
# Check if Exists 7Zip4PowerShell..  ***************************************//<<


Start-Process .\MK\zz_v2rayN-With-Core-SelfContained\v2rayN.exe

Start-Sleep -Seconds 3
taskkill /im v2rayN.exe /f
Start-Sleep -Seconds 3

Remove-Item .\MK\zz_v2rayN-With-Core-SelfContained\guiConfigs\guiNConfig.json
New-Item .\MK\zz_v2rayN-With-Core-SelfContained\guiConfigs\guiNConfig.json
ConfigV2RayN


Start-Process .\MK\zz_v2rayN-With-Core-SelfContained\v2rayN.exe
# MAIN ***********************************************************  //<<