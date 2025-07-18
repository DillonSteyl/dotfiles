fastfetch

Invoke-Expression (&starship init powershell)


# Wezterm Utilities
function Rename-WeztermSession {
    param(
        [Parameter(Mandatory = $true)]
        [string]$NewName
    )

    wezterm cli rename-workspace "$NewName"
}

Set-Alias -Name rnw -Value Rename-WeztermSession
