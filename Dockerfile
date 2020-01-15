FROM debian:buster-slim as builder
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ENV STATSDAEMON_VERSION=0.7.1
ADD https://github.com/bitly/statsdaemon/releases/download/v$STATSDAEMON_VERSION/statsdaemon-$STATSDAEMON_VERSION.linux-amd64.go1.5.1.tar.gz /tmp/statsdaemon.tar.gz
RUN tar -xzf /tmp/statsdaemon.tar.gz -C /usr/local/bin --strip-components 1

FROM gcr.io/distroless/static-debian10@sha256:8fcd06c0c450a2354f1345d02d2713ceeb4e8ada98caf89e1e9f38f2a6788973
COPY --from=builder /usr/local/bin/statsdaemon /statsdaemon
USER nonroot
ENTRYPOINT ["/statsdaemon"]
