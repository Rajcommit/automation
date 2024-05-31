#!/bin/bash

# this will try to get value from file
extract_value() {
    local file=$1
    local var_name=$2
    local result
    result=$(grep "$var_name" "$file" | awk -F "=" '{print $2}' | tr -d '[:space:]"')
    echo "$result"
}

# try to find file .groovy file and get the savcomp2 value ## <update the file system here> 
config_file=$(find /opt/*/saviynt/Conf/ -name "Config.groovy")
savcomp2=$(extract_value "$config_file" "savcomp")

# try to find file .sh file and retrive savcomp3 value ## <update the file system here> 
startup_file=$(find /opt/tomcat/*/bin/ -name "startup.sh")
savcomp3=$(extract_value "$startup_file" "savcomp")

# Combining results in a single string
combined_result="S@v!yn$savcomp2$savcomp3"

# quotes and extra chars removed
combined_result=$(echo "$combined_result" | tr -d '"')

# encryption part
encrypted_result=$(echo -n "$combined_result" | base64)

# Printing end result
echo "$encrypted_result"



#Crate a file name it dbmig.sh using following command:
#nano dbmig.sh
#2> copy paste above script and provide execute permission.
#chmod +x dbmig.sh
#3> initate the script ./dbmig
#note: please update the file-system as per aws/azure






AZure:




#!/bin/bash

# this will try to get value from file
extract_value() {
    local file=$1
    local var_name=$2
    local result
    result=$(grep "$var_name" "$file" | awk -F "=" '{print $2}' | tr -d '[:space:]"')
    echo "$result"
}

# try to find file .groovy file and get the savcomp2 value ## <update the file system here> 
config_file=$(find /datadrive/sharedappdrive/*/saviynt/Conf/ -name "Config.groovy")
savcomp2=$(extract_value "$config_file" "savcomp")

# try to find file .sh file and retrive savcomp3 value ## <update the file system here> 
startup_file=$(find  /datadrive/apache/*/bin/ -name "startup.sh")
savcomp3=$(extract_value "$startup_file" "savcomp")

# Combining results in a single string
combined_result="S@v!yn$savcomp2$savcomp3"

# quotes and extra chars removed
combined_result=$(echo "$combined_result" | tr -d '"')

# encryption part
encrypted_result=$(echo -n "$combined_result" | base64)

# Printing end result
echo "$encrypted_result"








-  /datadrive/apache/apache-tomcat-8.5.29/bin
					/datadrive/sharedappdrive/saviynt/Conf
					 cd /datadrive/sharedappdrive/saviynt/logs/




