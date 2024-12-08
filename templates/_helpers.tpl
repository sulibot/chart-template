{{/*
Generate the full name of the application based on the release name.
*/}}
{{- define "chart-template.fullname" -}}
{{- if .Release }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
default-release
{{- end }}
{{- end }}

{{/*
Generate the name of the chart based on the chart name.
*/}}
{{- define "chart-template.name" -}}
{{- if .Chart }}
{{- .Chart.Name | default "chart-template" }}
{{- else }}
chart-template
{{- end }}
{{- end }}

{{/*
Generate labels for the application based on the values and resource type.
*/}}
{{- define "chart-template.labels" -}}
{{- $resourceType := .resourceType | default "component" }}
app.kubernetes.io/name: "{{ include "chart-template.name" . }}"  # Chart name
app.kubernetes.io/instance: "{{ include "chart-template.fullname" . }}"  # Release name
app.kubernetes.io/version: "{{ if .Chart }}{{ default .Chart.AppVersion "0.1.0" }}{{ else }}0.1.0{{ end }}"
app.kubernetes.io/component: "{{ $resourceType }}"
app.kubernetes.io/managed-by: "{{ if .Release }}{{ default .Release.Service "Helm" }}{{ else }}Helm{{ end }}"
{{- end }}

{{/*
Generate annotations for the application based on the values and resource type.
*/}}
{{- define "chart-template.annotations" -}}
{{- $resourceType := .resourceType | default "unknown" }}
description: "Annotations for {{ $resourceType }}"
{{- end }}

{{/*
Debugging Helper: Outputs debug information when enabled in values.yaml.
*/}}
{{- define "chart-template.debug" -}}
{{- if .Values.labels.debug }}
debug:
  release_exists: "{{ if .Release }}true{{ else }}false{{ end }}"
  release_name: "{{ if .Release }}{{ default .Release.Name "nil" }}{{ else }}nil{{ end }}"
  chart_exists: "{{ if .Chart }}true{{ else }}false{{ end }}"
  chart_name: "{{ if .Chart }}{{ default .Chart.Name "nil" }}{{ else }}nil{{ end }}"
  chart_version: "{{ if .Chart }}{{ default .Chart.Version "nil" }}{{ else }}nil{{ end }}"
  app_version: "{{ if .Chart }}{{ default .Chart.AppVersion "nil" }}{{ else }}nil{{ end }}"
  namespace: "{{ default .Values.namespace "default" }}"
  image: "{{ default .Values.image.repository "unknown" }}{{ if .Values.image.tag }}:{{ .Values.image.tag }}{{ end }}{{ if .Values.image.digest }}@{{ .Values.image.digest }}{{ end }}"
{{- end }}
{{- end }}
