FROM registry.access.redhat.com/ubi8/ubi-minimal:8.10-1154

ARG TARGETPLATFORM
ARG MXS_VERSION

RUN --mount=type=secret,id=REPO_TOKEN,env=REPO_TOKEN \
    ARCH=x86_64 && if [ "${TARGETPLATFORM}" = "linux/arm64" ]; then ARCH=aarch64; fi && \
    echo "TARGETPLATFORM: ${TARGETPLATFORM} ARCH: ${ARCH}" && \
    # MaxScale is installed directly via rpm, so dependencies must be installed manually.
    microdnf -y install shadow-utils libmicrohttpd librdkafka jansson libatomic libicu unixODBC libmemcached pam nodejs && \
    # MaxScale 25.01 depends on boost-serialization-1.66, which is not in the standard repository. Install it manually.
    rpm -ivh "https://dl.rockylinux.org/pub/rocky/8/AppStream/${ARCH}/os/Packages/b/boost-serialization-1.66.0-13.el8.${ARCH}.rpm" && \
    # Install MaxScale Enterprise from enterprise repository, using the secret token. The "-1" is the build number, assumed to always be 1. Make configurable if needed.
    rpm -ivh "https://dlm.mariadb.com/repo/$REPO_TOKEN/maxscale-enterprise/${MXS_VERSION}/yum/rhel/8/${ARCH}/maxscale-enterprise-${MXS_VERSION}-1.rhel.8.${ARCH}.rpm" && \
    microdnf clean all

COPY maxscale.cnf /etc/

# Copy licenses. Required for OpenShift container certification.
COPY LICENSE /licenses/

# Expose REST API port.
EXPOSE 8989

# Run as non root. Required for OpenShift container certification.
USER maxscale

ENTRYPOINT ["maxscale","--nodaemon", "--log=stdout"]

