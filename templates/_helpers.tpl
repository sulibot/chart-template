apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "chart-template.fullname" . }}
  namespace: {{ .Values.namespace }}
  labels:
    {{- include "chart-template.labels" (dict "resourceType" "deployment" "Values" .Values) | nindent 4 }}
  annotations:
    {{- include "chart-template.annotations" (dict "resourceType" "deployment" "Values" .Values) | nindent 4 }}
spec:
  replicas: {{ .Values.replicaCount }}
  selector:
    matchLabels:
      app: {{ include "chart-template.fullname" . }}
  template:
    metadata:
      labels:
        {{- include "chart-template.labels" (dict "resourceType" "deployment" "Values" .Values) | nindent 8 }}
      annotations:
        {{- include "chart-template.annotations" (dict "resourceType" "deployment" "Values" .Values) | nindent 8 }}
    spec:
      containers:
        - name: {{ include "chart-template.fullname" . }}
          image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
          imagePullPolicy: IfNotPresent
          ports:
            - containerPort: {{ .Values.ports.targetPort }}
          env:
            - name: TZ
              value: "{{ .Values.timezone | default "America/Los_Angeles" }}"
          volumeMounts:
            - name: config
              mountPath: {{ .Values.config.mountPath | default "/config" }}
            {{- if .Values.sharedMedia.enabled }}
            - name: shared-media
              mountPath: {{ .Values.sharedMedia.mountPath | default "/media" }}
            {{- end }}
      volumes:
        - name: config
          persistentVolumeClaim:
            claimName: {{ include "chart-template.fullname" . }}-config-pvc
        {{- if .Values.sharedMedia.enabled }}
        - name: shared-media
          persistentVolumeClaim:
            claimName: shared-media-pvc
        {{- end }}
