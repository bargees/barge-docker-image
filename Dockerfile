FROM scratch
ADD rootfs.tar.xz /
RUN rm -rf /lib/modules /lib/firmware
CMD [ "bash" ]
