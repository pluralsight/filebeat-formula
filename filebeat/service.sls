filebeat-service:
  service.running:
    - name: filebeat
    - enable: True
    - require:
      - pkg: filebeat
    - watch:
      - file: filebeat-config
