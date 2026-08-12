# Usage: drop images into gallery\images then run generate-gallery.ps1
# Generates gallery-list.json with an array of { name, path } entries
$galleryDir = Join-Path -Path $PSScriptRoot -ChildPath 'gallery\images'
if (-not (Test-Path $galleryDir)) {
    New-Item -ItemType Directory -Path $galleryDir | Out-Null
    Write-Output "Created folder: $galleryDir"
}
$list = @()
Get-ChildItem -Path $galleryDir -File -Include *.png,*.jpg,*.jpeg,*.gif,*.webp | ForEach-Object {
    $rel = Join-Path -Path 'gallery\images' -ChildPath $_.Name
    $list += @{ name = $_.Name; path = $rel }
}
$json = $list | ConvertTo-Json -Depth 3
Set-Content -Path (Join-Path $PSScriptRoot 'gallery-list.json') -Value $json -Encoding UTF8
Write-Output "gallery-list.json updated with $($list.Count) items"