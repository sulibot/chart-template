{{- define "chart-template.fullname" -}}
{{- if and .Release .Release.Name -}}
  {{ .Release.Name | trunc 63 | trimSuffix "-" | trim -}}
{{- else -}}
  chart-template
{{- end -}}
{{- end }}

{{- define "chart-template.name" -}}
{{ .Chart.Name | default "unknown-chart" | trim -}}
{{- end }}

{{- define "chart-template.labels" -}}
app.kubernetes.io/name: "{{ include "chart-template.name" $ }}"
app.kubernetes.io/instance: "{{ if and $.Release $.Release.Name }}{{ $.Release.Name | default "chart-template" | trim -}}{{ else }}chart-template{{ end }}"
app.kubernetes.io/version: "{{ $.Chart.AppVersion }}"
app.kubernetes.io/component: "{{ $.resourceType | default "component" }}"
app.kubernetes.io/managed-by: "{{ if $.Release }}{{ $.Release.Service | default "Helm" | trim -}}{{ else }}Helm{{ end }}"
{{- end }}

{{- define "chart-template.annotations" -}}
description: "Annotations for {{ $.resourceType }}"
{{- end }}

{{- define "chart-template.ipFamilies" -}}
{{- $ipPolicy := default "PreferDualStack" $.Values.networking.ipFamilyPolicy -}}
ipFamilyPolicy: {{ $ipPolicy | quote }}
{{ "\n" -}}
{{- if or (eq $ipPolicy "PreferDualStack") (eq $ipPolicy "RequireDualStack") -}}
ipFamilies:
  - IPv4
  - IPv6
{{- else if eq $ipPolicy "SingleStack" -}}
ipFamilies:
  - {{ $.Values.networking.singleStackIPFamily | default "IPv4" }}
{{- end -}}
{{- end }}
