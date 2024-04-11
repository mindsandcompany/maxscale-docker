FROM registry.access.redhat.com/ubi8/ubi-minimal:8.9-1161

ARG MXS_VERSION

COPY --chmod=500 mariadb_repo_setup /tmp/mariadb_repo_setup
RUN /tmp/mariadb_repo_setup --mariadb-maxscale-version=${MXS_VERSION} --skip-check-installed

# Install MaxScale
RUN microdnf -y install maxscale && microdnf clean all
COPY maxscale.cnf /etc/

# Expose REST API port.
EXPOSE 8989

ENTRYPOINT ["maxscale","--nodaemon", "--user=root", "--log=stdout"]

