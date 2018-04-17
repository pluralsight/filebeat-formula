# filebeat formula
Install and configure filebeat.

See the full [Salt Formulas installation and usage instructions](http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html).

## Available states

* filebeat.install
* filebeat.config
* filebeat.service

## filebeat.install

Installs the filebeat package.

## filebeat.config

Configures filebeat. Since filebeat config files are YAML, the filebeat pillar _is_ the config.

https://www.elastic.co/guide/en/beats/filebeat/5.6/filebeat-configuration.html

See pillar.example for example configuration.

## filebeat.service

Starts the filebeat service.

Testing
=======

Testing is done with [Test Kitchen](http://kitchen.ci/)
for machine setup and [testinfra](https://testinfra.readthedocs.io/en/latest/)
for integration tests.

Requirements
------------

* Python
* Ruby
* Docker

    pip install -r requirements.txt
    gem install bundler
    bundle install
    bundle exec kitchen test
