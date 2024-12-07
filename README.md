
# Chart Template

A Helm chart template designed for deploying containerized applications with flexibility and reusability. This chart supports optional resource limits, persistent volume claims (PVCs), networking configurations, and health probes.

## Usage

This repository provides a reusable Helm chart template that can be used to deploy applications on Kubernetes. Below are the steps to deploy an application using this chart.

---

## Helm How-To

### 1. View the Values File

You can inspect the default `values.yaml` file provided in the chart repository:

```bash
cat chart-template/values.yaml
```

Modify this file according to your application's requirements.

---

### 2. Add the Chart to Helm

To add this chart to your local Helm repository:

```bash
helm repo add chart-template https://github.com/sulibot/chart-template
helm repo update
```

---

### 3. Deploy with Helm

Deploy the chart using Helm:

```bash
helm install app-name ./chart-template -f values.yaml --namespace media
```

You can also use the following Helm options:

- `--namespace`: Specify the namespace for the deployment.
- `--set`: Override specific values inline.
- `--values`: Specify the values file to use.

Example with overrides:

```bash
helm install app-name ./chart-template   --set name=custom-app   --set namespace=custom-namespace   -f values.yaml
```

---

## Flux How-To

### 1. Add the Chart to Git Repository

You can integrate the chart into your Flux GitOps workflow by creating a HelmRelease resource. First, ensure you’ve cloned the desired Git repository managed by Flux:

```bash
git clone https://github.com/sulibot/your-flux-repo.git
cd your-flux-repo
```

---

### 2. Flux Command to Create HelmRelease

Use the `flux` CLI to create the HelmRelease resource:

```bash
flux create helmrelease app-name   --source GitRepository/sulibot   --chart https://github.com/sulibot/chart-template   --values values.yaml   --chart-version 0.1.0   --interval 1h   --export > app-name-helmrelease.yaml
```

---

### 3. Apply the HelmRelease

Commit the `app-name-helmrelease.yaml` file to your Flux repository and push the changes:

```bash
git add app-name-helmrelease.yaml
git commit -m "Add HelmRelease for app-name"
git push origin main
```

Once Flux synchronizes with the repository, the application will be deployed.

---

## Features

- **Resource Limits**: Enable or disable CPU and memory requests/limits.
- **Persistent Volume Claims**: Supports application-specific config PVCs and shared media PVCs.
- **Networking**: Easily configure Gateway and HTTPRoute for custom hostnames.
- **Health Probes**: Liveness, Readiness, and Startup probes for monitoring application health.

---

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

---