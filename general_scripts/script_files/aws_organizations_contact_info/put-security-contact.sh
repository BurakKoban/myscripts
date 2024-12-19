#! /bin/bash
while getopts a: flag
do
    case "${flag}" in
        a) account_id=${OPTARG};;
    esac
done

echo 'Put security contact for account '$account_id'...'
aws account put-alternate-contact   --account-id $account_id   --alternate-contact-type=SECURITY   --email-address=issecurity@bcaa.com   --phone-number="+1(604)341-5490"   --title="Director, Inf Security and Technical Services"   --name="Rafael Papa" --profile master
echo 'Done putting security contact for account '$account_id'.'
