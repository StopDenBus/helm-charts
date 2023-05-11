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

{{/*
Return name from feature branche
*/}}
{{- define "featureBrancheName" -}}
{{- $branch :=  trimPrefix "feature/" .feature }}
{{- printf "%s-%s" $branch .app -}}
{{- end -}}

{{/*
Return feature branche helm parameters
*/}}
{{- define "featureBrancheHelmParameters" -}}
{{- $featureBrancheName := (include "featureBrancheName" .) -}}
{{- $hostname := printf "%s.apps.gusek.info" $featureBrancheName -}}
{{- $hosts := dict "secretName" "wildcard-apps" "hosts" list $hostname  -}}
{{- $extraTls := list $hosts -}}
helm:
{{ printf "releaseName: %s" $featureBrancheName | indent 2 }}
  parameters:
    - name: "application.image.tag"
      value: {{ .properties.tag }}
    - name: "ingress.hostname"
      value: {{ $hostname }}
    - name: "ingress.extraTls[0].hosts[0]"
      value: {{ printf "%s.apps.gusek.info" $featureBrancheName }}
    - name: "ingress.extraTls[0].secretName"
      value: "wildcard-apps"
{{- end -}}