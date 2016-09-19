FROM scratch
ADD barge.tar /
ENTRYPOINT [ "dumb-init" ]
CMD [ "bash" ]
