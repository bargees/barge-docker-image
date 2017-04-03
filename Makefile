IMAGE   := ailispaw/barge
VERSION := 2.8.2

image: Dockerfile rootfs.tar.xz
	docker build -t barge:armhf .
	docker create --name barge-armhf barge:armhf
	docker export barge-armhf | docker import \
		-c 'ENTRYPOINT [ "dumb-init" ]' \
		-c 'CMD [ "bash" ]' \
		-m 'https://github.com/bargees/barge-docker-image' \
		- $(IMAGE):docker-armhf
	docker tag $(IMAGE):docker-armhf $(IMAGE):$(VERSION)-docker-armhf
	docker rm barge-armhf

	docker run --name barge-armhf barge:armhf rm -f /usr/bin/docker
	docker export barge-armhf | docker import \
		-c 'ENTRYPOINT [ "dumb-init" ]' \
		-c 'CMD [ "bash" ]' \
		-m 'https://github.com/bargees/barge-docker-image' \
		- $(IMAGE):armhf
	docker tag $(IMAGE):armhf $(IMAGE):$(VERSION)-armhf
	docker rm barge-armhf

rootfs.tar.xz:
	 wget -qO $@ https://github.com/bargees/barge-os/releases/download/$(VERSION)-rpi/$(@F)

release:
	docker push $(IMAGE):armhf
	docker push $(IMAGE):$(VERSION)-armhf
	docker push $(IMAGE):docker-armhf
	docker push $(IMAGE):$(VERSION)-docker-armhf

clean:
	$(RM) -f rootfs.tar.xz
	-docker rmi `docker images -q -f dangling=true`
	-docker rmi barge $(IMAGE):armhf $(IMAGE):$(VERSION)-armhf
	-docker rmi barge $(IMAGE):docker-armhf $(IMAGE):$(VERSION)-docker-armhf

.PHONY: image release clean
