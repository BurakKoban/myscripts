helm dependency update helm-charts/parent-chart/

helm diff upgrade neat-ms-prod helm-charts/parent-chart/ --install --namespace prod --values ~/workspace/release/20230215/values-prod-full.yaml.txt --values ~/workspace/release/20230215/values-prod-pod-configuration.yaml.txt --values ~/workspace/release/20230215/values-prod-version.yaml.txt

