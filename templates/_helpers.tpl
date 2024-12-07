{{/*
Generate the full name of the application based on the release name and chart name.
*/}}
{{- define "chart-template.fullname" -}}
{{ if .Release }}{{ .Release.Name | trunc 63 | trimSuffix "-" }}{{ else }}default-release{{ end }}
{{- end }}

{{/*
Generate the name of the chart based on the chart name only.
*/}}
{{- define "chart-template.name" -}}
{{ if .Chart }}{{ default "unknown-chart" .Chart.Name }}{{ else }}unknown-chart{{ end }}
{{- end }}

{{/*
Generate labels for the application based on the values and resource type.
*/}}
{{- define "chart-template.labels" -}}
{{- $resourceType := .resourceType | default "component" -}}
app.kubernetes.io/name: {{ if .Chart }}{{ default "unknown-chart" .Chart.Name }}{{ else }}unknown-chart{{ end }}
app.kubernetes.io/instance: {{ if .Release }}{{ default "default-instance" .Release.Name }}{{ else }}default-instance{{ end }}
app.kubernetes.io/version: {{ if .Chart }}{{ default "0.1.0" .Chart.AppVersion }}{{ else }}0.1.0{{ end }}
app.kubernetes.io/component: {{ $resourceType }}
app.kubernetes.io/managed-by: {{ if .Release }}{{ default "Helm" .Release.Service }}{{ else }}Helm{{ end }}
{{- end }}

{{/*
Generate annotations for the application based on the values and resource type.
*/}}
{{- define "chart-template.annotations" -}}
description: "Annotations for {{ .resourceType | default "unknown" }}"
{{- end }}

{{/*
Debugging Helper: Outputs debug information when enabled in values.yaml.
*/}}
{{- define "chart-template.debug" -}}
{{- if .Values.labels.debug -}}
debug:
  release_exists: "{{ .Release | not | ternary "false" "true" }}"
  release_name: "{{ if .Release }}{{ .Release.Name | default "nil" }}{{ else }}nil{{ end }}"
  chart_exists: "{{ .Chart | not | ternary "false" "true" }}"
  chart_name: "{{ if .Chart }}{{ .Chart.Name | default "nil" }}{{ else }}nil{{ end }}"
  chart_version: "{{ if .Chart }}{{ .Chart.Version | default "nil" }}{{ else }}nil{{ end }}"
  namespace: "{{ .Values.namespace | default "default" }}"
  image: "{{ .Values.image.repository | default "unknown" }}:{{ .Values.image.tag | default "latest" }}"
{{- end }}
{{- end }}
