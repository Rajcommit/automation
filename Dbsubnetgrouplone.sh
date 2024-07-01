#!/bin/bash

# Get all DB subnet groups
all_subnet_groups=$(aws rds describe-db-subnet-groups --query 'DBSubnetGroups[*].DBSubnetGroupName' --output text)

# Get DB subnet groups used by RDS instances
used_subnet_groups=$(aws rds describe-db-instances --query 'DBInstances[*].DBSubnetGroup.DBSubnetGroupName' --output text)

# Convert the results to arrays
IFS=$'\n' read -r -d '' -a all_subnet_groups_array <<< "$all_subnet_groups"
IFS=$'\n' read -r -d '' -a used_subnet_groups_array <<< "$used_subnet_groups"

# Find unused subnet groups
echo "Unused DB Subnet Groups:"
for subnet_group in "${all_subnet_groups_array[@]}"; do
    if [[ ! " ${used_subnet_groups_array[@]} " =~ " ${subnet_group} " ]]; then
        echo "$subnet_group"
    fi
done
