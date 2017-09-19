#------ helm ----
ARG VERSION=latest
FROM dtzar/helm-kubectl:${VERSION} as helm

#------- Deployer ------
#
FROM alpine:3.6

RUN apk add --no-cache ca-certificates

COPY --from=helm /bin/helm /usr/bin/
COPY --from=helm /usr/local/bin/kubectl /usr/bin/

ADD bin/* /opt/bin/
RUN chmod +x /opt/bin/*

CMD ["/opt/bin/release_chart"]
