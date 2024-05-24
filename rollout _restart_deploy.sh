#!/bin/bash

# Get all namespaces
namespaces=$(kubectl get namespaces -o jsonpath="{.items[*].metadata.name}")

# Loop through each namespace and perform a rollout restart for each deployment
for ns in $namespaces; do
  echo "Processing namespace: $ns"
  
  # Get all deployments in the current namespace
  deployments=$(kubectl get deployments -n $ns -o jsonpath="{.items[*].metadata.name}")
  
  # Loop through each deployment and perform a rollout restart
  for deploy in $deployments; do
    echo "Restarting deployment: $deploy in namespace: $ns"
    kubectl rollout restart deployment $deploy -n $ns
    
    # Wait for the rollout to complete before moving to the next deployment
    kubectl rollout status deployment $deploy -n $ns
  done
done
