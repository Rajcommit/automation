#!/bin/bash

# Prompt for AWS region input
read -p "Enter the AWS region: " aws_region

# Set AWS region environment variable
export AWS_DEFAULT_REGION="$aws_region"

# Prompt for cluster name input
read -p "Enter the name of the EKS cluster: " cluster_name

# List nodegroups
# List nodegroups
nodegroups=$(aws eks list-nodegroups --cluster-name "$cluster_name" --region "$aws_region" | jq -r '.nodegroups[]')


echo "Nodegroups in cluster $cluster_name (Region: $aws_region):"
echo "$nodegroups"

echo "Describing each nodegroup:"
for nodegroup in $nodegroups; do
   aws eks describe-nodegroup --cluster-name "$cluster_name" --nodegroup-name "$nodegroup" --region "$aws_region"
done
