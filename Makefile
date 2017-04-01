IMAGE   := ailispaw/barge
VERSION := 2.4.3

image: Dockerfile rootfs.tar.xz
	docker build -t barge .
	docker create --name barge barge
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

clean:
	$(RM) -f rootfs.tar.xz
	-docker rmi `docker images -q -f dangling=true`
	-docker rmi barge $(IMAGE):latest $(IMAGE):$(VERSION)

.PHONY: image release clean
