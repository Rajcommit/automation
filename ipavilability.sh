aws ec2 describe-subnets --filters Name=vpc-id,Values=vpc-0def13e62be836ec9 --query 'Subnets[*].[SubnetId, Tags[?Key==`Name`].Value | [0], AvailabilityZone, AvailableIpAddressCount]' --output table
