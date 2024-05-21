kubectl get po -o wide -A | grep ip-10-70-151-204.ec2.internal | awk '{print "kubectl delete pod " $2 " -n " $1}' | sh
