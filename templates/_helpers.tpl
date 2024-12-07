{{/*
Generate the full name of the application based on the release name only.
*/}}
{{- define "chart-template.fullname" -}}
{{- .Release.Name -}}
{{- end }}

{{/*
Generate the name of the chart based on the chart name only.
*/}}
{{- define "chart-template.name" -}}
{{- .Chart.Name -}}
{{- end }}

{{/*
Default PVC storage size.
*/}}
{{- define "chart-template.defaultConfigStorage" -}}
{{- default "1Gi" (default .Values.config.resources.requests.storage "") -}}
{{- end }}

{{/*
Generate the gateway name. Defaults to "gateway-internal" if not set in values.yaml.
*/}}
{{- define "chart-template.gatewayName" -}}
{{- if .Values.gateway.name -}}
{{- .Values.gateway.name -}}
{{- else -}}
gateway-internal
{{- end -}}
{{- end }}
