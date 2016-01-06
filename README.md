# DockerRoot docker image

A small base image especially for non-static binary which needs GLIBC library

## Example

```Dockerfile
FROM ailispaw/docker-root
COPY dnsdock /dnsdock
CMD ["/dnsdock"]
```

The original [tonistiigi/dnsdock](https://hub.docker.com/r/tonistiigi/dnsdock/) image (633MB) becomes 30MB.
