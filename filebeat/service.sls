filebeat-service:
  service.running:
    - name: filebeat
    - require:
      - pkg: filebeat
