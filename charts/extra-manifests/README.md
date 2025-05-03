# extra-manifests

- This chart is inspired of `rancher/rancher`'s `extraObjects`. Array overriding is not supported, so both sensitive and insensitive objects must defined in `secrets.yaml` (Helm Secrets plugin)

## Usage

### Basic Usage

Create a `values.yaml` file with your Kubernetes manifests:

```yaml
manifests:
  deployment:
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: example-app
      namespace: default
    spec:
      replicas: 1
      selector:
        matchLabels:
          app: example
      template:
        metadata:
          labels:
            app: example
        spec:
          containers:
          - name: app
            image: nginx:latest
            ports:
            - containerPort: 80

  service:
    apiVersion: v1
    kind: Service
    metadata:
      name: example-service
      namespace: default
    spec:
      selector:
        app: example
      ports:
      - port: 80
        targetPort: 80
```

Install the chart:

```bash
helm install my-manifests moonlight8978/extra-manifests -f values.yaml
```

### Using with Helm Secrets

1. First, install the Helm Secrets plugin if you haven't already:

```bash
helm plugin install https://github.com/jkroepke/helm-secrets
```

2. Create a `values.yaml` for non-sensitive manifests:

```yaml
manifests:
  configmap:
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: app-config
      namespace: default
    data:
      APP_ENV: production
      DEBUG: "false"
```

3. Create a `secrets.yaml` file for sensitive manifests:

```yaml
manifests:
  secret:
    apiVersion: v1
    kind: Secret
    metadata:
      name: app-secrets
      namespace: default
    type: Opaque
    data:
      API_KEY: UzNjcjN0S2V5MTIzCg==  # Base64 encoded value
      DATABASE_PASSWORD: cGFzc3dvcmQxMjM=  # Base64 encoded value
```

4. Encrypt your secrets.yaml (Using sops or other method supported by helm-secrets):

```bash
sops -e -i secrets.yaml
```

5. Install the chart using both files:

```bash
helm secrets install my-manifests moonlight8978/extra-manifests -f values.yaml -f secrets.yaml
```

6. Update the release when needed:

```bash
helm secrets upgrade my-manifests moonlight8978/extra-manifests -f values.yaml -f secrets.yaml
```

### Notes on Secrets Management

When using this chart with sensitive data:
- Always ensure your secrets are properly encrypted
- Use a secure method to manage and distribute encryption keys
- Consider using a secrets management solution like HashiCorp Vault
- Be cautious about secret visibility in CI/CD pipelines

# Credit

- Rancher chart: https://github.com/rancher/rancher/blob/main/chart/templates/extra-manifests.yaml#L1
