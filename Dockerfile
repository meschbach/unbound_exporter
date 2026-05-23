FROM alpine:3.21 AS alpine
RUN apk add --no-cache tzdata

FROM scratch
ARG TARGETARCH=amd64
COPY --from=alpine /etc/passwd /etc/passwd
COPY --from=alpine /etc/group /etc/group
COPY --from=alpine /usr/share/zoneinfo /usr/share/zoneinfo
COPY --chmod=755 unbound_exporter-linux-${TARGETARCH} /unbound_exporter
USER nobody
ENTRYPOINT ["/unbound_exporter"]
