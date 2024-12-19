#! /bin/bash
    managementaccount=`aws organizations describe-organization --query Organization.MasterAccountId --output text --profile master`

    for account in $(aws organizations list-accounts --query 'Accounts[].Id' --output text --profile master); do

            if [ "$managementaccount" -eq "$account" ]
                     then
                         echo 'Skipping management account.'
                         continue
            fi
            ./put-operations-contact.sh -a $account
            sleep 0.2
    done
