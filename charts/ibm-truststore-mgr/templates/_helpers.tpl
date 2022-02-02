{{/*
Expand the name of the chart.
*/}}
{{- define "truststoremgr.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "truststoremgr.fullname" -}}
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
{{- define "truststoremgr.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "truststoremgr.labels" -}}
helm.sh/chart: {{ include "truststoremgr.chart" . }}
{{ include "truststoremgr.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "truststoremgr.selectorLabels" -}}
app.kubernetes.io/name: {{ include "truststoremgr.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
control-plane: ibm-truststore-mgr
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "truststoremgr.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "truststoremgr.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "truststoremgr.roleName" -}}
{{- default "ibm-truststore-mgr-manager-role" .Values.roleName }}
{{- end }}

{{- define "truststoremgr.roleBindingName" -}}
{{- default "ibm-truststore-mgr-manager-rolebinding" .Values.roleName }}
{{- end }}
