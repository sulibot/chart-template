{{/*
Generate the full name of the application based on the chart name and release name.
*/}}
{{- define "chart-template.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{/*
Generate the name of the chart based on the chart name only.
*/}}
{{- define "chart-template.name" -}}
{{- .Chart.Name -}}
{{- end }}
