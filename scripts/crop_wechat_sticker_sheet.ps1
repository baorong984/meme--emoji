# =============================================================================
# Script : crop_wechat_sticker_sheet.ps1
# Purpose: Crop a 4x6 vertical sticker-sheet image into 24 240x240 PNG files
#          for WeChat sticker submission.
#          Fixes the crop-offset bug caused by sheet-level padding (white
#          borders around the actual 24-cell grid) by first auto-detecting the
#          real grid region based on the 4-corner average background color,
#          then dividing the real grid into Cols x Rows cells and taking the
#          centered square of each cell.
#          Optionally produces 120x120 thumbnails.
# Usage  : powershell -ExecutionPolicy Bypass -File crop_wechat_sticker_sheet.ps1 `
#             -SourcePath "sheet.jpg" -OutputDir "out" -GenerateThumbnail
# =============================================================================

[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [string]$SourcePath,

    [Parameter(Mandatory=$true)]
    [string]$OutputDir,

    [int]$Cols = 4,
    [int]$Rows = 6,
    [int]$TargetSize = 240,
    [switch]$GenerateThumbnail,
    [int]$BgTolerance = 25   # RGB-sum tolerance for "is-not-background" test
)

# -----------------------------------------------------------------------------
# Ensure System.Drawing is loaded
# -----------------------------------------------------------------------------
function load_drawing_assembly() {
    Add-Type -AssemblyName System.Drawing -ErrorAction Stop
}

# -----------------------------------------------------------------------------
# Returns true if the pixel differs from the background color beyond tolerance.
# Input tolerance is the sum of absolute R/G/B differences.
# -----------------------------------------------------------------------------
function test_pixel_not_bg(
    [System.Drawing.Bitmap]$Bmp,
    [int]$X, [int]$Y,
    [int]$BgR, [int]$BgG, [int]$BgB,
    [int]$Tol)
{
    $p = $Bmp.GetPixel($X, $Y)
    $delta = [Math]::Abs($p.R - $BgR) +
             [Math]::Abs($p.G - $BgG) +
             [Math]::Abs($p.B - $BgB)
    return ($delta -gt $Tol)
}

# -----------------------------------------------------------------------------
# Scan the image to find the actual rectangular region that contains
# non-background content (i.e. the sticker grid).
# Returns a hashtable with keys: Left, Top, Right, Bottom
# -----------------------------------------------------------------------------
function detect_grid_bounds(
    [System.Drawing.Bitmap]$Bmp,
    [int]$BgR, [int]$BgG, [int]$BgB,
    [int]$Tol)
{
    $W = $Bmp.Width
    $H = $Bmp.Height
    $step = 5        # scan step in pixels; smaller = more precise but slower
    $minHit = 5      # minimum non-bg hits on a row/column to treat as content

    # Left boundary: scan left-to-right
    $L = 0
    for ($x = 0; $x -lt $W; $x += $step) {
        $hit = 0
        for ($y = 0; $y -lt $H; $y += $step) {
            if (test_pixel_not_bg $Bmp $x $y $BgR $BgG $BgB $Tol) { $hit++ }
        }
        if ($hit -gt $minHit) { $L = $x; break }
    }

    # Right boundary: scan right-to-left
    $R = $W - 1
    for ($x = $W - 1; $x -ge 0; $x -= $step) {
        $hit = 0
        for ($y = 0; $y -lt $H; $y += $step) {
            if (test_pixel_not_bg $Bmp $x $y $BgR $BgG $BgB $Tol) { $hit++ }
        }
        if ($hit -gt $minHit) { $R = $x; break }
    }

    # Top boundary: scan top-to-bottom
    $T = 0
    for ($y = 0; $y -lt $H; $y += $step) {
        $hit = 0
        for ($x = 0; $x -lt $W; $x += $step) {
            if (test_pixel_not_bg $Bmp $x $y $BgR $BgG $BgB $Tol) { $hit++ }
        }
        if ($hit -gt $minHit) { $T = $y; break }
    }

    # Bottom boundary: scan bottom-to-top
    $B = $H - 1
    for ($y = $H - 1; $y -ge 0; $y -= $step) {
        $hit = 0
        for ($x = 0; $x -lt $W; $x += $step) {
            if (test_pixel_not_bg $Bmp $x $y $BgR $BgG $BgB $Tol) { $hit++ }
        }
        if ($hit -gt $minHit) { $B = $y; break }
    }

    return @{ Left=$L; Top=$T; Right=$R; Bottom=$B }
}

# -----------------------------------------------------------------------------
# Crop a square region from the source image and save as a sized PNG.
# Canvas is pre-filled with ClearColor (prevents transparent background on
# color-quantized sources).
# -----------------------------------------------------------------------------
function save_cropped_square(
    [System.Drawing.Image]$Source,
    [System.Drawing.Rectangle]$CropRect,
    [string]$DestPath,
    [int]$Size,
    [System.Drawing.Color]$ClearColor)
{
    $bmp = New-Object System.Drawing.Bitmap($Size, $Size)
    $g   = [System.Drawing.Graphics]::FromImage($bmp)
    try {
        $g.InterpolationMode    = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
        $g.SmoothingMode        = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
        $g.PixelOffsetMode      = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
        $g.CompositingQuality   = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
        $g.Clear($ClearColor)
        $g.DrawImage($Source,
            (New-Object System.Drawing.Rectangle(0, 0, $Size, $Size)),
            $CropRect,
            [System.Drawing.GraphicsUnit]::Pixel)
        $bmp.Save($DestPath, [System.Drawing.Imaging.ImageFormat]::Png)
    } finally {
        $g.Dispose()
        $bmp.Dispose()
    }
}

