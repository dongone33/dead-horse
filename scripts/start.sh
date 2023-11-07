#!/bin/bash

source /etc/profile

cd $(cd "$(dirname "$0")";pwd)

curl --connect-timeout 60 -s -o white_domain_list.php https://raw.githubusercontent.com/privacy-protection-tools/anti-AD/adlist-maker/scripts/lib/white_domain_list.php

php make-white-list.php

cd ..
sed 's/^\([.0-9A-Za-z\-]\+\)$/address \/\1\/-/g' anti-ad-white-list.txt >aanti-ad-white-list.txt
sed -e 's/^.*/@@||&^$important/' anti-ad-white-list.txt > anti-ad-white-list-adguardhome.txt

echo '#RULE-SET,AntiAd,DIRECT' >anti-ad-white-for-clash.yaml
echo 'payload:' >>anti-ad-white-for-clash.yaml
sed "s/^\([.0-9A-Za-z\-]\+\)$/  - '+.\1'/g" anti-ad-white-list.txt >>anti-ad-white-for-clash.yaml
