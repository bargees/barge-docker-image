FROM scratch
ADD docker-root.tar /
ENTRYPOINT ["/usr/bin/dumb-init"]
CMD ["-c", "/bin/bash"]
