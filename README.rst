================
Filebeat Formula
================

Install and configure filebeat.

See the full `Salt Formulas installation and usage instructions`_.

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

This formula presents a couple options for configuring filebeat. You can store
the configuration in a file and just have salt render and drop it on your
server. Or, you can store the configuration in a pillar and have salt generate
the appropriate YAML files for filebeat.

To put all configuration into ``/etc/filebeat/filebeat.yml`` just put the entire
configuration in the ``filebeat`` pillar:

.. code-block:: yaml

  filebeat:
    filebeat.inputs:
      - type: log
        paths: ["/var/log/lumber/error.log"]
    output.elasticsearch
      hosts:
        - http://elasticsearch-ng-data-1.vnerd.com:9200
        - http://elasticsearch-ng-data-2.vnerd.com:9200
        - http://elasticsearch-ng-data-3.vnerd.com:9200
      index: lumber
      username: logstash_internal
      password: |
        -----BEGIN PGP MESSAGE-----

You may prefer the model of output configuration in ``/etc/filebeat/filebeat.yml``
and input configuration in ``/etc/filebeat/conf.d/*.yml``. You can provision
``/etc/filebeat/filebeat.yml`` via pillar or file.

To provision that output configuration by pillar, simply use the above method
with the ``filebeat`` pillar without the input configurations.

To provision by file, make sure there is no ``filebeat`` pillar item registered
to your minion. By default, `salt://filebeat/linux/filebeat.yml` will be dropped
on the server. If you want to supply your own file or template, use the
``filebeat_source`` pillar:

.. code-block:: yaml

  filebeat-source: salt://lumber/api/files/filebeat.yml

Input configurations can be provisioned by pillar by defining
``filebeat-inputs``:

.. code-block:: yaml

  filebeat-inputs:
    lumber-api:
      filebeat.inputs:
        - type: log
          paths: ["/var/log/lumber/error.log"]

Or, this input configuration can be provisioned outside of slack (eg. part of a
deploy).

https://www.elastic.co/guide/en/beats/filebeat/6.x/filebeat-configuration.html

See pillar.example for example configuration.

**Index name helping**

This state is built with the grumpybear cluster in mind. Indices there follow a
pattern of ``<bounded context>-<env>``. For example, ``lumber-staging``,
``lumber-production``. Some teams used to handle this by injecting the ``env``
grain into their pillars:

.. code-block:: yaml

  index: lumber-{{ grains['env'] }}

But, adding the jinja renderer to the pillar makes it more cumbersome. So, this
``config`` state will helpfully attach the ``env`` grain to your index if it is
not there. It will also leave the field unmodified if it is this special
substitution string ``%{[fields.index]}``.

**Some changes from 5.* to 6.\***

- ``filebeat.inputs`` instead of ``filebeat.prospectors`` now.
- ``type`` instead of ``input_type``.
- Filebeat *requires* definition of ``setup.template`` if using a non-default
  index.

.. code-block:: yaml

  setup.template:
    pattern: filebeat-%{[beat.version]}
    name: lumber-staging

The ``config`` state will try to provision for you upon applying the state for
provisioning ``/etc/filebeat/filebeat.yml`` *from a pillar*. If you're
provisioning from a file, you'll need to make sure to include these newly
required configuration directives.

filebeat.service
----------------

Starts the filebeat service.

.. _Salt Formulas installation and usage instructions: http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html
