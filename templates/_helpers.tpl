{{/*
Generate the full name of the application based on the release name and chart name.
*/}}
{{- define "chart-template.fullname" -}}
{{ .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Generate the name of the chart based on the chart name only.
*/}}
{{- define "chart-template.name" -}}
{{ .Chart.Name | default "unknown-chart" }}
{{- end }}

{{/*
Generate labels for the application based on the values and resource type.
*/}}
{{- define "chart-template.labels" -}}
{{- $resourceType := .resourceType -}}
app.kubernetes.io/name: {{ $.Chart.Name | default "unknown-chart" }}
app.kubernetes.io/instance: {{ $.Release.Name | default "default-instance" }}
app.kubernetes.io/version: {{ $.Chart.AppVersion | default "0.1.0" }}
app.kubernetes.io/component: {{ $resourceType | default "component" }}
app.kubernetes.io/managed-by: {{ $.Release.Service | default "Helm" }}
{{- end }}

{{/*
Generate annotations for the application based on the values and resource type.
*/}}
{{- define "chart-template.annotations" -}}
description: "Annotations for {{ .resourceType }}"
{{- end }}

{{/*
Debugging Helper: Outputs debug information when enabled in values.yaml.
*/}}
{{- define "chart-template.debug" -}}
debug:
  Chart.Name: {{ $.Chart.Name | default "nil" }}
  Release.Name: {{ $.Release.Name | default "nil" }}
{{- end }}
{{- end }}

