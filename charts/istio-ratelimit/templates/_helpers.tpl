{{/*
Expand the name of the chart.
*/}}
{{- define "istio-ratelimit.name" -}}
{{- default .Chart.Name .Values.ratelimit.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "istio-ratelimit.fullname" -}}
{{- if .Values.ratelimit.fullnameOverride }}
{{- .Values.ratelimit.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.ratelimit.nameOverride }}
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
{{- define "istio-ratelimit.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "istio-ratelimit.labels" -}}
helm.sh/chart: {{ include "istio-ratelimit.chart" . }}
{{ include "istio-ratelimit.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "istio-ratelimit.selectorLabels" -}}
app.kubernetes.io/name: {{ include "istio-ratelimit.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}


{{/*
header_name token
*/}}
{{- define "istio-ratelimit.tokenHeaderName" -}}
{{ .token.header_name | default "token" }}
{{- end }}