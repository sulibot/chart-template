{{/*
Generate the full name of the application based on the release name.
If a release is present, use its name (truncated and cleaned) – otherwise, fall back to a fixed default.
*/}}
{{- define "chart-template.fullname" -}}
{{- if and .Release .Release.Name -}}
  {{ .Release.Name | trunc 63 | trimSuffix "-" | trim }}
{{- else -}}
  chart-template
{{- end -}}
{{- end }}

{{/*
Generate the chart name.
This checks if .Chart is available; if not, returns a default.
*/}}
{{- define "chart-template.name" -}}
{{- if .Chart -}}
  {{ .Chart.Name | default "unknown-chart" | trim }}
{{- else -}}
  unknown-chart
{{- end -}}
{{- end }}

{{/*
Generate a helper for the namespace.
Returns the namespace from .Release, or defaults to "default".
*/}}
{{- define "chart-template.namespace" -}}
{{- if .Release -}}
  {{ .Release.Namespace | default "default" }}
{{- else -}}
  default
{{- end -}}
{{- end }}

{{/*
Generate a standard set of labels.
These labels include the chart name, release name, version, and a Helm identifier.
*/}}
{{- define "chart-template.labels" -}}
app.kubernetes.io/name: "{{ include "chart-template.name" . }}"
app.kubernetes.io/instance: "{{ .Release.Name | default "chart-template" }}"
app.kubernetes.io/version: "{{ .Chart.AppVersion }}"
app.kubernetes.io/managed-by: "Helm"
helm.sh/chart: "{{ .Chart.Name }}-{{ .Chart.Version }}"
{{- end }}

{{/*
Generate standard annotations for the application.
*/}}
{{- define "chart-template.annotations" -}}
description: "Managed by Helm"
{{- end }}

{{/*
Generate the ipFamilies block for Services.
The ipFamilyPolicy is set from .Values.networking.ipFamilyPolicy (defaulting to PreferDualStack).
If SingleStack is chosen, the singleStackIPFamily is used.
An explicit newline is inserted between the policy and the ipFamilies key.
*/}}
{{- define "chart-template.ipFamilies" -}}
{{- $ipPolicy := default "PreferDualStack" .Values.networking.ipFamilyPolicy -}}
ipFamilyPolicy: {{ $ipPolicy }}
{{ "\n" -}}
{{- if or (eq $ipPolicy "PreferDualStack") (eq $ipPolicy "RequireDualStack") -}}
ipFamilies:
  - IPv4
  - IPv6
{{- else if eq $ipPolicy "SingleStack" -}}
ipFamilies:
  - {{ .Values.networking.singleStackIPFamily | default "IPv4" }}
{{- end -}}
{{- end }}
