ElasticSearch + Kibana in single image.

This image is intended for quick analytic tasks - push your data to ES, view it in Kibana.

Typical usage:

- docker run -it --rm --net=host -v /data/es:/data scf37/esk
- Kibana will be available at http://localhost:5601/
- ES HTTP will be available at http://localhost:9200/
