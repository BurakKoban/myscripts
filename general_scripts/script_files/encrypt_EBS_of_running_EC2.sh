1. Stop your EC2 instance. 
2. Create an EBS snapshot of the volume you want to encrypt. 
3. Copy the EBS snapshot, encrypting the copy in the process using key created above. 
4. Create a new EBS volume from your new encrypted EBS snapshot. The new EBS volume will be encrypted. 
5. Detach the original EBS volume and attach your new encrypted EBS volume, making sure to match the device name (/dev/sda1, etc.)
6. Start the EC2 instance.
