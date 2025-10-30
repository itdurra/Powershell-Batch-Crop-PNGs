# --- UPDATE THESE VARIABLES ---
$srcFolder   = "***file where images are located***"   # Source folder containing PNGs
$outFolder   = "$srcFolder\out"                        # Output folder for cropped results

# For the following pixel values, use Krita or another editor
# to measure the rectangle you want to keep.
$cropWidth   = 1334       # From (0,0): crop everything after this X value
$cropHeight  = 1369       # From (0,0): crop everything after this Y value
$offsetX     = 20         # Pixels to skip from the left
$offsetY     = 30         # Pixels to skip from the top

# --- setup ---
New-Item -ItemType Directory -Force -Path $outFolder | Out-Null  # Ensure output folder exists
Add-Type -AssemblyName System.Drawing  # Load the library to do the cropping with

# --- process ---
Get-ChildItem -Path $srcFolder -Filter *.png | ForEach-Object {
    #create name of new file (adding _crop.png suffix)
    $in  = $_.FullName
    $out = Join-Path $outFolder ($_.BaseName + "_crop.png")

    # Load image
    $img = [System.Drawing.Image]::FromFile($in)
    try {
        # Clamp offsets inside image bounds
        $x = [Math]::Max(0, [Math]::Min($offsetX, $img.Width  - 1))
        $y = [Math]::Max(0, [Math]::Min($offsetY, $img.Height - 1))

        # Ensure the crop region doesn't exceed image edges
        $w = [Math]::Min($cropWidth,  $img.Width  - $x)
        $h = [Math]::Min($cropHeight, $img.Height - $y)

        if ($w -le 0 -or $h -le 0) {
            Write-Warning "Skipping '$($_.Name)' (crop region outside image)."
            return
        }

        # Define crop rectangle and extract region
        $rect   = [System.Drawing.Rectangle]::new($x, $y, $w, $h)
        $bmpOut = $img.Clone($rect, $img.PixelFormat)

        # Save as PNG
        $bmpOut.Save($out, [System.Drawing.Imaging.ImageFormat]::Png)
        $bmpOut.Dispose()

        Write-Host "Cropped: $($_.Name) -> $out  [x=$x y=$y w=$w h=$h]"
    }
    finally {
        $img.Dispose() # Free the source image
    }
}
