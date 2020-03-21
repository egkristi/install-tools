#!/bin/bash

#https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux.html
wget -nc -q -O "/tmp/awscli-exe-linux-x86_64.zip" "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"
unzip -qq -o /tmp/awscli-exe-linux-x86_64.zip -d /tmp
sudo /tmp/aws/install -u
complete -C '/usr/local/bin/aws2_completer' aws
aws --version

wget -nc -q -O "/tmp/aws-iam-authenticator" "https://amazon-eks.s3-us-west-2.amazonaws.com/1.14.6/2019-08-22/bin/linux/amd64/aws-iam-authenticator" 
chmod +x /tmp/aws-iam-authenticator
sudo mv /tmp/aws-iam-authenticator /usr/local/bin/
aws-iam-authenticator version