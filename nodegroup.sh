cluster_name="exactscience-dev-eks"
nodegroups=$(aws eks list-nodegroups --cluster-name "$cluster_name" | jq -r '.nodegroups[]')

echo "Nodegroups in cluster $cluster_name:"
echo "$nodegroups"

echo "Describing each nodegroup:"
for nodegroup in $nodegroups; do
    aws eks describe-nodegroup --cluster-name "$cluster_name" --nodegroup-name "$nodegroup"
done