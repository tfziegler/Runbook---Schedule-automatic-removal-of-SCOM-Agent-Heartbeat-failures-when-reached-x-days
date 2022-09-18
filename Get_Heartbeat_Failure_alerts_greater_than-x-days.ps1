###################################################################
#
# Title: Get Heartbeat Failure alerts greater than "x" days
# Author: Tom Ziegler
# Company: Microsoft
# Last Modified: 9-15-2022
# Version: 1.0
#
# Description - Gets Heartbeat Failure Alerts
###################################################################

# Import Operations Manager Module and Connect to Management Server 
Import-Module OperationsManager
New-SCOMManagementGroupConnection YOUR-MANAGEMENTSERVER-NAME

# Set the number of Days that will be used for Alert
$AgeDays = 30

# Returns SCOM alert based off number of days specified and writes to a file
Get-SCOMAlert | where {$_.Name -eq 'Health Service Heartbeat Failure' -and $_.ResolutionState -ne '255' -and $_.TimeRaised -le (Get-Date).AddDays(-$AgeDays)} | Sort TimeRaised -Descending | select -expand MonitoringObjectDisplayName | Out-File -FilePath '\\servername\sharename\HeartbeatFailures.txt'