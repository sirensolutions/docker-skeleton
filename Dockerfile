FROM openjdk:8-jre

# The build identifier
ARG BUILD_ID

# The Siren Investigate zipfile to install
ARG SIREN_ZIPFILE

# Settings configurable as environment variables
ENV ELASTICSEARCH_URL "http://localhost:9220"
ENV SERVER_BASEPATH ""
ENV KIBI_INDEX ".siren"

# Copy required files from outside world into image /tmp
COPY ${SIREN_ZIPFILE} /tmp/
COPY populate-longopts.sh /tmp/
COPY investigate.yml /tmp/

# Unpack Siren Investigate zipfile
RUN    mkdir -p /opt \
    && unzip -q /tmp/${SIREN_ZIPFILE} -d /opt/ \
    && rm /tmp/${SIREN_ZIPFILE} \
    && find /opt/ -depth -type d -name "siren-investigate*" -exec mv '{}' /opt/siren-investigate \; \
    && mv /tmp/populate-longopts.sh /opt/siren-investigate/bin/populate-longopts.sh \
    && mv /tmp/investigate.yml /opt/siren-investigate/config/investigate.yml \
    && addgroup siren && adduser --disabled-password --gecos '' --ingroup siren siren \
    && chown -R siren:siren /opt/siren-investigate/ \
    && chmod +x /opt/siren-investigate/bin/populate-longopts.sh

# Siren Investigate configuration volume
VOLUME ["/opt/siren-investigate/config"]

# Siren Investigate pki volume
VOLUME ["/opt/siren-investigate/pki"]

# Expose Siren Investigate port
EXPOSE 5606

# default command
CMD ["bin/sh", "-c", "opt/siren-investigate/bin/investigate $(/opt/siren-investigate/bin/populate-longopts.sh)"]
