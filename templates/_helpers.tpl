{{/*
Generate the full name of the application based on the release name and chart name.
*/}}
{{- define "chart-template.fullname" -}}
{{- if .Release }}
{{ .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
default-release
{{- end }}
{{- end }}

{{/*
Generate the name of the chart based on the chart name.
*/}}
{{- define "chart-template.name" -}}
{{- if .Chart }}
{{ .Chart.Name | default "chart-template" }}
{{- else }}
chart-template
{{- end }}
{{- end }}

{{/*
Generate labels for the application based on the values and resource type.
*/}}
{{- define "chart-template.labels" -}}
{{- $resourceType := .resourceType | default "component" }}
app.kubernetes.io/name: {{ include "chart-template.name" . }}
app.kubernetes.io/instance: {{ include "chart-template.fullname" . }}
app.kubernetes.io/version: {{ if .Chart }}{{ .Chart.AppVersion | default "0.1.0" }}{{ else }}0.1.0{{ end }}
app.kubernetes.io/component: {{ $resourceType }}
app.kubernetes.io/managed-by: {{ if .Release }}{{ .Release.Service | default "Helm" }}{{ else }}Helm{{ end }}
{{- end }}

{{/*
Generate annotations for the application based on the values and resource type.
*/}}
{{- define "chart-template.annotations" -}}
{{- $resourceType := .resourceType | default "unknown" }}
description: "Annotations for {{ $resourceType }}"
{{- end }}
