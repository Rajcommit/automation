# List of namespaces to restart pods in
NAMESPACES=("namespace1" "namespace2" "namespace3")

# Iterate over each namespace
for NAMESPACE in "${NAMESPACES[@]}"; do
    echo "Restarting pods in namespace: $NAMESPACE"
    
    # Get the list of pod names in the namespace
    PODS=$(kubectl get pods -n $NAMESPACE -o=name)
    
    # Iterate through each pod and restart one at a time
    for pod in $PODS; do
        echo "Restarting pod: $pod"
        kubectl delete $pod -n $NAMESPACE
        sleep 10 # Adjust sleep time as needed to allow the pod to terminate before the next restart
        # Wait until the pod is in the "Running" state again before proceeding to the next one
        kubectl wait --for=condition=Ready pod -n $NAMESPACE --timeout=180s $pod
    done
done
