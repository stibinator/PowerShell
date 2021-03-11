function moveCursor([int]$x, [int] $y, [switch] $relativeX, [switch] $relativeY) {
  if ($relativeX){
    $x += $Host.UI.RawUI.CursorPosition.X;
  }
  if ($relativeY){
    $y += $Host.UI.RawUI.CursorPosition.Y;
  }
  $Host.UI.RawUI.CursorPosition = New-Object System.Management.Automation.Host.Coordinates $x , $y
}
