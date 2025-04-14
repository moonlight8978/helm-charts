# Helm Charts

A collection of Helm charts hosted on GitHub Pages.

## Usage

### Add the Helm Repository

```bash
helm repo add moonlight8978 https://moonlight8978.github.io/helm-charts
helm repo update
```

### List Available Charts

```bash
helm search repo moonlight8978
```

### Install a Chart

Replace `my-release` with your preferred release name and `chart-name` with the name of the chart you want to install:

```bash
helm install my-release moonlight8978/chart-name
```

For example:

```bash
helm install my-app moonlight8978/extra-manifests
```

## Available Charts

For a complete list of available charts, please check the [`/charts`](./charts) directory in this repository.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
