$packageName = 'DotNetCLI'
$fileType = 'msi'
$silentArgs = '/quiet'
$url = 'https://dotnetcli.blob.core.windows.net/dotnet/dev/Installers/Latest/dotnet-win-x64.latest.msi'
$version = '1.0.0'

function CheckDotNetCliInstalled {

    $registryPath = 'HKLM:\SOFTWARE\dotnet\Setup'
    if (Test-Path $registryPath) {
        $installedversion =  (Get-ItemProperty -Path $key -Name Version).Version
        if($installedversion.StartsWith($version)) {
            return $true
        }
    }
}

if (CheckDotNetCliInstalled) {
    Write-Host "Microsoft .Net CLI is already installed on your machine."
}
elseif (Get-ProcessorBits(32)){
    throw "32 bit Microsoft .Net CLI is not yet available."
}
else {
	Install-ChocolateyPackage $packageName $fileType $silentArgs $url
}
