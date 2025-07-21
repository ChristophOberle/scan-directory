# get the directory separator character for your operating system
$separator = [IO.Path]::DirectorySeparatorChar

# scan a directory for XML files
./Scan-Directory.ps1 -Path /Users -Include *.xml -Depth 100 |
        <# write results to xmlFiles.csv #>
        Tee-Object -FilePath "xmlFiles.csv" |
        <# write file info in a different format #>
        ForEach-Object -Begin {
            $i = 0
            $start = Get-Date
        } -Process {
            # all directories are gathered into the last parameter $dir as an array
            $filename, $leafbase, $extension, $dirCount, $dirs = ($_ -split "; ")
            Write-Host "$i`: `"$leafbase$extension`" $dircount `"$($dirs -join $separator)`""
            $i++
        } -End {
            $end = Get-Date
            Write-Host "$i files found"
            Write-Host "Execution time: $($end - $start)"
        }

