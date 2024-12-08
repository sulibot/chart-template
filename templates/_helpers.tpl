{{/*
Generate the full name of the application based on the release name.
*/}}
{{- define "chart-template.fullname" -}}
{{ if .Release }}
{{ .Release.Name | trunc 63 | trimSuffix "-" }}
{{ else }}
default-release
{{ end }}
{{- end }}

{{/*
Generate the name of the chart based on the chart name.
*/}}
{{- define "chart-template.name" -}}
{{ if .Chart }}
{{ .Chart.Name | default "chart-template" }}
{{ else }}
chart-template
{{ end }}
{{- end }}

{{/*
Generate labels for the application based on the values and resource type.
*/}}
{{- define "chart-template.labels" -}}
{{- $resourceType := .resourceType | default "component" -}}
app.kubernetes.io/name: "{{ include "chart-template.name" . }}"  # Chart name
app.kubernetes.io/instance: "{{ include "chart-template.fullname" . }}"  # Release name
app.kubernetes.io/version: "{{ .Chart.AppVersion | default "0.1.0" }}"
app.kubernetes.io/component: "{{ $resourceType }}"
app.kubernetes.io/managed-by: "{{ .Release.Service | default "Helm" }}"
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
  release_name: "{{ if .Release.Name }}{{ .Release.Name | default "nil" }}{{ else }}nil{{ end }}"
  chart_exists: "{{ .Chart | not | ternary "false" "true" }}"
  chart_name: "{{ if .Chart.Name }}{{ .Chart.Name | default "nil" }}{{ else }}nil{{ end }}"
  chart_version: "{{ if .Chart.Version }}{{ .Chart.Version | default "nil" }}{{ else }}nil{{ end }}"
  namespace: "{{ .Values.namespace | default "default" }}"
  image: "{{ .Values.image.repository | default "unknown" }}{{ if .Values.image.tag }}:{{ .Values.image.tag }}{{ end }}{{ if .Values.image.digest }}@{{ .Values.image.digest }}{{ end }}"
{{- end }}
{{- end }}
