{{/*
Return the proper renovate image name
*/}}
{{- define "renovate.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.renovate.image "global" .Values.global) }}
{{- end -}}