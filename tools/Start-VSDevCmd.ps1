$vswhere = "$PSScriptRoot\vswhere.exe"
$installationPath = & $vswhere -prerelease -latest -property installationPath
Write-Host $installationPath
if ($installationPath -and (test-path "$installationPath\Common7\Tools\vsdevcmd.bat")) {
  & "${env:COMSPEC}" /s /c "`"$installationPath\Common7\Tools\vsdevcmd.bat`" -no_logo && set" | foreach-object {
    $name, $value = $_ -split '=', 2
    set-content env:\"$name" $value
  }
}

# Adapted from https://github.com/Microsoft/vswhere/wiki/Start-Developer-Command-Prompt