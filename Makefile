IMAGE   := ailispaw/barge
VERSION := 2.6.0

image: Dockerfile rootfs.tar.xz
	docker build -t barge:arm64v8 .
	docker create --name barge-arm64v8 barge:arm64v8
	docker export barge-arm64v8 | docker import \
		-c 'ENTRYPOINT [ "dumb-init" ]' \
		-c 'CMD [ "bash" ]' \
		-m 'https://github.com/bargees/barge-docker-image' \
		- $(IMAGE):docker-arm64v8
	docker tag $(IMAGE):docker-arm64v8 $(IMAGE):$(VERSION)-docker-arm64v8
	docker rm barge-arm64v8

	docker run --name barge-arm64v8 barge:arm64v8 rm -f /usr/bin/docker
	docker export barge-arm64v8 | docker import \
		-c 'ENTRYPOINT [ "dumb-init" ]' \
		-c 'CMD [ "bash" ]' \
		-m 'https://github.com/bargees/barge-docker-image' \
		- $(IMAGE):arm64v8
	docker tag $(IMAGE):arm64v8 $(IMAGE):$(VERSION)-arm64v8
	docker rm barge-arm64v8

rootfs.tar.xz:
	 wget -qO $@ https://github.com/bargees/barge-os/releases/download/$(VERSION)-rpi-arm64v8/$(@F)

release:
	docker push $(IMAGE):arm64v8
	docker push $(IMAGE):$(VERSION)-arm64v8
	docker push $(IMAGE):docker-arm64v8
	docker push $(IMAGE):$(VERSION)-docker-arm64v8

clean:
	$(RM) -f rootfs.tar.xz
	-docker rmi `docker images -q -f dangling=true`
	-docker rmi barge $(IMAGE):arm64v8 $(IMAGE):$(VERSION)-arm64v8
	-docker rmi barge $(IMAGE):docker-arm64v8 $(IMAGE):$(VERSION)-docker-arm64v8

.PHONY: image release clean
