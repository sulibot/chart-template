
# **chart-template**

A reusable Helm chart template for deploying containerized applications in Kubernetes. This chart simplifies application deployment by providing pre-configured templates for deployments, services, HTTPRoutes (for Gateway API), and PersistentVolumeClaims (PVCs).

---

## **Getting Started**

### **1. Clone the Repository**
```bash
git clone https://github.com/sulibot/chart-template.git
cd chart-template
```

---

### **2. Customize `values.yaml`**
Edit the `values.yaml` file to match your application requirements:

#### Example:
```yaml
# Application-specific settings
name: radarr
namespace: media

# Docker container
image:
  repository: linuxserver/radarr
  tag: latest
  pullPolicy: IfNotPresent

# Networking
host: radarr.sulibot.com
gateway:
  name: public-gateway
  namespace: network

# PVC for config
pvc:
  enabled: true
  resources:
    requests:
      storage: 10Gi
  storageClassName: csi-cephfs-sc
  mountPath: /config

# Shared PVC for media
sharedMedia:
  enabled: true
  name: shared-media-pvc
  mountPath: /media
```

---

### **3. Install the Chart**
Deploy the chart using Helm:

#### Without Flux:
```bash
helm install radarr ./chart-template -f values.yaml
```

#### With FluxCD:
Create a HelmRelease manifest:
```bash
flux create helmrelease radarr \
  --source GitRepository/sulibot \
  --chart ./chart-template \
  --values values.yaml \
  --chart-version 0.1.0 \
  --interval 1h \
  --export > radarr-helmrelease.yaml
```
Apply the manifest:
```bash
kubectl apply -f radarr-helmrelease.yaml
```

---

## **Examples**

### **Basic Example: Single Application**
Deploy an application called `radarr` with a custom configuration path and a shared media volume:
```yaml
name: radarr
namespace: media
image:
  repository: linuxserver/radarr
  tag: latest
host: radarr.sulibot.com
pvc:
  enabled: true
  resources:
    requests:
      storage: 5Gi
sharedMedia:
  enabled: true
  mountPath: /media
```

### **Advanced Example: Dual-Stack Networking**
Deploy an application with dual-stack networking and a larger persistent storage volume:
```yaml
name: sonarr
namespace: media
image:
  repository: linuxserver/sonarr
  tag: latest
host: sonarr.sulibot.com
pvc:
  enabled: true
  resources:
    requests:
      storage: 20Gi
sharedMedia:
  enabled: true
  mountPath: /shared-media
```

Deploy using Helm:
```bash
helm install sonarr ./chart-template -f values.yaml
```

---

## **Directory Structure**
```
chart-template/
├── Chart.yaml                # Chart metadata
├── values.yaml               # Default configuration values
├── templates/
│   ├── deployment.yaml       # Deployment template
│   ├── service.yaml          # Service template (supports dual-stack)
│   ├── httproute.yaml        # HTTPRoute template for Gateway API
│   ├── config-pvc.yaml       # PVC template for application-specific storage
├── _helpers.tpl              # Helper templates
```

---

## **Customization Options**

### **1. General Settings**
- `name`: Application name, used in resource naming.
- `namespace`: Kubernetes namespace for the application.

### **2. Image Configuration**
- `image.repository`: Docker repository.
- `image.tag`: Image tag.
- `image.pullPolicy`: Pull policy for the container image.

### **3. Networking**
- `host`: Domain for HTTPRoute.
- `gateway.name`: Gateway name for HTTPRoute.
- `gateway.namespace`: Namespace for the Gateway and HTTPRoute.

### **4. PersistentVolumeClaims**
- `pvc.enabled`: Enable/disable application-specific PVC.
- `pvc.storageClassName`: Storage class for the PVC (default: `csi-cephfs-sc`).
- `pvc.mountPath`: Mount path for the application (default: `/config`).

### **5. Shared Media Storage**
- `sharedMedia.enabled`: Enable/disable shared PVC for media.
- `sharedMedia.name`: Name of the shared PVC.
- `sharedMedia.mountPath`: Mount path for the shared PVC.

### **6. Probes**
- Define health checks using `probes.liveness`, `probes.readiness`, and `probes.startup`.

---
