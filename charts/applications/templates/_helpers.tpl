{{/*
Return repoURl or default one
*/}}
{{- define "repoURL" -}}
{{- if .repoURL -}}
{{ .repoURL }}
{{- else -}}
https://stopdenbus.github.io/helm-charts
{{- end -}}
{{- end -}}

{{/*
Return helm parameters
*/}}
{{- define "helmParameters" -}}
{{- if .helm -}}
helm:
{{ if .helm.releaseName -}}
{{- printf "releaseName: %s" .helm.releaseName | indent 2 -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Return applications sync policy
*/}}
{{- define "syncPolicy" -}}
{{- if .syncPolicy -}}
syncPolicy:
{{- toYaml .syncPolicy | nindent 2 }}
{{- else -}}
syncPolicy: {}
{{- end -}}
{{- end -}}