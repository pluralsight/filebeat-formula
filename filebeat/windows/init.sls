{%- set appdir = 'd:\\apps\\filebeat' %}
filebeat-log-directory:
  file.directory:
    - name: d:\data\logs\filebeat
    - makedirs: true

filebeat-data-directory:
  file.directory:
    - name: {{ appdir }}\data
    - makedirs: true
    - require:
      - file: filebeat-log-directory

filebeat-config-directory:
  file.directory:
    - name: {{ appdir }}\conf.d
    - makedirs: true
    - require:
      - file: filebeat-data-directory

filebeat-copy-package:
  file.recurse:
    - name: {{ appdir }}
    - source: salt://filebeat/windows/package
    - require:
      - file: filebeat-config-directory

filebeat-install-service:
  cmd.run:
    - shell: powershell
    - name: 'cd {{ appdir }} ; ./install-service-filebeat.ps1'
    - require:
      - file: filebeat-copy-package

filebeat-copy-config:
  file.managed:
    - name: {{ appdir }}\filebeat.yml
    - source: salt://filebeat/windows/filebeat.yml
    - template: jinja
    - require:
      - cmd: filebeat-install-service
