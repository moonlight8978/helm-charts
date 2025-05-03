{{/*
Expand the name of the chart.
*/}}
{{- define "huly.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "huly.fullname" -}}
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
{{- define "huly.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "huly.labels" -}}
helm.sh/chart: {{ include "huly.chart" . }}
{{ include "huly.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "huly.selectorLabels" -}}
app.kubernetes.io/name: {{ include "huly.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "huly.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "huly.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "huly.common.component" -}}
huly.io/component: {{ . }}
{{- end -}}

{{- define "huly.common.envFrom" -}}
- secretRef:
    name: {{ include "huly.env.fullname" . }}
{{- end }}

{{- define "huly.common.image" -}}
{{- printf "%s:%s" .image.repository (.image.tag | default .root.Chart.AppVersion) -}}
{{- end -}}

{{- define "huly.common.imagePullPolicy" -}}
{{ .pullPolicy | default "IfNotPresent" }}
{{- end -}}

{{- define "huly.common.podSecurity" }}
serviceAccountName: {{ include "huly.serviceAccountName" . }}
{{- with .Values.podSecurityContext }}
securityContext:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- end }}

{{- define "huly.env.fullname" -}}
{{- printf "%s-%s" (include "huly.fullname" .) "env" -}}
{{- end -}}

{{- define "huly.front.name" -}}
{{- printf "%s-%s" (include "huly.name" .) "front" -}}
{{- end -}}

{{- define "huly.front.fullname" -}}
{{- printf "%s-%s" (include "huly.fullname" .) "front" -}}
{{- end -}}

{{- define "huly.front.labels" -}}
{{ include "huly.labels" . }}
{{ include "huly.common.component" "front" }}
{{- end }}

{{- define "huly.front.selectorLabels" -}}
{{ include "huly.selectorLabels" . }}
{{ include "huly.common.component" "front" }}
{{- end }}

{{- define "huly.front.envFrom" -}}
{{- include "huly.common.envFrom" . -}}
{{- end }}

{{- define "huly.front.image" -}}
{{- include "huly.common.image" (dict "image" .Values.front.image "root" .) -}}
{{- end -}}

{{- define "huly.account.name" -}}
{{- printf "%s-%s" (include "huly.name" .) "account" -}}
{{- end -}}

{{- define "huly.account.fullname" -}}
{{- printf "%s-%s" (include "huly.fullname" .) "account" -}}
{{- end -}}

{{- define "huly.account.labels" -}}
{{ include "huly.labels" . }}
{{ include "huly.common.component" "account" }}
{{- end }}

{{- define "huly.account.selectorLabels" -}}
{{ include "huly.selectorLabels" . }}
{{ include "huly.common.component" "account" }}
{{- end }}

{{- define "huly.account.envFrom" -}}
{{- include "huly.common.envFrom" . -}}
{{- end }}

{{- define "huly.account.image" -}}
{{- include "huly.common.image" (dict "image" .Values.account.image "root" .) -}}
{{- end -}}

{{- define "huly.transactor.name" -}}
{{- printf "%s-%s" (include "huly.name" .) "transactor" -}}
{{- end -}}

{{- define "huly.transactor.fullname" -}}
{{- printf "%s-%s" (include "huly.fullname" .) "transactor" -}}
{{- end -}}

{{- define "huly.transactor.labels" -}}
{{ include "huly.labels" . }}
{{ include "huly.common.component" "transactor" }}
{{- end }}

{{- define "huly.transactor.selectorLabels" -}}
{{ include "huly.selectorLabels" . }}
{{ include "huly.common.component" "transactor" }}
{{- end }}

{{- define "huly.transactor.envFrom" -}}
{{- include "huly.common.envFrom" . -}}
{{- end }}

{{- define "huly.transactor.image" -}}
{{- include "huly.common.image" (dict "image" .Values.transactor.image "root" .) -}}
{{- end -}}

{{- define "huly.collaborator.name" -}}
{{- printf "%s-%s" (include "huly.name" .) "collaborator" -}}
{{- end -}}

{{- define "huly.collaborator.fullname" -}}
{{- printf "%s-%s" (include "huly.fullname" .) "collaborator" -}}
{{- end -}}

{{- define "huly.collaborator.labels" -}}
{{ include "huly.labels" . }}
{{ include "huly.common.component" "collaborator" }}
{{- end }}

{{- define "huly.collaborator.selectorLabels" -}}
{{ include "huly.selectorLabels" . }}
{{ include "huly.common.component" "collaborator" }}
{{- end }}

{{- define "huly.collaborator.envFrom" -}}
{{- include "huly.common.envFrom" . -}}
{{- end }}

{{- define "huly.collaborator.image" -}}
{{- include "huly.common.image" (dict "image" .Values.collaborator.image "root" .) -}}
{{- end -}}

{{- define "huly.stats.name" -}}
{{- printf "%s-%s" (include "huly.name" .) "stats" -}}
{{- end -}}

{{- define "huly.stats.fullname" -}}
{{- printf "%s-%s" (include "huly.fullname" .) "stats" -}}
{{- end -}}

{{- define "huly.stats.labels" -}}
{{ include "huly.labels" . }}
{{ include "huly.common.component" "stats" }}
{{- end }}

{{- define "huly.stats.selectorLabels" -}}
{{ include "huly.selectorLabels" . }}
{{ include "huly.common.component" "stats" }}
{{- end }}

{{- define "huly.stats.envFrom" -}}
{{- include "huly.common.envFrom" . -}}
{{- end }}

{{- define "huly.stats.image" -}}
{{- include "huly.common.image" (dict "image" .Values.stats.image "root" .) -}}
{{- end -}}

{{- define "huly.fulltext.name" -}}
{{- printf "%s-%s" (include "huly.name" .) "fulltext" -}}
{{- end -}}

{{- define "huly.fulltext.fullname" -}}
{{- printf "%s-%s" (include "huly.fullname" .) "fulltext" -}}
{{- end -}}

{{- define "huly.fulltext.labels" -}}
{{ include "huly.labels" . }}
{{ include "huly.common.component" "fulltext" }}
{{- end }}

{{- define "huly.fulltext.selectorLabels" -}}
{{ include "huly.selectorLabels" . }}
{{ include "huly.common.component" "fulltext" }}
{{- end }}

{{- define "huly.fulltext.envFrom" -}}
{{- include "huly.common.envFrom" . -}}
{{- end }}

{{- define "huly.fulltext.image" -}}
{{- include "huly.common.image" (dict "image" .Values.fulltext.image "root" .) -}}
{{- end -}}

{{- define "huly.rekoni.name" -}}
{{- printf "%s-%s" (include "huly.name" .) "rekoni" -}}
{{- end -}}

{{- define "huly.rekoni.fullname" -}}
{{- printf "%s-%s" (include "huly.fullname" .) "rekoni" -}}
{{- end -}}

{{- define "huly.rekoni.labels" -}}
{{ include "huly.labels" . }}
{{ include "huly.common.component" "rekoni" }}
{{- end }}

{{- define "huly.rekoni.selectorLabels" -}}
{{ include "huly.selectorLabels" . }}
{{ include "huly.common.component" "rekoni" }}
{{- end }}

{{- define "huly.rekoni.envFrom" -}}
{{- include "huly.common.envFrom" . -}}
{{- end }}

{{- define "huly.rekoni.image" -}}
{{- include "huly.common.image" (dict "image" .Values.rekoni.image "root" .) -}}
{{- end -}}

{{- define "huly.workspace.name" -}}
{{- printf "%s-%s" (include "huly.name" .) "workspace" -}}
{{- end -}}

{{- define "huly.workspace.fullname" -}}
{{- printf "%s-%s" (include "huly.fullname" .) "workspace" -}}
{{- end -}}

{{- define "huly.workspace.labels" -}}
{{ include "huly.labels" . }}
{{ include "huly.common.component" "workspace" }}
{{- end }}

{{- define "huly.workspace.selectorLabels" -}}
{{ include "huly.selectorLabels" . }}
{{ include "huly.common.component" "workspace" }}
{{- end }}

{{- define "huly.workspace.envFrom" -}}
{{- include "huly.common.envFrom" . -}}
{{- end }}

{{- define "huly.workspace.image" -}}
{{- include "huly.common.image" (dict "image" .Values.workspace.image "root" .) -}}
{{- end -}}

# https://github.com/8gears/n8n-helm-chart/blob/565fbf72fbb9da02f1921d395327a8de4712346b/charts/n8n/templates/_helpers.tpl#L77
{{/* Create environment variables from yaml tree */}}
{{- define "toEnvVars" -}}
  {{- $prefix := "" }}
  {{- if .prefix }}
    {{- $prefix = printf "%s_" .prefix }}
  {{- end }}
  {{- range $key, $value := .values }}
    {{- if kindIs "map" $value -}}
      {{- dict "values" $value "prefix" (printf "%s%s" $prefix ($key | upper)) "isSecret" $.isSecret | include "toEnvVars" -}}
    {{- else -}}
      {{- if $.isSecret -}}
{{ $prefix }}{{ $key | upper }}: {{ $value | toString | b64enc }}{{ "\n" }}
      {{- else -}}
{{ $prefix }}{{ $key | upper }}: {{ $value | toString | quote }}{{ "\n" }}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end }}


