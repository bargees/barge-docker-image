# DockerRoot docker image

A small base image especially for non-static binary which needs GLIBC library

[![](https://badge.imagelayers.io/ailispaw/docker-root:latest.svg)](https://imagelayers.io/?images=ailispaw/docker-root:latest 'Get your own badge on imagelayers.io')  
[![](https://img.shields.io/docker/stars/ailispaw/docker-root.svg?style=flat-square)](https://hub.docker.com/r/ailispaw/docker-root/)
[![](https://img.shields.io/docker/pulls/ailispaw/docker-root.svg?style=flat-square)](https://hub.docker.com/r/ailispaw/docker-root/)

## Example

```Dockerfile
FROM ailispaw/docker-root
COPY dnsdock /dnsdock
CMD ["/dnsdock"]
```

The original [tonistiigi/dnsdock](https://hub.docker.com/r/tonistiigi/dnsdock/) image (650MB) becomes 26MB.
