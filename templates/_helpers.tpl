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

{{/*
Generate combined labels for a resource, including global and resource-specific labels.
*/}}
{{- define "chart-template.labels" -}}
{{- $global := .Values.global.labels }}
{{- $specific := index .Values.labels .resourceType }}
{{- merge $global $specific | toYaml | nindent 4 }}
{{- end }}

{{/*
Generate combined annotations for a resource, including global and resource-specific annotations.
*/}}
{{- define "chart-template.annotations" -}}
{{- $global := .Values.global.annotations }}
{{- $specific := index .Values.annotations .resourceType }}
{{- merge $global $specific | toYaml | nindent 4 }}
{{- end }}
