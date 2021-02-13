$distPath = ".\dist"
$name = (Get-Content package.json) -join "`n" | ConvertFrom-Json | Select-Object -ExpandProperty "name"
$version = (Get-Content package.json) -join "`n" | ConvertFrom-Json | Select-Object -ExpandProperty "version"

If(!(Test-Path $distPath))
{
      New-Item -ItemType Directory -Force -Path $distPath
}

if (Test-Path $distPath\$name-v$version.aseprite-extension) 
{
  Remove-Item $distPath\$name-v$version.aseprite-extension
}

Compress-Archive ./src/es.ini $distPath\$name-v$version.zip -update
Compress-Archive ./package.json $distPath\$name-v$version.zip -update

Rename-Item $distPath\$name-v$version.zip -NewName "$name-v$version.aseprite-extension"

Write-Output "Extension Generada Correctamente [$distPath\$name-v$version.aseprite-extension]"