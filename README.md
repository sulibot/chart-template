
# Chart Template

A Helm chart template designed for deploying containerized applications with flexibility and reusability. This chart supports optional resource limits, persistent volume claims (PVCs), networking configurations, and health probes.

## Usage

This repository provides a reusable Helm chart template that can be used to deploy applications on Kubernetes. Below are the steps to deploy an application using this chart.

---

## Helm How-To

### 1. Add the Chart to Helm

#### Option 1: Install the Helm Repo
To install the chart from a Helm repository:

1. Add the repository:
    ```bash
    helm repo add chart-template https://github.com/sulibot/chart-template
    helm repo update
    ```

2. Install the chart:
    ```bash
    helm install app-name chart-template/chart-template       --namespace media       -f values.yaml
    ```

#### Option 2: Use the Chart Locally
If you have cloned the chart repository locally:

1. Clone the repository:
    ```bash
    git clone https://github.com/sulibot/chart-template.git
    cd chart-template
    ```

2. Install the chart:
    ```bash
    helm install app-name ./chart-template       --namespace media       -f values.yaml
    ```

---

### 2. Export Helm Templates

To export Kubernetes manifests from Helm without applying them:

```bash
helm template app-name ./chart-template   --namespace media   -f values.yaml > app-name-helm-manifests.yaml
```

The resulting `app-name-helm-manifests.yaml` file contains the Kubernetes resources for the chart.

---

### 3. Troubleshooting Helm Deployments

- **Check Helm Logs**:
    ```bash
    helm history app-name
    helm status app-name
    ```

- **Debug Installations**:
    ```bash
    helm install app-name ./chart-template --debug --dry-run
    ```

- **Upgrade or Rollback**:
    ```bash
    helm upgrade app-name ./chart-template -f values.yaml
    helm rollback app-name <revision_number>
    ```

---

## Flux How-To

### Assumptions
- Flux is installed and functional in your cluster.
- Your repository is already managed by Flux.

---

### 1. Create a Source for Helm

To create a Helm source pointing to the chart repository:

```bash
flux create source helm chart-template   --url=https://github.com/sulibot/chart-template   --interval=1h   --export > chart-template-source.yaml
```

Apply the Helm source to the cluster:

```bash
kubectl apply -f chart-template-source.yaml
```

Verify the Helm source:

```bash
flux get sources helm
```

---

### 2. Create a HelmRelease

Use the `flux` CLI to create a HelmRelease resource for the chart:

```bash
flux create helmrelease app-name   --source HelmRepository/chart-template   --chart chart-template   --values values.yaml   --chart-version 0.1.0   --interval 1h   --export > app-name-helmrelease.yaml
```

Apply the HelmRelease to the cluster:

```bash
kubectl apply -f app-name-helmrelease.yaml
```

Verify the HelmRelease:

```bash
flux get helmreleases -A
```

---

### 3. Export Flux Manifests

To export all manifests for the HelmRelease and Helm source:

1. Export Helm source:
    ```bash
    flux create source helm chart-template       --url=https://github.com/sulibot/chart-template       --interval=1h       --export > chart-template-source.yaml
    ```

2. Export HelmRelease:
    ```bash
    flux create helmrelease app-name       --source HelmRepository/chart-template       --chart chart-template       --values values.yaml       --chart-version 0.1.0       --interval 1h       --export > app-name-helmrelease.yaml
    ```

These files can be committed to your GitOps repository.

---

### 4. Troubleshooting Flux

- **Check HelmRelease Status**:
    ```bash
    flux get helmreleases -A
    ```

- **Check Source Status**:
    ```bash
    flux get sources helm -A
    ```

- **View Logs**:
    ```bash
    kubectl logs -n flux-system deployment/helm-controller
    ```

- **Reconcile Resources**:
    ```bash
    flux reconcile helmrelease app-name
    flux reconcile source helm chart-template
    ```

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
