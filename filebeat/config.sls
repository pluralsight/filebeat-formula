{% from "filebeat/map.jinja" import conf with context %}

{%- if salt['pillar.get']('filebeat') %}
filebeat-config:
  file.serialize:
    - name: {{ conf.config_path }}
    - mode: 644
    - user: root
    - group: root
    - dataset_pillar: filebeat
    - formatter: yaml
{%- endif %}
