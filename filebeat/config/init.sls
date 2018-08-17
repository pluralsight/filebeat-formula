filebeat-confd-directory:
  file.directory:
    - name: /etc/filebeat/conf.d
    - makedirs: true

include:
{%- if salt['pillar.get']('filebeat') %}
  - filebeat.config.config-from-pillar
{%- else %}
  - filebeat.config.config-from-file
{%- endif %}
