# No Brand MoCap — fetch new arms' clips into the repo (run from the repo folder)
# Downloads cameras 1, 3, 6 for Charlie Russell, Bowen Brantingham, Marcus Downing.
# Self-fetches access from Qualisys (public) so nothing expires. Safe to re-run.
$ErrorActionPreference = 'Stop'
Set-Location -Path $PSScriptRoot
$angles = @(1,3,6)
$jobs = @(
  @{ id='SdszsSwkR'; prefix='view-pitch-rh-markerless'; nums=@(1,2,3,4,5,6,7,8,9,10,11,12,13) },   # Charlie Russell
  @{ id='smrtw7gHd'; prefix='view-pitch-rh-markerless'; nums=@(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18) }, # Bowen Brantingham
  @{ id='dTPyMAcLI'; prefix='view-pitch-rh-markerless'; nums=@(1,2,3,4,5,6,7,8,9) }                 # Marcus Downing
)
foreach ($j in $jobs) {
  Write-Host ("Fetching {0} ..." -f $j.id)
  $rep = Invoke-RestMethod -UseBasicParsing "https://report.qualisys.com/api/v2/report/$($j.id)"
  $sig = Invoke-RestMethod -UseBasicParsing "https://report.qualisys.com/api/v2/report/$($j.id)/resource/signature"
  $q = "Policy=$([uri]::EscapeDataString($sig.params.Policy))&Key-Pair-Id=$([uri]::EscapeDataString($sig.params.'Key-Pair-Id'))&Signature=$([uri]::EscapeDataString($sig.params.Signature))"
  $base = $rep.dataPath
  $dir = Join-Path "videos" $j.id
  New-Item -ItemType Directory -Force -Path $dir | Out-Null
  $count = 0
  foreach ($n in $j.nums) {
    foreach ($a in $angles) {
      $f = "$($j.prefix)-$n-$a.mp4"
      $url = $base + $f + "?" + $q
      Invoke-WebRequest -UseBasicParsing -Uri $url -OutFile (Join-Path $dir $f)
      $count++
    }
  }
  Write-Host ("  {0}: {1} clips downloaded" -f $j.id, $count)
}
Write-Host ""
Write-Host "All clips downloaded. Next, push it live:"
Write-Host "  git add -A"
Write-Host "  git commit -m ""Add Charlie Russell, Bowen Brantingham, Marcus Downing"""
Write-Host "  git push"
