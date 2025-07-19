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

# PYTHON
scoop install python
# TODO: Check if uv@0.8.0 checksum issue is resolved
# scoop install uv
# uv python install

# MISC
scoop install fastfetch
scoop bucket add nerd-fonts
scoop install nerd-fonts/Hermit-NF

# GODOT
winget install 'Microsoft.DotNet.SDK.9'
dotnet tool install --global Chickensoft.GodotEnv
