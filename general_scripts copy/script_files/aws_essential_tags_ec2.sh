****************************
** AWS EC2 Essential Tags **
****************************

Key                           | Value                                           SCP Checked
----------------------------- | -------------------------------------------     -----------
Mandatory tags
-------------------------------------------------------------------------------------------
Name                          | dna-tst-mdm  -- Informatica MDM Process         Yes
Creator                       | Kevin Zhang                                     Yes
Department                    | Product and Platform                            Yes
Description                   | Informatica MDM Process                         Yes
TicketNumber                  | TASK00000000 or CR00000000                      Yes
Environment                   | Test                                            Yes
-------------------------------------------------------------------------------------------
Required tags
-------------------------------------------------------------------------------------------
Backups                       | Yes                                             No
Owner                         | Kevin Zhang                                     No
OSPlatform                    | Linux                                           No
OSUse                         | Server                                          No
PatchSys                      | SSM                                             No
PatchGroup                    | TST                                             No
PatchTime                     | 19:01                                           No
IMDSv2                        | Required                                        No
------------------------------------------------------------------------------------------
Optional tags
------------------------------------------------------------------------------------------
Project                       | DNA
Created_By                    | Terraform        
Schedule                      | dna-office-hours
InstanceScheduler-LastAction  | Started By Instance-Scheduler-Hub-Central 2024/08/08 15:00UTC
schedstarted                  | true
OSVersion                     | RHEL-8  
-------------------------------------------------------------------------------------------

Total of 20 common tags that we mostly use for EC2 insances