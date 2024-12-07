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
Default PVC storage size.
*/}}
{{- define "chart-template.defaultConfigStorage" -}}
{{- .Values.config.resources.requests.storage | default "1Gi" -}}
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
