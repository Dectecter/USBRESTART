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