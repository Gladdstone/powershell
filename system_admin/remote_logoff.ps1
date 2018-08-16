<#
    Name: remote_logoff
    Args: ComputerName
    Description: Takes machine name as argument. Executes remote logoff.
#>
$server = $args[0];
$username = $env:USERNAME;
#$session = ((quser /server:$server | ? { $_ -match $username }) " +")[2];
$session = (quser /server:$server | Select-Object -Index 1 | % { $_.Split(" ", [System.StringSplitOptions]::RemoveEmptyEntries) })[1];

logoff $session /server:$server;
