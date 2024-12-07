{{/*
Set the default host if not provided in values.yaml
*/}}
{{- define "chart-template.host" -}}
{{- if .Values.host -}}
{{ .Values.host }}
{{- else -}}
{{ .Values.name }}.sulibot.com
{{- end -}}
{{- end }}

{{/*
Set the default Gateway name if not provided in values.yaml
*/}}
{{- define "chart-template.gatewayName" -}}
{{- if .Values.gateway.name -}}
{{ .Values.gateway.name }}
{{- else -}}
gateway-external
{{- end -}}
{{- end }}

{{/*
Set the default shared PVC name if not provided in values.yaml
*/}}
{{- define "chart-template.sharedMediaName" -}}
shared-media-pvc
{{- end }}
