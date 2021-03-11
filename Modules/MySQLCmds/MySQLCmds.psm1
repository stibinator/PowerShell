#  source https://vwiki.co.uk/MySQL_and_PowerShell

function Connect-MySQL([string]$user,[string]$pass,[string]$MySQLHost,[string]$database) { 
  # Load MySQL .NET Connector Objects 
  [void][system.reflection.Assembly]::LoadWithPartialName("MySql.Data") 

  # Open Connection 
  $connStr = "server=" + $MySQLHost + ";port=3306;uid=" + $user + ";pwd=" + $pass + ";database="+$database+";Pooling=FALSE" 
  $conn = New-Object MySql.Data.MySqlClient.MySqlConnection($connStr) 
  $conn.Open() 
  return $conn 
} 

function Disconnect-MySQL($conn) {
  $conn.Close()
}

function Connect-MySQL([string]$user, [string]$pass, [string]$MySQLHost, [string]$database) { 
    # Load MySQL .NET Connector Objects 
    [void][system.reflection.Assembly]::LoadWithPartialName("MySql.Data") 
 
    # Open Connection 
    $connStr = "server=" + $MySQLHost + ";port=3306;uid=" + $user + ";pwd=" + $pass + ";database="+$database+";Pooling=FALSE;Allow User Variables=True;Allow Zero Datetime=True;" 
    try {
        $conn = New-Object MySql.Data.MySqlClient.MySqlConnection($connStr) 
        $conn.Open()
    } catch [System.Management.Automation.PSArgumentException] {
        write-host "Unable to connect to MySQL server, do you have the MySQL connector installed..?"
        write-host $_
        
    } catch {
        write-host "Unable to connect to MySQL server..."
        write-host $_.Exception.GetType().FullName
        write-host $_.Exception.Message
        
    }
    write-host "Connected to MySQL database $MySQLHost\$database"

    return $conn 
}

function Invoke-MySQLNonQuery($conn, [string]$query) { 
  $command = $conn.CreateCommand()                  # Create command object
  $command.CommandText = $query                     # Load query into object
  $RowsInserted = $command.ExecuteNonQuery()        # Execute command
  $command.Dispose()                                # Dispose of command object
  if ($RowsInserted) { 
    return $RowInserted 
  } else { 
    return $false 
  } 
} 

function Invoke-MySQLQuery($conn, [string]$query) { 
  # NonQuery - Insert/Update/Delete query where no return data is required
  $cmd = New-Object MySql.Data.MySqlClient.MySqlCommand($query, $conn)    # Create SQL command
  $dataAdapter = New-Object MySql.Data.MySqlClient.MySqlDataAdapter($cmd)      # Create data adapter from query command
  $dataSet = New-Object System.Data.DataSet                                    # Create dataset
  $dataAdapter.Fill($dataSet, "data")                                          # Fill dataset from data adapter, with name "data"              
  $cmd.Dispose()
  return $dataSet.Tables["data"]                                               # Returns an array of results
}

function Invoke-MySQLScalar([string]$query) {
    # Scalar - Select etc query where a single value of return data is expected
    $cmd = $SQLconn.CreateCommand()                                             # Create command object
    $cmd.CommandText = $query                                                   # Load query into object
    $cmd.ExecuteScalar()                                                        # Execute command
}

function Convert-TextToMySQLEscapedText([string]$text) {
    [regex]::replace($text, "'", "\'")
    [regex]::replace($text, "\\", "\\")
}