<# Setting execution policy into Bypass for this PSSession only (local machine is not be affected) #>
Set-ExecutionPolicy -Force Bypass -Scope Process

<# Setting registry values to stop windows update #>
$key = "Registry::HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings"
$valTimeMin = "0000-01-01T00:00:00Z"
$valTimeMax = "9999-09-09T00:00:00Z"
New-ItemProperty -Force -Path $key -PropertyType String -Name PauseFeatureUpdatesStartTime -Value $valTimeMin
New-ItemProperty -Force -Path $key -PropertyType String -Name PauseQualityUpdatesStartTime -Value $valTimeMin
New-ItemProperty -Force -Path $key -PropertyType String -Name PauseFeatureUpdatesEndTime -Value $valTimeMax
New-ItemProperty -Force -Path $key -PropertyType String -Name PauseQualityUpdatesEndTime -Value $valTimeMax
New-ItemProperty -Force -Path $key -PropertyType String -Name PauseUpdatesExpiryTime -Value $valTimeMax

<# Completion message #>
[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] > $null
[Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime] > $null
[string] $L1 = "Windows 업데이트가 9999년 9월 9일에 다시 시작됩니다."
[string] $L2 = "　"
[string] $L3 = "Windows 업데이트 창의 업데이트 계속하기 버튼을 클릭하여 Windows 업데이트 기능을 복구하실 수 있습니다."
$toastDetail = @"
<toast> 
    <visual>
        <binding template = "ToastImageAndText04">
            <text id = "1">$($L1)</text>
            <text id = "2">$($L2)</text>
            <text id = "3">$($L3)</text>
        </binding>
    </visual> 
</toast>
"@
$xml = New-Object Windows.Data.Xml.Dom.XmlDocument
$xml.LoadXml($toastDetail)
$toastNotification = [Windows.UI.Notifications.ToastNotification]::new($xml)
[Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier(" ").Show($toastNotification)

