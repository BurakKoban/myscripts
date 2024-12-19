# AWS ENA and Nvme version

Get-WmiObject Win32_PnpSignedDriver | Select-Object DeviceName, DriverVersion, InfName | Where-Object {$_.DeviceName -like "*AWS*" -OR $_.DeviceName -like "*Amazon*"}

# Step1: ENA driver
# ==============

invoke-webrequest https://ec2-windows-drivers-downloads.s3.amazonaws.com/ENA/Latest/AwsEnaNetworkDriver.zip -outfile $env:USERPROFILE\AwsEnaNetworkDriver.zip

# S3 bucket to donwload the latest ENA driver

https://s3.amazonaws.com/ec2-windows-drivers-downloads/ENA/Latest/AwsEnaNetworkDriver.zip

# S3 bucket to donwload the latest NVMe driver

https://s3.amazonaws.com/ec2-windows-drivers-downloads/NVMe/Latest/AWSNVMe.zip

# To update the driver, run this command in the command prompt

.\install.ps1