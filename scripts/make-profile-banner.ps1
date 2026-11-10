#Requires -Version 5.1
[CmdletBinding()]
param(
  [string]$Output = ''
)

$ErrorActionPreference = 'Stop'
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoRoot = Split-Path -Parent $scriptDir
if (-not $Output) { $Output = Join-Path $repoRoot 'assets\profile-banner.png' }

Add-Type -AssemblyName System.Drawing

$W = 1280
$H = 340
$bmp = New-Object System.Drawing.Bitmap $W, $H
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::ClearTypeGridFit
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic

function New-RoundedPath([float]$x, [float]$y, [float]$w, [float]$h, [float]$r) {
  $p = New-Object System.Drawing.Drawing2D.GraphicsPath
  $d = $r * 2
  $p.AddArc($x, $y, $d, $d, 180, 90)
  $p.AddArc($x + $w - $d, $y, $d, $d, 270, 90)
  $p.AddArc($x + $w - $d, $y + $h - $d, $d, $d, 0, 90)
  $p.AddArc($x, $y + $h - $d, $d, $d, 90, 90)
  $p.CloseFigure()
  return $p
}

function New-Brush([string]$hex, [int]$alpha = 255) {
  $c = [System.Drawing.ColorTranslator]::FromHtml($hex)
  return New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb($alpha, $c.R, $c.G, $c.B))
}

function Draw-ProjectCard([float]$x, [float]$y, [float]$w, [float]$h, [float]$angle, [string]$accent, [string]$tag, [string]$title, [string]$sub) {
  $state = $g.Save()
  $g.TranslateTransform($x + $w / 2, $y + $h / 2)
  $g.RotateTransform($angle)
  $g.TranslateTransform(-($x + $w / 2), -($y + $h / 2))

  $shadow = New-RoundedPath ($x + 8) ($y + 10) $w $h 18
  $g.FillPath((New-Brush '#000000' 100), $shadow)
  $shadow.Dispose()

  $panel = New-RoundedPath $x $y $w $h 18
  $g.FillPath((New-Brush '#131b2a' 252), $panel)
  $g.DrawPath((New-Object System.Drawing.Pen ([System.Drawing.ColorTranslator]::FromHtml($accent), 1.2)), $panel)

  $tagFont = New-Object System.Drawing.Font('Segoe UI Semibold', 11, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Pixel)
  $g.DrawString($tag, $tagFont, (New-Brush $accent), ($x + 18), ($y + 15))

  $titleFont = New-Object System.Drawing.Font('Segoe UI Semibold', 18, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Pixel)
  $g.DrawString($title, $titleFont, (New-Brush '#e9edf6'), ($x + 18), ($y + 38))

  $subFont = New-Object System.Drawing.Font('Segoe UI', 12, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Pixel)
  $g.DrawString($sub, $subFont, (New-Brush '#68748c'), ($x + 18), ($y + 66))

  $g.Restore($state)
  $panel.Dispose()
  $tagFont.Dispose(); $titleFont.Dispose(); $subFont.Dispose()
}

# Background
$bgRect = New-Object System.Drawing.Rectangle 0, 0, $W, $H
$bg = New-Object System.Drawing.Drawing2D.LinearGradientBrush $bgRect, ([System.Drawing.Color]::FromArgb(11, 14, 20)), ([System.Drawing.Color]::FromArgb(21, 29, 46)), 20
$g.FillRectangle($bg, $bgRect)

# Soft glows
$g.FillEllipse((New-Brush '#7cf2c0' 20), 880, -300, 700, 700)
$g.FillEllipse((New-Brush '#8f9dff' 18), -300, 120, 700, 700)
$g.FillEllipse((New-Brush '#ffc46b' 10), 500, -240, 520, 520)

# Dot grid
for ($x = 40; $x -lt $W; $x += 34) {
  for ($y = 34; $y -lt $H; $y += 34) {
    $g.FillEllipse((New-Brush '#ffffff' 7), $x, $y, 2, 2)
  }
}

# Monogram tile
$logo = New-RoundedPath 64 62 86 86 22
$g.FillPath((New-Brush '#121a29'), $logo)
$g.DrawPath((New-Object System.Drawing.Pen ([System.Drawing.ColorTranslator]::FromHtml('#7cf2c0'), 2)), $logo)
$logoFont = New-Object System.Drawing.Font('Cascadia Mono', 29, [System.Drawing.FontStyle]::Bold, [System.Drawing.GraphicsUnit]::Pixel)
$sf = New-Object System.Drawing.StringFormat
$sf.Alignment = [System.Drawing.StringAlignment]::Center
$sf.LineAlignment = [System.Drawing.StringAlignment]::Center
$g.DrawString('YS', $logoFont, (New-Brush '#7cf2c0'), (New-Object System.Drawing.RectangleF 64, 62, 86, 86), $sf)

# Name and headline
$nameFont = New-Object System.Drawing.Font('Segoe UI Semibold', 52, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Pixel)
$g.DrawString('Youssef Sadquy', $nameFont, (New-Brush '#e9edf6'), 178, 58)

$taglineFont = New-Object System.Drawing.Font('Segoe UI Semibold', 23, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Pixel)
$g.DrawString('Software engineer, London', $taglineFont, (New-Brush '#7cf2c0'), 182, 128)

$descFont = New-Object System.Drawing.Font('Segoe UI', 18, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Pixel)
$g.DrawString('Web applications  |  desktop tools  |  3D experiences', $descFont, (New-Brush '#97a3ba'), 182, 170)

# Chips
$chips = @(
  @{ text = 'C#'; color = '#8f9dff' },
  @{ text = 'JavaScript'; color = '#f2d06b' },
  @{ text = 'Unity'; color = '#7cf2c0' },
  @{ text = 'Firebase'; color = '#ffc46b' }
)
$chipFont = New-Object System.Drawing.Font('Segoe UI Semibold', 12, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Pixel)
$cx = 182
foreach ($chip in $chips) {
  $size = $g.MeasureString($chip.text, $chipFont)
  $cw = [math]::Ceiling($size.Width) + 26
  $path = New-RoundedPath $cx 224 $cw 32 16
  $g.FillPath((New-Brush $chip.color 24), $path)
  $g.DrawPath((New-Object System.Drawing.Pen ([System.Drawing.ColorTranslator]::FromHtml($chip.color), 1)), $path)
  $g.DrawString($chip.text, $chipFont, (New-Brush $chip.color), ($cx + 13), 232)
  $path.Dispose()
  $cx += $cw + 9
}

# Project card stack
Draw-ProjectCard 820 42 300 112 -9 '#8f9dff' 'GLOBEFAIR' '3D career fair' 'Unity  |  WebGL  |  Firebase'
Draw-ProjectCard 888 120 300 112 -2 '#ffc46b' 'DOCK TV' 'Privacy-first launcher' 'Electron  |  Tizen'
Draw-ProjectCard 956 196 300 112 7 '#7cf2c0' 'CODERECALL' 'Spaced repetition' 'C#  |  WebView2'

# Bottom accent
$g.FillRectangle((New-Brush '#7cf2c0' 170), 0, $H - 4, $W, 4)

$dir = Split-Path -Parent $Output
if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir | Out-Null }
$bmp.Save($Output, [System.Drawing.Imaging.ImageFormat]::Png)
$g.Dispose()
$bmp.Dispose()
Write-Host "Wrote $Output" -ForegroundColor Green
