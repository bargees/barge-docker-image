FROM scratch
ADD rootfs.tar.xz /
RUN rm -f /usr/bin/docker && \
    rm -rf /lib/modules
CMD [ "bash" ]
