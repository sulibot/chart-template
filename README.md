
# Chart Template

A Helm chart template designed for deploying containerized applications with flexibility and reusability. This chart supports optional resource limits, persistent volume claims (PVCs), networking configurations, and health probes.

## Usage

This repository provides a reusable Helm chart template that can be used to deploy applications on Kubernetes. Below are the steps to deploy an application using this chart.

### 1. Clone the Repository

```bash
git clone https://github.com/sulibot/chart-template.git
cd chart-template
```

### 2. Configure `values.yaml`

Modify the `values.yaml` file to suit your application's requirements. Below is an example configuration:

```yaml
name: app-name
namespace: media

image:
  repository: my-container-repo
  tag: latest

resources:
  enabled: true
  requests:
    memory: "256Mi"
    cpu: "250m"
  limits:
    memory: "512Mi"
    cpu: "500m"

config:
  enabled: true
  mountPath: /config

sharedMedia:
  enabled: true
  mountPath: /media
```

### 3. Deploy with Helm

You can deploy the chart using Helm. This chart supports the following Helm options:

- `--namespace`: Specify the namespace for the deployment.
- `--set`: Override values in `values.yaml`.
- `--values`: Specify a values file to use.

Example command:

```bash
helm install app-name ./chart-template -f values.yaml --namespace media
```

### 4. Deploy with Flux

If you're using Flux for GitOps, you can create a HelmRelease resource. This chart supports the following Flux options:

- `--source`: Specify the source repository.
- `--chart`: Specify the Helm chart.
- `--values`: Path to the values file.
- `--chart-version`: Specify the chart version.
- `--interval`: Set the reconciliation interval.

Example command:

```bash
flux create helmrelease app-name   --source GitRepository/sulibot   --chart https://github.com/sulibot/chart-template   --values values.yaml   --chart-version 0.1.0   --interval 1h   --export > app-name-helmrelease.yaml
```

Apply the `HelmRelease` manifest to your cluster:

```bash
kubectl apply -f app-name-helmrelease.yaml
```

### 5. Verify Deployment

Check the resources created by the Helm chart:

```bash
kubectl get all -n media
```

## Features

- **Resource Limits**: Enable or disable CPU and memory requests/limits.
- **Persistent Volume Claims**: Supports application-specific config PVCs and shared media PVCs.
- **Networking**: Easily configure Gateway and HTTPRoute for custom hostnames.
- **Health Probes**: Liveness, Readiness, and Startup probes for monitoring application health.

## Customization

1. **Resource Limits**:
   - Enable resource limits by setting `resources.enabled: true` in `values.yaml`.

2. **Persistent Volume Claims**:
   - Application-specific config PVCs are enabled by default.
   - Shared media PVC can be enabled or disabled via `sharedMedia.enabled`.

3. **Networking**:
   - Customize hostnames and Gateway configurations in `values.yaml`.

4. **Health Probes**:
   - Configure probes for liveness, readiness, and startup checks.

## Contributing

Contributions are welcome! Feel free to submit issues or pull requests to enhance the chart.

## License

This project is licensed under the MIT License.
