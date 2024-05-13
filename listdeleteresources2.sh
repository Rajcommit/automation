#!/bin/bash
#For 2 tag and respective values
# Prompt the user to enter the first tag key and value
read -p "Enter the first tag key: " tag_key_1
read -p "Enter the first tag value: " tag_value_1

# Prompt the user to enter the second tag key and value
read -p "Enter the second tag key: " tag_key_2
read -p "Enter the second tag value: " tag_value_2

# Call the AWS CLI command to list resources based on the specified tag keys and values,
# then format the output using jq
aws resourcegroupstaggingapi get-resources --tag-filters Key=$tag_key_1,Values=$tag_value_1 Key=$tag_key_2,Values=$tag_value_2 \
| jq -r '.ResourceTagMappingList[] | select(.Tags != null) | [.ResourceARN, (.Tags[] | select(.Key == "'$tag_key_1'").Value), (.Tags[] | select(.Key == "'$tag_key_2'").Value)] | @tsv'
