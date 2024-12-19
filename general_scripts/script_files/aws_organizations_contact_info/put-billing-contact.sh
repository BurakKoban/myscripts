#! /bin/bash
while getopts a: flag
do
    case "${flag}" in
        a) account_id=${OPTARG};;
    esac
done

echo 'Put billing contact for account '$account_id'...'
aws account put-alternate-contact   --account-id $account_id   --alternate-contact-type=BILLING   --email-address=Jenny.Lung@bcaa.com   --phone-number="+1(604)268-5469"   --title="IS Budget and Licensing Analyst"   --name="Jenny Lung" --profile master
echo 'Done putting billing contact for account '$account_id'.'

