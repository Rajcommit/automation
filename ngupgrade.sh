#!/bin/bash

# For taking inpujt for cluster name
read -p "Enter the name of the EKS cluster: " cluster_name

# For taking input on launch_template
read -p "Enter the launch template name: " launch_template_name

# For taking input on version on luch template 
read -p "Enter the launch template version: " launch_template_version

# Displaying the nodegroup name in cluster  for confirming if we are operational on correct cluter
nodegroups=$(aws eks list-nodegroups --cluster-name "$cluster_name" | jq -r '.nodegroups[]')

echo "Nodegroups in cluster $cluster_name:"
echo "$nodegroups"

# Taking varibles from the existing nodegroups 
nodegroup_info=$(aws eks describe-nodegroup \
    --cluster-name "$cluster_name" \
    --nodegroup-name "$cluster_name" \
    --query 'nodegroup.{Name: nodegroupName, Subnets: subnets, ScalingConfig: scalingConfig, NodeRole: nodeRole, LaunchTemplate: launchTemplate, Tags: tags}' \
    --output json)

# Storing the VAriables 
subnets=$(echo "$nodegroup_info" | jq -r '.Subnets | join(" ")')
ami_type="AL2_x86_64" # Please don't change as we are migrating to graviton
node_role=$(echo "$nodegroup_info" | jq -r '.NodeRole')
scaling_config=$(echo $nodegroup_config | jq -r '.ScalingConfig')
tags=$(echo "$nodegroup_info" | jq -r '.Tags | to_entries | map("\(.key)=\(.value|tostring)") | join(",")')


# Create the new node group using the extracted & stored Variables 
aws eks create-nodegroup \
    --cluster-name "$cluster_name" \
    --nodegroup-name "${cluster_name}-graviton" \
    --subnets $subnets \
    --scaling-config $scaling_config \
    --ami-type="AL2_ARM_64" \
    --node-role $node_role \
    --launch-template "{\"name\": \"$launch_template_name\", \"version\": \"$launch_template_version\"}" \
    --tags $tags

# Once created it will display all the properties and tags please review carefully.