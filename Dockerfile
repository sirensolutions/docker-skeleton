FROM openjdk:8-jre

# The build identifier
ARG BUILD_ID

# The Siren Investigate zipfile to install
ARG SIREN_ZIPFILE

# Settings configurable as environment variables
ENV ELASTICSEARCH_URL "http://localhost:9220"
ENV SERVER_BASEPATH ""
ENV KIBI_INDEX ".siren"

# Create siren group and user
RUN addgroup siren && adduser --disabled-password --gecos '' --ingroup siren siren

# Copy siren zipfile into temporary dir
RUN mkdir -p /tmp/investigate
COPY ${SIREN_ZIPFILE} /tmp/investigate/

# Unpack Siren Investigate zipfile
RUN    mkdir -p /opt \
    && unzip -q /tmp/investigate/*.zip -d /opt/ \
    && rm -rf /tmp/investigate \
    && find /opt/ -depth -type d -name "siren-investigate*" -exec mv '{}' /opt/siren-investigate \;

# Siren Investigate configuration volume
VOLUME ["/opt/siren-investigate/config"]

# Siren Investigate pki volume
VOLUME ["/opt/siren-investigate/pki"]

# Expose Siren Investigate port
EXPOSE 5606

# Copy env option parsing script
COPY populate-longopts.sh /opt/siren-investigate/bin/populate-longopts.sh

# Set permissions on option parsing script
RUN chmod +x /opt/siren-investigate/bin/populate-longopts.sh

# Copy standalone image configuration
COPY investigate.yml /opt/siren-investigate/config/investigate.yml

#####
# Add any further COPY commands required here
#####

# Fix permissions
RUN chown -R siren:siren /opt/siren-investigate/

# default command
CMD ["bin/sh", "-c", "opt/siren-investigate/bin/investigate $(/opt/siren-investigate/bin/populate-longopts.sh)"]
