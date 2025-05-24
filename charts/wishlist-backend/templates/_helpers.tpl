{{/*
Expand the name of the chart.
*/}}
{{- define "wishlist-backend.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "wishlist-backend.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "wishlist-backend.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "wishlist-backend.labels" -}}
helm.sh/chart: {{ include "wishlist-backend.chart" . }}
{{ include "wishlist-backend.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "wishlist-backend.selectorLabels" -}}
app.kubernetes.io/name: {{ include "wishlist-backend.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "wishlist-backend.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "wishlist-backend.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the secret for database password
*/}}
{{- define "wishlist-backend.databaseSecret" -}}
{{- if .Values.config.databasePassword.existingSecret }}
{{- .Values.config.databasePassword.existingSecret }}
{{- else }}
{{- printf "%s-database-password" (include "wishlist-backend.name" . ) }}
{{- end }}
{{- end }}

{{/*
Create the name of the vault key
*/}}
{{- define "wishlist-backend.vaultKey" -}}
{{- if .Values.config.databasePassword.vaultKey }}
{{- .Values.config.databasePassword.vaultKey }}
{{- else }}
{{- printf "%s" "secrets/data/mysql/wishlist" }}
{{- end }}
{{- end }}

{{/*
Create the name of the vault property
*/}}
{{- define "wishlist-backend.vaultProperty" -}}
{{- if .Values.config.databasePassword.vaultProperty }}
{{- .Values.config.databasePassword.vaultProperty }}
{{- else }}
{{- printf "%s" "key" }}
{{- end }}
{{- end }}