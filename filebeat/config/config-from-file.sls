{% set filebeat_source = salt['pillar.get']('filebeat-source', 'salt://filebeat/linux/filebeat.yml') %}

filebeat-config:
  file.managed:
    - name: /etc/filebeat/filebeat.yml
    - source: {{ filebeat_source }}
    - template: jinja
    - watch_in:
      - service: filebeat-service
