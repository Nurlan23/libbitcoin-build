if (Test-Path env:DevEnvDir) {
  Write-Host "Dev environment variables already set, skipping"
  # prevent environment variables to altered more than once
  # since it causes PATH, or other var, is always appended
  return
}

$vswhere = "$PSScriptRoot\vswhere.exe"
$installationPath = & $vswhere -prerelease -latest -property installationPath
if ($installationPath -and (test-path "$installationPath\Common7\Tools\vsdevcmd.bat")) {
  & "${env:COMSPEC}" /s /c "`"$installationPath\Common7\Tools\vsdevcmd.bat`" -no_logo && set" | foreach-object {
    $name, $value = $_ -split '=', 2
    set-content env:\"$name" $value
  }
}
else {
  Write-Error "Couldn't set dev environment variables"
}

# Adapted from https://github.com/Microsoft/vswhere/wiki/Start-Developer-Command-Prompt