# Batch Crop Tool for PNG Images

When extracting `.unitypackage` assets for Godot (shoutout [unitypackage_extractor](https://github.com/Cobertos/unitypackage_extractor/releases)),  
I ended up with hundreds of texture files that needed manual trimming.

What I purchased:
<img width="4156" height="4156" alt="image" src="https://github.com/user-attachments/assets/6c3da098-4739-4e21-97bb-84a9c4373f03" />
<img width="4156" height="4156" alt="image" src="https://github.com/user-attachments/assets/97a266e2-4b7d-4a81-aeb0-73ab4cf602f1" />
What I needed: 
<img width="1525" height="1511" alt="image" src="https://github.com/user-attachments/assets/58b26733-b11c-4288-908a-e692ecc9ece4" />
<img width="1525" height="1511" alt="image" src="https://github.com/user-attachments/assets/2d5b90bb-41b1-4d6e-8510-a4719e1f1baa" />

Opening **Krita 258 times** to crop them by hand was out of the question —  
so I automated the task using **PowerShell** and .NET’s `System.Drawing` library.

---

## Overview

This script batch-crops all `.png` images in a given folder, given a dimensions in pixels.

The process:
1. You define crop coordinates and offsets.
2. PowerShell loads each image.
3. It crops the desired region.
4. The result is written to an `out/` subfolder.

---

## Step 1 (Optional) — Enable Temporary Script Execution

If your system blocks PowerShell scripts by default, you can temporarily allow them **for this session only**:

```powershell
# 1) See what’s enforcing the block
Get-ExecutionPolicy -List

# 2) Temporarily relax policy for THIS WINDOW ONLY
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force

# 3) Launch ISE (or PowerShell 7) from this relaxed session
powershell_ise.exe
