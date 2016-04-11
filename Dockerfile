FROM buildpack-deps:jessie-curl

ENV CHRONOGRAF_VERSION 0.11.0
RUN curl -s -o /tmp/chronograf_latest_amd64.deb https://s3.amazonaws.com/get.influxdb.org/chronograf/chronograf_${CHRONOGRAF_VERSION}_amd64.deb && \
    dpkg -i /tmp/chronograf_latest_amd64.deb && \
    rm /tmp/chronograf_latest_amd64.deb && \
    rm -rf /var/lib/apt/lists/*

ENV PATH /opt/chronograf/:$PATH
ENV CHRONOGRAF_BIND 0.0.0.0:10000
ENV CHRONOGRAF_LOCAL_DATABASE /data/chronograf.db
VOLUME ["/data"]

ADD run.sh /run.sh
RUN chmod +x /*.sh
EXPOSE 10000

CMD ["/run.sh"]
