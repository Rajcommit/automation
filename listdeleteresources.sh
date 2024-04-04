#!/bin/bash

# Prompt the user to enter the tag key
read -p "Enter the tag key: " tag_key

# Prompt the user to enter the tag value
read -p "Enter the tag value: " tag_value

# Call the AWS CLI command to list resources based on the specified tag key and value,
# then format the output using jq
aws resourcegroupstaggingapi get-resources --tag-filters Key=$tag_key,Values=$tag_value \
| jq -r '.ResourceTagMappingList[] | select(.Tags != null) | [.ResourceARN, (.Tags[] | select(.Key == "'$tag_key'").Value)] | @tsv'
