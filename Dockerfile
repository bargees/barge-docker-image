FROM scratch
ADD rootfs.tar.xz /
RUN rm -rf /lib/modules
CMD [ "bash" ]
