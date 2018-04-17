{%- if salt['pillar.get']('filebeat') %}
filebeat-config:
  file.serialize:
    - name: /etc/filebeat/filebeat.yml
    - mode: 644
    - user: root
    - group: root
    - dataset_pillar: filebeat
    - formatter: yaml
{%- endif %}
