 $powershell.AddScript({
 add-type -AssemblyName System.Windows.Forms
 sleep -Seconds 10
 [System.Windows.Forms.SendKeys]::SendWait("p")
 })|Out-Null    
 $powershell.BeginInvoke()|Out-Null 
 
while($true)
{
    Write-Host "Press P to exit"  
    $Q=$HOST.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    if($q.character -eq 'p'){continue}
    pnputil /enum-devices /connected /class USB | Sort-Object -Descending | Select-Object -Last 30 | Select-String -Pattern "USB" | Select-String -Pattern "ИД экземпляра" >> D:\Tdead.txt
(Get-Content -Path D:\Tdead.txt) |
    ForEach-Object {$_ -Replace 'ИД экземпляра:                ', ''} |
        Set-Content -Path D:\Tdead.txt
Get-Content -Path D:\Tdead.txt
foreach ($line in Get-Content D:\Tdead.txt) {
    if ($line -match $regex) {
        pnputil /restart-device "$line"
    }
}
Start-Sleep -Seconds 5
    }