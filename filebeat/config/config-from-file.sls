filebeat-config:
  file.managed:
    - name: /etc/filebeat/filebeat.yml
    - source: salt://filebeat/linux/filebeat.yml
    - template: jinja
    - watch_in:
      - service: filebeat-service
