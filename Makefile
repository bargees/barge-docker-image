IMAGE   := ailispaw/barge
VERSION := 3.0.0-dev2

image: Dockerfile rootfs.tar.xz
	docker build -t barge .
	docker create --name barge barge
	docker export barge | docker import \
		-c 'ENTRYPOINT [ "dumb-init" ]' \
		-c 'CMD [ "bash" ]' \
		-m 'https://github.com/bargees/barge-docker-image' \
		- $(IMAGE):docker
	docker tag $(IMAGE):docker $(IMAGE):$(VERSION)-docker
	docker rm barge

	docker run --name barge barge rm -f /usr/bin/docker \
		/usr/bin/dockerd \
		/usr/bin/containerd \
		/usr/bin/containerd-shim \
		/usr/bin/containerd-shim-runc-v1 \
		/usr/bin/containerd-shim-runc-v2 \
		/usr/bin/ctr \
		/usr/bin/docker-init \
		/usr/bin/docker-proxy \
		/usr/bin/runc
	docker export barge | docker import \
		-c 'ENTRYPOINT [ "dumb-init" ]' \
		-c 'CMD [ "bash" ]' \
		-m 'https://github.com/bargees/barge-docker-image' \
		- $(IMAGE)
	docker tag $(IMAGE):latest $(IMAGE):$(VERSION)
	docker rm barge

rootfs.tar.xz:
	curl -L https://github.com/bargees/barge-os/releases/download/$(VERSION)/$(@F) -o $@

release:
	docker push $(IMAGE):latest
	docker push $(IMAGE):$(VERSION)
	docker push $(IMAGE):docker
	docker push $(IMAGE):$(VERSION)-docker

clean:
	$(RM) -f rootfs.tar.xz
	-docker rmi `docker images -q -f dangling=true`
	-docker rmi barge $(IMAGE):latest $(IMAGE):$(VERSION)
	-docker rmi barge $(IMAGE):docker $(IMAGE):$(VERSION)-docker

.PHONY: image release clean
