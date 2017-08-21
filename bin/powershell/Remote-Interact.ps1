# 認証オブジェクトの作成
# => ポップアップウィンドウでパスワードを入力
$cred = Get-Credential -Credential ein
# XMLにエクスポート
$cred | Export-CliXml -Path .\nanoserver01.clixml
# XMLからインポート
$saveCred = Import-CliXml -Path .\nanoserver01.clixml
# セッションを作成
$session = New-CimSession -ComputerName 10.0.0.4 -Cred $saveCred
# メソッドを実行
Invoke-CimMethod -CimSession $session -ClassName Win32_OperatingSystem -Method Shutdown
# リモートマシンのコマンドプロンプトで対話する
Enter-PSSession -ComputerName 10.0.0.4 -Cred $saveCred
