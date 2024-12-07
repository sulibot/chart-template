{{/*
Returns the full name of the release
*/}}
{{- define "chart-template.fullname" -}}
{{ .Release.Name }}
{{- end }}
