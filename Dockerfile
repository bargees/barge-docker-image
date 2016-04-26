FROM scratch
ADD barge.tar /
ENTRYPOINT ["/usr/bin/dumb-init"]
CMD ["-c", "/bin/bash"]
