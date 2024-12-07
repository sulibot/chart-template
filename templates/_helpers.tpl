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
