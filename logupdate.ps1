$Begin = Get-Date -Date '8/20/2021 21:00'
$End = Get-Date -Date '8/21/2021 22:00'
Get-EventLog -LogName Application -EntryType Error -After $Begin -Before $End 

