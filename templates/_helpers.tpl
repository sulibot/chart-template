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
{{ .Chart.Name }}
{{- end }}

{{/*
Generate labels for the application based on the values and resource type.
*/}}
{{- define "chart-template.labels" -}}
{{- $resourceType := .resourceType -}}
app.kubernetes.io/name: {{ $.Chart.Name }}
app.kubernetes.io/instance: {{ $.Release.Name }}
app.kubernetes.io/version: {{ $.Chart.AppVersion }}
app.kubernetes.io/component: {{ $resourceType }}
app.kubernetes.io/managed-by: {{ $.Release.Service }}
{{- end }}

{{/*
Generate annotations for the application based on the values and resource type.
*/}}
{{- define "chart-template.annotations" -}}
description: "Annotations for {{ .resourceType }}"
{{- end }}
