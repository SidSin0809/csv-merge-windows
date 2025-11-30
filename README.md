# csv-merge-windows
Fast, header-aware CSV merger for Windows using PowerShell streams with an optional .bat wrapper

# fast-csv-merge-windows

Fast, header-aware CSV merger for Windows using PowerShell streams with an optional `.bat` wrapper.  
Designed for large datasets that exceed Excel's row limit (≈1,048,576 rows).

## Features

- Merges all `*.csv` files in a folder into a single `merged.csv`.
- Keeps the header row only from the first file.
- Uses PowerShell `StreamReader`/`StreamWriter` for high performance.
- Works via:
  - direct PowerShell invocation, or
  - double-clickable `merge_csvs.bat` wrapper.
- No dependencies beyond Windows + PowerShell.

## Files

- `merge_csvs.ps1` – main PowerShell script (fast streaming implementation).
- `merge_csvs.bat` – small wrapper that calls the PowerShell script from Explorer.

## Requirements

- Windows 10 or later (PowerShell 5+ is fine; PowerShell 7+ also works).
- Basic permissions to run local scripts (ExecutionPolicy is bypassed only for this call via the `.bat` file).

## Installation

1. Create a folder for this tool, or clone this repository:

   ```bash
   git clone https://github.com/SidSin0809/fast-csv-merge-windows.git
   ```

## How it works

- The script enumerates all *.csv files in the current directory, sorted by name.
- For the first file:
  - Reads every line and writes it to merged.csv (including the header).
- For each subsequent file:
  - Skips the first line (header).
  - Streams all remaining lines into merged.csv.
- Streaming is done via .NET System.IO.StreamReader and System.IO.StreamWriter to avoid the overhead and memory usage of Get-Content, type, or more.


