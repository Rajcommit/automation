#!/bin/bash

PS3="Enter your preferred day of the week: "
select day in mon tue wed thu fri sat sun;
do
#read -p "Please provide the value of the cluster version (Can be taken from the present instance:)" val 
aws ec2 describe-images \
    --owners amazon \
    --filters "Name=name,Values=*amazon-eks-arm64-$val*" "Name=architecture,Values=arm64" \
    --query 'sort_by(Images, &CreationDate)[-1].ImageId'
