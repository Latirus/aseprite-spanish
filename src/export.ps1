$name = (Get-Content package.json) -join "`n" | ConvertFrom-Json | Select-Object -ExpandProperty "name"
$version = (Get-Content package.json) -join "`n" | ConvertFrom-Json | Select-Object -ExpandProperty "version"

if (Test-Path ./dist/$name-$version.aseprite-extension) 
{
  Remove-Item ./dist/$name-$version.aseprite-extension
}

Compress-Archive ./src/es.ini ./dist/$name-$version.zip -update
Compress-Archive ./package.json ./dist/$name-$version.zip -update

Rename-Item .\dist\$name-$version.zip -NewName "$name-$version.aseprite-extension"

Write-Output "Extension Generada Correctamente [.\dist\$name-$version.aseprite-extension]"