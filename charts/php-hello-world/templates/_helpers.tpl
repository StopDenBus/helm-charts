{{/*
Return the proper Gitea image name
*/}}
{{- define "php-hello-world.image" -}}
{{- include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global) -}}
{{- end -}}