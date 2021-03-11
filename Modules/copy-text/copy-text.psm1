# Copy-Text.ps1
#
# The script copies a string variable to system clipboard.
# Credit: http://blogs.msdn.com/b/powershell/archive/2009/01/12/copy-console-screen-to-system-clipboard.aspx

function copy-text{
  param(
    [Parameter(ValueFromPipeline = $true)]
    [string]$text
  )

  # Load System.Windows.Forms assembly.
  $null = [Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

  # Create data object.
  $dataObject = New-Object windows.forms.dataobject

  # Add generated strings to data object.
  $dataObject.SetData([Windows.Forms.DataFormats]::UnicodeText, $true, $text)

  # Put data object in system clipboard.
  [Windows.Forms.Clipboard]::SetDataObject($dataObject, $true)

  "copied`n{0}" -F $text
}
