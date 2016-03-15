# Pull base image.
FROM scf37/java:latest

#########################
##               ES
########################

ENV ES_PKG_NAME elasticsearch-2.1.1

# https://github.com/lmenezes/elasticsearch-kopf
ENV KOPF_PLUGIN_VERSION master

# Install Elasticsearch.
RUN \
  cd / && \
  apt-get install wget && \
  wget https://download.elasticsearch.org/elasticsearch/elasticsearch/$ES_PKG_NAME.tar.gz && \
  tar xvzf $ES_PKG_NAME.tar.gz && \
  rm -f $ES_PKG_NAME.tar.gz && \
  mv /$ES_PKG_NAME /elasticsearch

# Install custom ES plugins
RUN cd /elasticsearch \
    && bin/plugin install lmenezes/elasticsearch-kopf/$KOPF_PLUGIN_VERSION \
    && bin/plugin install royrusso/elasticsearch-HQ \
    && bin/plugin install mobz/elasticsearch-head

# Define mountable directories.
VOLUME ["/data"]



##############################################
##             Kibana
##############################################

ENV KIBANA_VERSION 4.3.1
ENV OS linux-x64

# Install Kibana
RUN \
  cd /tmp && \
  apt-get install wget && \
  wget https://download.elastic.co/kibana/kibana/kibana-$KIBANA_VERSION-$OS.tar.gz -O kibana-$KIBANA_VERSION.tar.gz && \
  tar xvzf kibana-$KIBANA_VERSION.tar.gz && \
  rm -f kibana-$KIBANA_VERSION.tar.gz && \
  mv /tmp/kibana-$KIBANA_VERSION-$OS /kibana

# Mount kibana.yml config
ADD config/kibana/kibana.yml /kibana/config/kibana.yml

# Define working directory.
WORKDIR /data

# Mount elasticsearch.yml config
ADD config/es/elasticsearch.yml /elasticsearch/config/elasticsearch.yml
ADD start.sh /start.sh

RUN useradd elasticsearch && chown -R elasticsearch /elasticsearch

RUN echo "Done. Open  http://localhost:9200/_plugin/kopf to open ES cluster admin page. Other installed plugins: hq, head"

# Define default command.
CMD ["/start.sh"]

# Expose ports
# 9200: HTTP
# 9300: transport
# 54328: Multicast port
EXPOSE 9200
EXPOSE 9300
EXPOSE 54328

#Kibana
EXPOSE 5601



