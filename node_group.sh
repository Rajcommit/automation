#!/bin/bash

# For taking input for cluster name
read -p "Enter the name of the EKS cluster: " cluster_name

# For taking input on launch_template
read -p "Enter the launch template name: " launch_template_name

# For taking input on version on launch template 
read -p "Enter the launch template version: " launch_template_version

# Displaying the nodegroup name in the cluster to confirm if we are operating on the correct cluster
nodegroups=$(aws eks list-nodegroups --cluster-name "$cluster_name" | jq -r '.nodegroups[]')

echo "Nodegroups in cluster $cluster_name:"
echo "$nodegroups"

# Fetching variables from the existing nodegroup
nodegroup_info=$(aws eks describe-nodegroup \
    --cluster-name "$cluster_name" \
    --nodegroup-name "$nodegroups" \
    --query 'nodegroup.{Name: nodegroupName, Subnets: subnets, ScalingConfig: scalingConfig, NodeRole: nodeRole, LaunchTemplate: launchTemplate, Tags: tags}' \
    --output json)

# Storing the variables extracted as JSON
subnets=$(echo "$nodegroup_info" | jq -r '.Subnets | join(" ")')
ami_type="AL2_ARM_64" 
node_role=$(echo "$nodegroup_info" | jq -r '.NodeRole')
scaling_min=$(echo "$nodegroup_info" | jq -r '.ScalingConfig.minSize')
scaling_max=$(echo "$nodegroup_info" | jq -r '.ScalingConfig.maxSize')
scaling_desired=$(echo "$nodegroup_info" | jq -r '.ScalingConfig.desiredSize')
tags=$(echo "$nodegroup_info" | jq -r '.Tags | to_entries | map("\(.key)=\(.value|tostring)") | join(",")')

# Create the new node group using the extracted & stored variables 
aws eks create-nodegroup \
    --cluster-name "$cluster_name" \
    --nodegroup-name "${cluster_name}-graviton" \
    --subnets $subnets \
    --scaling-config minSize=$scaling_min,maxSize=$scaling_max,desiredSize=$scaling_desired \
    --ami-type "AL2_ARM_64" \
    --node-role $node_role \
    --launch-template "{\"name\": \"$launch_template_name\", \"version\": \"$launch_template_version\"}" \
    --tags "$tags"

# Once created, it will display all the properties and tags. Please review carefully.
