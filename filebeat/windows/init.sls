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

filebeat-copy-config:
  file.managed:
    - name: {{ appdir }}\filebeat.yml
    - source: salt://filebeat/windows/filebeat.yml
    - template: jinja
    - require:
      - file: filebeat-copy-package

filebeat-install-service:
  cmd.script:
    - name: install-service-filebeat.ps1
    - source: salt://filebeat/windows/package/install-service-filebeat.ps1
    - shell: powershell
    - args: '-installDir {{ appdir }}'
    - require:
      - file: filebeat-copy-config
