kubectl get po -o wide -A | grep ip-10-70-151-204.ec2.internal | awk '{print "kubectl delete pod " $2 " -n " $1}' | sh


kubectl scale --replicas=0 deployment/saviynt-cluster-prometheus-node-exporter-2x88c --namespace=saviynt-system

