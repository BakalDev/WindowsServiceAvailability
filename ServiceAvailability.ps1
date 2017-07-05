<# 
	Configurable values are highlighted with the @@ prefix and suffix @@example@@
#>

$serviceName = "@@Name of Service@@"
$emailAddress = "@@Recipient Email Address"

$service = get-service -ComputerName @@Hosting Server Name@@ -Name $serviceName

if ($service.Status -eq "Running")
{
$serviceStatus = "$serviceName is Running"

# Send email notification
sendEmail $serviceStatus
exit
}
else
{
$serviceStatus = "$serviceName Not Running"

# Send email notification
sendEmail $serviceStatus
exit
}

# Email function
function sendEmail([string]$serviceStatus) {
$smtpServer = "EXCHANGESERVER"
$msg = new-object Net.Mail.MailMessage
$smtp = new-object Net.Mail.SmtpClient($smtpServer)
$msg.From = $emailAddress
$msg.ReplyTo = $emailAddress
$msg.To.Add($emailAddress)
$msg.Priority = 1
$msg.body = $serviceStatus;
$msg.subject = $serviceName
$smtp.Send($msg)  
}



