!#/bin/bash


#For prod -m7g
#For non-prod -m6g

#safety-- config details , you will take teh ss
#Modify the DB
#Change the DB engine version to : latest { 8.0.36}
#Change teh Parameter-group -mysql-8parameretgroup will be there .
#Option group -8.0


#Graviton:
#If the DB is 500 or more we will do the change in the window
#chcek for teh 
#NON-PROD
#CURRENT   nEW
#r5.Large  m6g.xlarge
#m5.xlarge m6g.xlarge
#r5.xlarge m6g.2xLarge
#m5.2xLarge m6g.2xLarge
#PROD
#CURRENT   nEW
#r5.Large  m7g.xlarge ---
#m5.xlarge m7g.xlarge
#r5.xlarge m7g.2xLarge
#r5.2xlarge  m7g.4xlarge
#m5.2xLarge m7g.2xLarge#!/bin/bash

# Prompt the user for the RDS endpoint
read -p "Please provide the RDS endpoint: " rds

# Prompt the user for the region
read -p "Please provide the region: " region

# Check if the RDS endpoint variable is not empty
if [ -n "$rds" ]; then
  # Describe RDS instances and filter by the provided endpoint
  aws rds describe-db-instances --region "$region" | jq --arg rds "$rds" '.DBInstances[] | select(.Endpoint.Address == $rds)'
else
  echo "The RDS endpoint not found"
fi
