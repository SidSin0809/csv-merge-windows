# merge_csvs.ps1
$outFile = "merged.csv"

# Delete old merged file if it exists
if (Test-Path $outFile) { Remove-Item $outFile }

# Get all CSVs, sorted by name
$files = Get-ChildItem -Filter '*.csv' | Sort-Object Name

$first  = $true
$enc    = [System.Text.Encoding]::UTF8
$writer = [System.IO.StreamWriter]::new($outFile, $false, $enc)

try {
    foreach ($f in $files) {
        Write-Host "Processing $($f.Name)..."

        $reader = [System.IO.StreamReader]::new($f.FullName, $enc)
        try {
            if ($first) {
                # First file: write everything (including header)
                while (($line = $reader.ReadLine()) -ne $null) {
                    $writer.WriteLine($line)
                }
                $first = $false
            } else {
                # Other files: skip header line, then write data
                $null = $reader.ReadLine()  # skip header
                while (($line = $reader.ReadLine()) -ne $null) {
                    $writer.WriteLine($line)
                }
            }
        }
        finally {
            $reader.Dispose()
        }
    }
}
finally {
    $writer.Dispose()
}

Write-Host "Done. Merged file: $outFile"
