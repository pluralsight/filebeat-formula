================
Filebeat Formula
================

Install and configure filebeat.

See the full [Salt Formulas installation and usage instructions](http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html).

Available states
================

- filebeat.install
- filebeat.config
- filebeat.service

filebeat.install
----------------

Installs the filebeat package, version 6.

filebeat.config
---------------

Configures filebeat. Since filebeat config files are YAML, the filebeat pillar _is_ the config.

https://www.elastic.co/guide/en/beats/filebeat/6.x/filebeat-configuration.html

See pillar.example for example configuration.

filebeat.service
----------------

Starts the filebeat service.
