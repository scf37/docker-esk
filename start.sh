#!/bin/bash

chown -R elasticsearch /data

su elasticsearch /elasticsearch/bin/elasticsearch &

/kibana/bin/kibana
