param (
    [string]
    $Credpath = "user.clixml"
    [string]
    $ComputerName = "localhost"
    [string]
    $ArchivePath = "C:\shared\archives"
    [string]
    $ConfigurationPath = "Configuration"
)
Try
{
    $cred = Import-CliXml $CredPath
    $pssession = New-PSSession -ComputerName $ComputerName -Credential $cred
    $cimsession = New-CimSession -ComputerName $ComputerName -Credential $cred
    # 同じパスにファイルをコピーする
    Copy-Item -Path $ArchivePath -Recurse -Destination $ArchivePath -ToSession $pssession
    # コピー済みのファイルを使って設定する
    Start-DscConfiguration -CimSession $cimsession -Path $ConfigurationPath -Wait -Verbose -Force
}
Finally
{
    $pssession | Remove-PSSession
    $cimsession | Remove-CimSession
}
