{{- define "api-gateway.fullname" -}}
{{ include "common.labels" . }}api-gateway
{{- end }}

{{- define "common.labels" -}}
{{ .Release.Name }}-
{{- end }}
