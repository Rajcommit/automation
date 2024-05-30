for pod in $(kubectl get pods -o name | grep mysql-); do
  kubectl logs $pod
done
