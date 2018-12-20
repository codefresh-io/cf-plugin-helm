#------ helm ----
ARG HELM_VERSION=latest
FROM dtzar/helm-kubectl:${HELM_VERSION} as helm

#------- Deployer ------
#
FROM alpine:3.7

RUN apk add --no-cache curl ca-certificates bash jq

COPY --from=helm /usr/local/bin/helm /usr/bin/
COPY --from=helm /usr/local/bin/kubectl /usr/bin/

ADD bin/* /opt/bin/
RUN chmod +x /opt/bin/*

CMD ["/opt/bin/release_chart"]
