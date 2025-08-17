# kubernetes-schema-store

### Install the chart

```bash
helm repo add moonlight8978 https://moonlight8978.github.io/helm-charts
helm repo update
helm install kss moonlight8978/kubernetes-schema-store --namespace kube-system --values secrets.yaml
```

### Secrets
```yaml
rclone:
  destination: "s3:/bucket"
  s3:
    provider: AWS
    endpoint: "omit or minio endpoint"
    accessKeyId: "access key"
    secretAccessKey: "secret key"
    region: "omit or aws region"
```
