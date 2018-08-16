<#
    Name: remote_logoff
    Args: ComputerName
    Description: Takes machine name as argument. Executes remote logoff.
#>
$server = $args[0];
$username = $env:USERNAME;
$session = ((quser /server:$server | ? { $_ -match $username }) " +")[2];

logoff $session /server:$server;
