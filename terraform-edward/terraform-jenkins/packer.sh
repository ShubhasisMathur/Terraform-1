#!/bin/bash
ARTIFACT=`packer build -machine-readable packer.json | awk -F, '$0 ~/artifact,0,id/ {print $6}'`
AMI_ID=`echo $ARTIFACT | awk -F : '{print $2}'`
echo 'variable INSTANCE_ID = "'${AMI_ID}'"' > amivar.tf
S3_BUCKET=`aws s3 ls | grep rahul | cut -d ' ' -f3`
aws s3 cp amivar.tf s3://${S3_BUCKET}/amivar.tf
