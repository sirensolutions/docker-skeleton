#!/bin/bash

# Run Kibi, using environment variables to set longopts defining Kibi's
# configuration.
#
# eg. Setting the environment variable:
#
#       ELASTICSEARCH_STARTUPTIMEOUT=60
#
# will cause Kibi to be invoked with:
#
#       --elasticsearch.startupTimeout=60

kibi_vars=(
    console.enabled
    console.proxyConfig
    console.proxyFilter
    elasticsearch.customHeaders
    elasticsearch.password
    elasticsearch.pingTimeout
    elasticsearch.preserveHost
    elasticsearch.requestHeadersWhitelist
    elasticsearch.requestTimeout
    elasticsearch.shardTimeout
    elasticsearch.ssl.ca
    elasticsearch.ssl.cert
    elasticsearch.ssl.certificate
    elasticsearch.ssl.certificateAuthorities
    elasticsearch.ssl.key
    elasticsearch.ssl.keyPassphrase
    elasticsearch.ssl.verificationMode
    elasticsearch.ssl.verify
    elasticsearch.startupTimeout
    elasticsearch.tribe.customHeaders
    elasticsearch.tribe.password
    elasticsearch.tribe.pingTimeout
    elasticsearch.tribe.requestHeadersWhitelist
    elasticsearch.tribe.requestTimeout
    elasticsearch.tribe.ssl.ca
    elasticsearch.tribe.ssl.cert
    elasticsearch.tribe.ssl.certificate
    elasticsearch.tribe.ssl.certificateAuthorities
    elasticsearch.tribe.ssl.key
    elasticsearch.tribe.ssl.keyPassphrase
    elasticsearch.tribe.ssl.verificationMode
    elasticsearch.tribe.ssl.verify
    elasticsearch.tribe.url
    elasticsearch.tribe.username
    elasticsearch.url
    elasticsearch.username
    kibana.defaultAppId
    kibana.index
    logging.dest
    logging.quiet
    logging.silent
    logging.verbose
    ops.interval
    pid.file
    regionmap
    server.basePath
    server.defaultRoute
    server.host
    server.maxPayloadBytes
    server.name
    server.port
    server.ssl.cert
    server.ssl.certificate
    server.ssl.certificateAuthorities
    server.ssl.cipherSuites
    server.ssl.clientAuthentication
    server.customResponseHeaders
    server.ssl.enabled
    server.ssl.key
    server.ssl.keyPassphrase
    server.ssl.redirectHttpFromPort
    server.ssl.supportedProtocols
    status.allowAnonymous
    status.v6ApiFormat
    tilemap.options.attribution
    tilemap.options.maxZoom
    tilemap.options.minZoom
    tilemap.options.subdomains
    tilemap.url
    xpack.graph.enabled
    xpack.ml.enabled
    xpack.monitoring.elasticsearch.password
    xpack.monitoring.elasticsearch.url
    xpack.monitoring.elasticsearch.username
    xpack.monitoring.enabled
    xpack.monitoring.investigate.collection.enabled
    xpack.monitoring.investigate.collection.interval
    xpack.monitoring.max_bucket_size
    xpack.monitoring.min_interval_seconds
    xpack.monitoring.node_resolver
    xpack.monitoring.report_stats
    xpack.monitoring.ui.container.elasticsearch.enabled
    xpack.monitoring.ui.enabled
    xpack.reporting.capture.concurrency
    xpack.reporting.capture.loadDelay
    xpack.reporting.capture.settleTime
    xpack.reporting.capture.timeout
    xpack.reporting.enabled
    xpack.reporting.encryptionKey
    xpack.reporting.investigateApp
    xpack.reporting.investigateServer.hostname
    xpack.reporting.investigateServer.port
    xpack.reporting.investigateServer.protocol
    xpack.reporting.queue.indexInterval
    xpack.reporting.queue.pollInterval
    xpack.reporting.queue.timeout
    xpack.searchprofiler.enabled
    xpack.security.cookieName
    xpack.security.enabled
    xpack.security.encryptionKey
    xpack.security.secureCookies
    xpack.security.sessionTimeout
)

longopts=''
for kibi_var in ${kibi_vars[*]}; do
    # 'elasticsearch.url' -> 'ELASTICSEARCH_URL'
    env_var=$(echo ${kibi_var^^} | tr . _)

    # Indirectly lookup env var values via the name of the var.
    # REF: http://tldp.org/LDP/abs/html/bashver2.html#EX78
    value=${!env_var}
    if [[ -n $value ]]; then
      longopt="--${kibi_var}=${value}"
      longopts+=" ${longopt}"
    fi
done

echo ${longopts}
