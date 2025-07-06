{{- define "ocr-model.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{- define "ocr-model.labels" -}}
app.kubernetes.io/name: {{ include "ocr-model.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
chart: {{ .Chart.Name }}-{{ .Chart.Version }}
{{- end }}
