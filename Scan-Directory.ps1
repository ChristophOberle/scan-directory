<#
.SYNOPSIS

Scans a directory for files matching an include pattern

.DESCRIPTION

The directory is scanned for files matching the include pattern.
The scan is done recursively. A maximum depth for the recursion can be stated.

.PARAMETER Dir
Specifies the path to the directory to be scanned.

.PARAMETER Include
Specifies the pattern to match the files to be scanned.

.PARAMETER Depth
Specifies the maximum depth for the recursion.

.INPUTS

None. You can't pipe objects to Scan-Directory.ps1.

.OUTPUTS

For every file scanned, one line is output:
$fileName; $leafBase; $extension; $dirCount; $dir; $dir; $dir ...


.EXAMPLE

PS> .\Scan-Directory.ps1

Scans the current directory, matches *.*, depth for recursion is 10

.EXAMPLE

PS> .\Scan-Directory.ps1 / -Include *.pfx -Depth 100

Scans the root directory recursively for files with extension .pfx 

#>

param ([string]$Path = ".", [string]$Include = "*.*", [UInt32]$Depth = 10)

#Write-Host "Path:             $Path"
#Write-Host "Include:          $Include"
#Write-Host "Depth:            $Depth"

# get the directory separator character
$separator = [IO.Path]::DirectorySeparatorChar
# remove trailing separator, if given
if($Path.Substring($Path.Length - 1, 1) -eq $separator) {
    $Path = $Path.Substring(0, $Path.Length - 1)
}
# convert the given path to an absolute path
$Path = Convert-Path -Path $Path
#Write-Host "datadir (absolute): $dataDir"

# prefix length: the length of the path without the last directory including the trailing separator
$prefixLen = ($Path | Split-Path -Parent).Length + 1

# find all matching (-Include) files (-File) in dir (-Path) in a maximum depth of Depth (-Depth)
# and extract all dirs ($dir), the file name ($leafbase) and the extension ($extension) for each file
Get-ChildItem -Path $Path -Recurse -Depth $Depth -File -Include $include |
ForEach-Object -Process {
    # the file name with full path
    $fileName = $_
    # the directories in the path
    $dir = @()
    $dir = (($_ | Split-Path -Parent).Substring($prefixlen) -split $separator)
    $dirCount = $dir.Count
    # leaf base, the file name without path and extension
    $leafbase = ($_ | Split-Path -LeafBase)
    # file extension
    $extension = ($_ | Split-Path -Extension)

    $dirs = ""
    for($j = 0; $j -lt $dirCount; $j++) {
        if($j -gt 0) {
            $dirs = $dirs + "; "
        }
        $dirs = $dirs + $dir[$j]
    }
    "$fileName; $leafBase; $extension; $dirCount; $dirs"
}
