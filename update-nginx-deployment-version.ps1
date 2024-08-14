# Define the path to the deployment YAML file
$yamlFilePath = "my-app\1-deployment.yaml"

# Load the YAML content
$yamlContent = Get-Content $yamlFilePath -Raw

# Define the regex pattern to find the image version (assuming the version follows "v" and has a major.minor.patch format)
$imagePattern = '(?<=image:\s.*nginx:v)(\d+)\.(\d+)\.(\d+)'

# Find the current version in the file
if ($yamlContent -match $imagePattern) {
    $major = [int]$matches[1]
    $minor = [int]$matches[2]
    $patch = [int]$matches[3]
    
    # Increment the patch version (e.g., from v0.1.0 to v0.1.1)
    $newPatch = $patch + 1
    
    # Generate the new version string
    $newVersion = "$major.$minor.$newPatch"
    
    # Replace the old version with the new version
    $newYamlContent = $yamlContent -replace $imagePattern, $newVersion
    
    # Save the updated YAML content back to the file
    Set-Content $yamlFilePath $newYamlContent
    
    Write-Output "Updated the image version to v$newVersion in $yamlFilePath"
} else {
    Write-Output "No version found in the image field of $yamlFilePath"
}
