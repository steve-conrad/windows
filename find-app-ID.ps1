# Define the application name to search for
$appName = ""

# Function to check registry for application
function Check-RegistryForApp {
    param (
        [string]$registryPath
    )
    
    # Get all subkeys in the specified registry path
    $subkeys = Get-ChildItem -Path $registryPath -ErrorAction SilentlyContinue
    
    if ($subkeys) {
        # Loop through each subkey to find the application
        foreach ($subkey in $subkeys) {
            $displayName = (Get-ItemProperty -Path $subkey.PSPath).DisplayName
            if ($displayName -like "*$appName*") {
                # Output the result only if the application is found
                Write-Output "Application: $appName"
                Write-Output "Registry Path: $($subkey.PSPath)"
                
                # Display uninstall string if available
                $uninstallString = (Get-ItemProperty -Path $subkey.PSPath).UninstallString
                Write-Output "Uninstall String: $uninstallString"
                
                # Get all values in the registry key
                $values = Get-ItemProperty -Path $subkey.PSPath
                Write-Output "Registry Values:"
                foreach ($value in $values.PSObject.Properties) {
                    Write-Output "  $($value.Name): $($value.Value)"
                }
                Write-Output "----------------------------------------"
            }
        }
    }
}

# Check HKLM for machine-wide installations
$registryPathHKLM = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
Check-RegistryForApp -registryPath $registryPathHKLM

# Check HKLM for 32-bit applications on 64-bit systems
$registryPathHKLM32 = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall"
Check-RegistryForApp -registryPath $registryPathHKLM32

# Check HKCU for user-specific installations
$registryPathHKCU = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
Check-RegistryForApp -registryPath $registryPathHKCU
