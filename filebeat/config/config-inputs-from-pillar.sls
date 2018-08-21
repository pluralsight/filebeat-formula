#!py

def run():
    filebeat_inputs = __pillar__.get('filebeat-inputs', {})
    env = __grains__['env']
    config= {}

    for k,v in filebeat_inputs.items():
        v['fields']['index'] += '-' + env
        config['filebeat-input-' + k] = {
            'file.serialize': [
                {'name': '/etc/filebeat/conf.d/' + k + '.yml'},
                {'mode': '644'},
                {'user': 'root'},
                {'group': 'root'},
                {'dataset': v},
                {'formatter': 'yaml'},
                {'require': [
                    {'file': 'filebeat-confd-directory'}
                ]}
            ]
        }

    return config
