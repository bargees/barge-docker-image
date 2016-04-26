# Barge docker image

A small base image especially for non-static binary which needs GLIBC library

[![](https://badge.imagelayers.io/ailispaw/barge:latest.svg)](https://imagelayers.io/?images=ailispaw/barge:latest 'Get your own badge on imagelayers.io')  
[![](https://img.shields.io/docker/stars/ailispaw/barge.svg?style=flat-square)](https://hub.docker.com/r/ailispaw/barge/)
[![](https://img.shields.io/docker/pulls/ailispaw/barge.svg?style=flat-square)](https://hub.docker.com/r/ailispaw/barge/)

## Example

```Dockerfile
FROM ailispaw/barge
COPY dnsdock /dnsdock
CMD ["/dnsdock"]
```

The original [tonistiigi/dnsdock](https://hub.docker.com/r/tonistiigi/dnsdock/) image (650MB) becomes 26MB.
