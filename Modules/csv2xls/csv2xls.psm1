Function Release-Ref ($ref)
  {
    ([System.Runtime.InteropServices.Marshal]::ReleaseComObject(
    [System.__ComObject]$ref) -gt 0)
    [System.GC]::Collect()
    [System.GC]::WaitForPendingFinalizers()
  }




Function ConvertCSV-ToExcel
{
<#
 .SYNOPSIS
  Converts a CSV file to an Excel file

 .DESCRIPTION
  Converts a CSV file to an Excel file

 .PARAMETER inputfile
  Name of the CSV file being converted

 .PARAMETER output
  Name of the converted excel file. Defaults to the same name as the input, but with xls as the extension

 .PARAMETER ExelVisible
  Whether you want Excel to show during operations. Defaults to false

 .PARAMETER OverWriteWithoutAsking
   Whether you want to overwrite existing workbooks. Defaults to false

 .EXAMPLE

 .NOTES
 Author: Boe Prox
 Modified by stib

#>

#Requires -version 2.0
[CmdletBinding()]
Param
  (
    [parameter(Mandatory=$True,Position=0)]$inputfile,
    [parameter(Mandatory=$False)]$output,
    [Switch]$ExcelVisible,
    [Switch]$OverWriteWithoutAsking
      )
#convert a path to a file object, and stop if the input path is incorrect
$inputFile = get-Item $inputFile -ErrorAction SilentlyContinue
if (! $inputFile){
  throw "You need to specify a valid input file"
}

if (! ($output)){
  #if user hasn't given an output path
  $output = (Join-Path $inputFile.Directory $inputFile.name.replace(".csv",".xlsx"))
  if ($outfile = $inputFile.fullname){
    throw "Can't overwrite the original file"
  }
}

Write-Host ("converting {0} to `n{1}" -F $inputFile.name, $output)
#Create Excel Com Object
$excel = new-object -com excel.application

#Show Excel application if user wants it
$excel.Visible = $ExcelVisible

#Add workbook
$workbook = $excel.workbooks.Add()

#Use the first worksheet in the workbook
$worksheet1 = $workbook.worksheets.Item(1)

#Remove other worksheets that are not needed
#$workbook.worksheets.Item(2).delete() -ErrorAction SilentlyContinue
#$workbook.worksheets.Item(2).delete() -ErrorAction SilentlyContinue

#Start row and column
$r = 1
$c = 1

#Begin working through the CSV
$file = (Get-Content $inputfile)
ForEach ($f in $file) {
  $arr = ($f).split(',')
  ForEach ($a in $arr) {
    $worksheet1.Cells.Item($r,$c) = "$(($a).replace('"',''))"
    $c++
    }
  $c = 1
  $r++
  }

#Select all used cells
$range = $worksheet1.UsedRange

#Autofit the columns
$range.EntireColumn.Autofit() | out-null

#delete the existing file, because it's easier than dealing with conflictresolution
if ($OverWriteWithoutAsking){
  if (test-path $output){remove-item $output}
}
#Save spreadsheet
$workbook.saveas($output);

Write-Host -Fore Green "File saved to $output"

#Close Excel
$excel.quit()

#Release processes for Excel
$a = Release-Ref($range)
$a = Release-Ref($worksheet1)
$a = Release-Ref($workbook)
$a = Release-Ref($range)
}
