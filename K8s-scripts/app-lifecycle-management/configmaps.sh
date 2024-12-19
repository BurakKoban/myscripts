kubectl create configmap app-config --from-literal=APP_COLOR=blue

# To create a configmap from a file

kubectl create configmap app-config --from-file=app_config.properties

kubectl create -f configmaps.yaml

kubectl get configmaps

kubectl describe configmaps app-config

# To relpace a pod after editing the env variable

kubectl replace --force -f webapp-color.yaml

kubectl create cm webapp-config-map --from-literal=APP_COLOR=darkblue