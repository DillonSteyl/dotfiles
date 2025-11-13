fastfetch

Invoke-Expression (&starship init powershell)
mise activate pwsh | Out-String | Invoke-Expression

# Wezterm Utilities
function Rename-WeztermSession {
    param(
        [Parameter(Mandatory = $true)]
        [string]$NewName
    )

    wezterm cli rename-workspace "$NewName"
}

Set-Alias -Name rnw -Value Rename-WeztermSession