# =============================================================================
# Main
# =============================================================================
try {
    if (-not (Test-Path -LiteralPath $SourcePath)) {
        throw ("Source file not found: " + $SourcePath)
    }
    New-Item -ItemType Directory -Force -Path $OutputDir | Out-Null

    load_drawing_assembly

    $src  = [System.Drawing.Image]::FromFile($SourcePath)
    $bmp  = New-Object System.Drawing.Bitmap($src)
    $W = $bmp.Width
    $H = $bmp.Height
    Write-Host ("[INFO] Source: " + $SourcePath + " (" + $W + " x " + $H + ")")

    # Average background color from four corners
    $corners = @(
        $bmp.GetPixel(2, 2),
        $bmp.GetPixel($W - 3, 2),
        $bmp.GetPixel(2, $H - 3),
        $bmp.GetPixel($W - 3, $H - 3)
    )
    $bg_R = [int](($corners | ForEach-Object { $_.R } | Measure-Object -Average).Average)
    $bg_G = [int](($corners | ForEach-Object { $_.G } | Measure-Object -Average).Average)
    $bg_B = [int](($corners | ForEach-Object { $_.B } | Measure-Object -Average).Average)
    $bg_color = [System.Drawing.Color]::FromArgb($bg_R, $bg_G, $bg_B)
    Write-Host ("[INFO] Background (avg corners) R=" + $bg_R + " G=" + $bg_G + " B=" + $bg_B)

    # Detect actual grid bounds
    $bounds = detect_grid_bounds $bmp $bg_R $bg_G $bg_B $BgTolerance
    $L = $bounds.Left
    $T = $bounds.Top
    $R = $bounds.Right
    $B = $bounds.Bottom
    $gW = $R - $L + 1
    $gH = $B - $T + 1
    Write-Host ("[INFO] Grid bounds: L=" + $L + " T=" + $T + " R=" + $R + " B=" + $B)
    Write-Host ("[INFO] Padding removed: Top=" + $T + " Bottom=" + ($H-1-$B) +
        " Left=" + $L + " Right=" + ($W-1-$R))

    if ($gW -le 0 -or $gH -le 0) {
        throw "Grid detection failed. Try raising BgTolerance."
    }

    $cell_W = $gW / $Cols
    $cell_H = $gH / $Rows
    $side   = [Math]::Min($cell_W, $cell_H)
    Write-Host ("[INFO] Per-cell: W=" + ("{0:N2}" -f $cell_W) +
        " H=" + ("{0:N2}" -f $cell_H) +
        " Square side=" + ("{0:N2}" -f $side))

    $thumb_dir = $null
    if ($GenerateThumbnail) {
        $thumb_dir = $OutputDir + "_thumb"
        New-Item -ItemType Directory -Force -Path $thumb_dir | Out-Null
    }

    $idx = 0
    for ($r = 0; $r -lt $Rows; $r++) {
        for ($c = 0; $c -lt $Cols; $c++) {
            $idx++
            $cell_x0 = $L + $c * $cell_W
            $cell_y0 = $T + $r * $cell_H
            $offset_x = ($cell_W - $side) / 2
            $offset_y = ($cell_H - $side) / 2
            $cx = [Math]::Round($cell_x0 + $offset_x)
            $cy = [Math]::Round($cell_y0 + $offset_y)
            $s  = [Math]::Round($side)
            $crop = New-Object System.Drawing.Rectangle($cx, $cy, $s, $s)

            $name = ("{0:D2}.png" -f $idx)
            save_cropped_square $src $crop (Join-Path $OutputDir $name) $TargetSize $bg_color

            if ($thumb_dir) {
                save_cropped_square $src $crop (Join-Path $thumb_dir $name) 120 $bg_color
            }
        }
    }

    $bmp.Dispose()
    $src.Dispose()

    $produced = Get-ChildItem $OutputDir -Filter *.png
    $max_kb = [Math]::Round(($produced | Measure-Object Length -Maximum).Maximum / 1KB, 1)
    $avg_kb = [Math]::Round(($produced | Measure-Object Length -Average).Average / 1KB, 1)
    Write-Host ("[DONE] Produced " + $produced.Count + " x " +
        $TargetSize + "x" + $TargetSize + " -> " + $OutputDir)
    Write-Host ("[DONE] Size avg " + $avg_kb + " KB, max " + $max_kb +
        " KB (WeChat limit 500 KB)")

    if ($thumb_dir) {
        $tc = (Get-ChildItem $thumb_dir -Filter *.png).Count
        Write-Host ("[DONE] Also produced " + $tc +
            " thumbnails (120x120) -> " + $thumb_dir)
    }
    exit 0

} catch {
    Write-Host ("[ERROR] " + $_.Exception.Message) -ForegroundColor Red
    exit 1
}
