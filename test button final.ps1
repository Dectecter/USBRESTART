Set-ExecutionPolicy RemoteSigned
Add-Type -AssemblyName System.Windows.Forms
 
$form = New-Object 'System.Windows.Forms.Form'
$form.AutoScaleDimensions = '8, 17'
$form.AutoScaleMode = 'Font'
$form.ClientSize = '416, 262'
$form.FormBorderStyle = 'FixedDialog'
$form.Margin = '5, 5, 5, 5'
$form.MaximizeBox = $False
$form.MinimizeBox = $False
$form.ControlBox = $False
$form.Name = 'Button USB'   
$form.StartPosition = 'CenterScreen'
$form.Text = 'Test Button USB Restart'
$form.TopMost = $True # force window to stay on top
$form.add_Load($form_Load)
 
$button = New-Object 'System.Windows.Forms.Button'
$button.Font = 'Calibri, 12.25pt'
$button.DialogResult = 'OK'
$button.Location = '110, 165'
$button.Margin = '5, 5, 5, 5'
$button.Name = 'buttonOK'
$button.Size = '200, 50'
$button.BackColor ="LightGray"
$button.ForeColor ="black"
$button.Text = '&CLOSE'
$button.UseCompatibleTextRendering = $True
$button.UseVisualStyleBackColor = $False
$button.Add_Click({$form.Add_FormClosing({$_.Cancel=$false});$form.Close()
 pnputil /enum-devices /connected /class USB | Sort-Object -Descending | Select-Object -Last 35 | Select-String -Pattern "ИД экземпляра" >> D:\Tdead.txt
(Get-Content -Path D:\Tdead.txt) |
    ForEach-Object {$_ -Replace 'ИД экземпляра:                ', ''} |
        Set-Content -Path D:\Tdead.txt
Get-Content -Path D:\Tdead.txt
foreach ($line in Get-Content D:\Tdead.txt) {
    if ($line -match $regex) {
        pnputil /restart-device "$line"
    }
}
Start-Sleep -Seconds 2

Remove-item D:\Tdead.txt

})    
$button.Show()#$button.Hide()
$form.Controls.Add($button)
 
# Disable other types of close/exit
$form.add_FormClosing({$_.Cancel=$true})
[void] $form.ShowDialog()