FROM scratch
ADD rootfs.tar.xz /
RUN rm -f /usr/bin/docker && \
    rm -rf /lib/modules /lib/firmware
CMD ["/bin/bash"]
