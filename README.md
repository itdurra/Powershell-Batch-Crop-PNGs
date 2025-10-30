# Batch Crop Tool for PNG Images

When extracting `.unitypackage` assets for Godot (shoutout [unitypackage_extractor](https://github.com/Cobertos/unitypackage_extractor)),  
I ended up with hundreds of texture files that needed manual trimming.

What I purchased:
<img width="100" height="100" alt="image" src="https://github.com/user-attachments/assets/6c3da098-4739-4e21-97bb-84a9c4373f03" />
<img width="100" height="100" alt="image" src="https://github.com/user-attachments/assets/97a266e2-4b7d-4a81-aeb0-73ab4cf602f1" />
What I needed: 
<img width="100" height="100" alt="image" src="https://github.com/user-attachments/assets/58b26733-b11c-4288-908a-e692ecc9ece4" />
<img width="100" height="100" alt="image" src="https://github.com/user-attachments/assets/2d5b90bb-41b1-4d6e-8510-a4719e1f1baa" />

Opening **Krita 258 times** to crop them by hand was out of the question, so I automated the task using **PowerShell**.

---

## Overview

This script loads all `.png` images in a given folder, makes a copy, crops it to desired pixels, then writes the copy to an `out/` directory. You can copy/paste the script into a Powershell ISE session to run it.

---

## Step 1 (Optional) — Enable Temporary Script Execution

Open Powershell ISE with administrator priveleges. If your system blocks PowerShell scripts by default, you can temporarily allow them **for this session only** by running this, and running the script in the new ISE session:

```powershell
# 1) See what’s enforcing the block
Get-ExecutionPolicy -List

# 2) Temporarily relax policy for THIS WINDOW ONLY
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force

# 3) Launch ISE (or PowerShell 7) from this relaxed session
powershell_ise.exe

```

## Step 2 — Edit the variables in this Powershell script 
Edit the variables in the script [trim_textures.ps1](https://github.com/itdurra/Powershell-Batch-Crop-PNGs/blob/main/trim_textures.ps1)
```powershell
# --- settings ---
$srcFolder   = "***file where images are located***"   # Source folder containing PNGs
$outFolder   = "$srcFolder\out"                        # Output folder for cropped results

# For the following pixel values, use Krita or another editor
# to measure the rectangle you want to keep in pixels.
$cropWidth   = 1334       # From (0,0): crop everything after this X value
$cropHeight  = 1369       # From (0,0): crop everything after this Y value
$offsetX     = 20         # Pixels to skip from the left
$offsetY     = 30         # Pixels to skip from the top
```
## Step 3 (Optional) 
Test that [trim_textures.ps1](https://github.com/itdurra/Powershell-Batch-Crop-PNGs/blob/main/trim_textures.ps1) is working by having it run on a single image. Updating $srcFolder to point to a temp directory. Adjust the pixel values in Step #2 to achieve desired crop.

## Step 4
Once [trim_textures.ps1](https://github.com/itdurra/Powershell-Batch-Crop-PNGs/blob/main/trim_textures.ps1) is working, run it in Powershell ISE. NOTE: that the script overwrites existing images in the supplied /out directory.

