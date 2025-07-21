# scan-directory
scans a directory for files matching an include pattern

This Powershell script can be used in Windows and Unix environments.

# Installation

* copy Scan-Directory.ps1 to a directory of your choice
* start a Powershell session
* go to the directory (cd <somewhere>)
* run the program:

  `./Scan-Directory.ps1 -Path /whereTheDataIs -Include *.xml -Depth 5`
  
  This call shows all `XML files` in directory `/whereTheDataIs` with a recursion depth of `5`.
  
# Example

The script Run-Example.ps1 calls Scan-Directory.ps1 to scan a directory for XML files. 

The list of files is written to xmlFiles.csv and 
the result is output in a different format.
