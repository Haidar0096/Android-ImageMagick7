# Accept the parameter to the script as hashtable
param([hashtable]$params)
function Change-Setting {
    param( [string]$Key, [string]$Value )
    # replace each key-value pair of the form "key := value" with the new values
    $script:content = $script:content -replace "^\s*$Key\s*:=\s*.*$", "$Key := $Value"
}

$PRoot = Resolve-Path -Path "$PSScriptRoot\.."

$file = "$PRoot\Application.mk"
$content = Get-Content -Path "$file"

# loop over the parameters and call the function for each key-value pair
foreach ($key in $params.Keys) {
    Change-Setting $key $params[$key]
}

Set-Content -Path $file -Value $content
