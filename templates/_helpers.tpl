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
{{ .Chart.Name | default "unknown-chart" }}
{{- end }}

{{/*
Generate labels for the application based on the values and resource type.
*/}}
{{- define "chart-template.labels" -}}
app.kubernetes.io/name: "{{ include "chart-template.name" . }}"
app.kubernetes.io/instance: "{{ .Release.Name }}"
app.kubernetes.io/version: "{{ .Chart.AppVersion }}"
app.kubernetes.io/component: "{{ .resourceType | default "component" }}"
app.kubernetes.io/managed-by: "{{ .Release.Service | default "Helm" }}"
{{- end }}

{{/*
Generate annotations for the application based on the values and resource type.
*/}}
{{- define "chart-template.annotations" -}}
description: "Annotations for {{ .resourceType }}"
{{- end }}

{{/*
Return the ipFamily block for a Service.
Valid ipFamilyPolicy options are:
  - PreferDualStack (default)
  - RequireDualStack
  - SingleStack (in which case, singleStackIPFamily is used)
*/}}
{{- define "chart-template.ipFamilies" -}}
{{- $ipPolicy := default "PreferDualStack" .Values.networking.ipFamilyPolicy -}}
ipFamilyPolicy: {{ $ipPolicy }}
{{- if or (eq $ipPolicy "PreferDualStack") (eq $ipPolicy "RequireDualStack") -}}
{{ "\n" }}ipFamilies:
  - IPv4
  - IPv6
{{- else if eq $ipPolicy "SingleStack" -}}
{{ "\n" }}ipFamilies:
  - {{ .Values.networking.singleStackIPFamily | default "IPv4" }}
{{- end -}}
{{- end -}}
