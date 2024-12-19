#! /bin/bash
while getopts a: flag
do
    case "${flag}" in
        a) account_id=${OPTARG};;
    esac
done

echo 'Put opertions contact for account '$account_id'...'
aws account put-alternate-contact   --account-id $account_id   --alternate-contact-type=OPERATIONS   --email-address=aws.adminmailbox@bcaa.com   --phone-number="+1(604)268-5382"   --title="Senior Manager, Infrastructure and Cloud Eng"   --name="Ryan Degner" --profile master
echo 'Done putting operations contact for account '$account_id'.'

