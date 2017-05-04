param (
  [string]$installDir = $(throw '-installDir is required.')
)

$serviceName = "Filebeat"

function CreateService {
  $service = New-Service -Name $serviceName -DisplayName $serviceName -BinaryPathName "`"$installDir\filebeat.exe`" -c `"$installDir\filebeat.yml`" -path.home `"$installDir`" -path.data `"$installDir\data`""
}

function DeleteService {
  if (Get-Service filebeat -ErrorAction SilentlyContinue) {
    $service = Get-WmiObject -Class Win32_Service -Filter "name='filebeat'"
    $service.delete()
  }
}

try {
  $ErrorActionPreference = "Stop"
  $status = (Get-Service -Name $serviceName).Status
}
catch {
  $status = "Not Found"
}
finally {
  $ErrorActionPreference = "Continue"
}

Write-Output "$serviceName service status: $status"

if ($status -eq "Not Found") {
  Write-Output "Creating new service"
  CreateService
}
elseif ($status -eq "Stopped") {
  Write-Output "Reconfiguring service"
  DeleteService
  CreateService
}
elseif ($status -eq "Running") {
  Write-Output "Reconfiguring and restarting service"
  Stop-Service $serviceName
  DeleteService
  CreateService
  Start-Service $serviceName
}
else {
  Write-Output "Nothing to do"
}

Get-Service -Name $serviceName
