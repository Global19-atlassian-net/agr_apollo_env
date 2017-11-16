# WebApollo
# VERSION 2.0
FROM tomcat:8-jre8
MAINTAINER Nathan Dunn <nathandunn@lbl.gov>
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qq update --fix-missing && \
	apt-get --no-install-recommends -y install \
	git build-essential maven tomcat8 libpq-dev postgresql-common openjdk-8-jdk wget \
	postgresql postgresql-client xmlstarlet netcat libpng-dev zip \
	zlib1g-dev libexpat1-dev ant curl ssl-cert

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get -qq update --fix-missing && \
	apt-get --no-install-recommends -y install nodejs && \
	apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN cp /usr/lib/jvm/java-8-openjdk-amd64/lib/tools.jar /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/ext/tools.jar && \
	useradd -ms /bin/bash -d /apollo apollo

ENV WEBAPOLLO_VERSION 4da53bd29b2bdf7094d7ddf264dd10e6e59eb12b
RUN curl -L https://github.com/GMOD/Apollo/archive/${WEBAPOLLO_VERSION}.tar.gz | tar xzf - --strip-components=1 -C /apollo

ENV JBROWSE_CONFIG_VERSION 8573e57601634890352e3df3cd6c3b4fa0e4672d
RUN mkdir /jbrowse-config
RUN curl -L https://github.com/alliance-genome/jbrowse-config/archive/${JBROWSE_CONFIG_VERSION}.tar.gz | tar xzf - --strip-components=1 -C /jbrowse-config
#RUN mv /jbrowse-config/jbrowse/data /data

COPY build.sh /bin/build.sh
ADD apollo-config.groovy /apollo/apollo-config.groovy


ADD install_groovy.sh /install_groovy.sh
RUN bash "/install_groovy.sh"

RUN chown -R apollo:apollo /apollo
USER apollo
RUN bash /bin/build.sh
USER root

ENV CATALINA_HOME=/usr/local/tomcat/
RUN rm -rf ${CATALINA_HOME}/webapps/* && \
	cp /apollo/apollo*.war ${CATALINA_HOME}/apollo.war


ENV CONTEXT_PATH ROOT

# load the working dump
ENV APOLLO_DB_DUMP "agr_apollo_postgresql3.sql"
RUN wget -q https://s3.amazonaws.com/apollo-data/${APOLLO_DB_DUMP}.gz && \
    gunzip ${APOLLO_DB_DUMP}.gz && \
    mv ${APOLLO_DB_DUMP} /tmp

ADD launch.sh /launch.sh
CMD "/launch.sh"

#ADD add_data.sh /add_data.sh
#CMD "/add_data.sh"

