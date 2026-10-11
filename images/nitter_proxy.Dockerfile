FROM gcr.io/distroless/base-debian12
COPY --chmod=755 ../include/nitter_proxy/build/nitter-proxy /usr/local/bin/nitter-proxy
ENTRYPOINT ["/usr/local/bin/nitter-proxy"]
