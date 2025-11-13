# update powershell
winget install Microsoft.PowerShell
Invoke-Command { & "pwsh.exe"       } -NoNewScope # PowerShell 7

# install scoop
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression

# NVIM
winget install Neovim.Neovim
# Configuration dependencies
scoop install fzf
scoop install fd
scoop install ripgrep

# LAZYGIT
scoop bucket add extras
scoop install lazygit

# WEZTERM
scoop install wezterm

# STARSHIP (PROMPT)
scoop install starship

# Python with UV
winget install --id=astral-sh.uv -e
uv python install --default

# MISC
scoop install fastfetch
scoop bucket add nerd-fonts
scoop install nerd-fonts/Hermit-NF
winget install Microsoft.PowerToys

# GODOT
winget install 'Microsoft.DotNet.SDK.9'
dotnet tool install --global Chickensoft.GodotEnv

# MISE & Git Spice
scoop install mise
mise use --global 'ubi:abhinav/git-spice[exe=gs]'

# GCC / MSYS2
# scoop install msys2
# msys2
# pacman -S --needed base-devel mingw-w64-ucrt-x86_64-toolchain
# exit
# 
# # add to path
# $env:path >> a.out
# [Environment]::SetEnvironmentVariable("Path", $env:Path + ";${HOME}\scoop\apps\msys2\current\ucrt64\bin", "User")
