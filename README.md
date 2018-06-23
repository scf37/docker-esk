ElasticSearch + Kibana in single image.

This image is intended for quick analytic tasks - push your data to ES, view it in Kibana.

Configuration files inside container:
/data/conf/elasticsearch.yml
/data/conf/kibana.yml

Typical usage:

- docker run -it --rm --net=host -v /data/esk:/data scf37/esk
- Kibana will be available at http://localhost:5601/
- ES HTTP will be available at http://localhost:9200/
