#!/bin/bash

mkdir -p /data/conf

cp -n /elasticsearch/config/elasticsearch.yml /data/conf/elasticsearch.yml
cp /data/conf/elasticsearch.yml  /elasticsearch/config/elasticsearch.yml

cp -n /kibana/config/kibana.yml /data/conf/kibana.yml
cp /data/conf/kibana.yml /kibana/config/kibana.yml

chown -R elasticsearch /data

su elasticsearch /elasticsearch/bin/elasticsearch &

/kibana/bin/kibana
