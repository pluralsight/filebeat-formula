{%- set appdir = 'd:\\apps\\filebeat' %}
log-directory:
  file.directory:
    - name: d:\data\logs\filebeat
    - makedirs: true

data-directory:
  file.directory:
    - name: {{ appdir }}\data
    - makedirs: true
    - require:
      - file: log-directory

copy-package:
  file.recurse:
    - name: {{ appdir }}
    - source: salt://filebeat/windows/package
    - require:
      - file: data-directory

install-service:
  cmd.run:
    - shell: powershell
    - name: 'cd {{ appdir }} ; ./install-service-filebeat.ps1'
    - require:
      - file: copy-package

copy-config:
  file.managed:
    - name: {{ appdir }}\filebeat.yml
    - source: salt://filebeat/windows/filebeat.yml
    - template: jinja
    - require:
      - cmd: install-service

start-service:
  service.running:
    - name: filebeat
    - require:
      - file: copy-config
