{% if salt['grains.get']('os_family') == 'Debian' %}
filebeat_repo:
  pkgrepo.managed:
    - name: deb https://artifacts.elastic.co/packages/5.x/apt stable main
    - file: /etc/apt/sources.list.d/elastic-5.x.list
    - gpgcheck: 1
    - key_url: https://artifacts.elastic.co/GPG-KEY-elasticsearch
    - require_in:
      - pkg: filebeat.install
    - watch_in:
      - pkg: filebeat.install

{% elif salt['grains.get']('os_family') == 'RedHat' %}
filebeat_repo:
  pkgrepo.managed:
    - name: elastic-5.x
    - humanname: Elastic repository for 5.x packages
    - baseurl: https://artifacts.elastic.co/packages/5.x/yum
    - gpgcheck: 1
    - gpgkey: https://artifacts.elastic.co/GPG-KEY-elasticsearch
    - enabled: True
    - require_in:
      - pkg: filebeat.install
    - watch_in:
      - pkg: filebeat.install
{% endif %}

filebeat.install:
  pkg.installed:
    - name: filebeat
