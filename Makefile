IMAGE   := ailispaw/docker-root
VERSION := 1.2.7

image: Dockerfile docker-root.tar
	docker build -t $(IMAGE) .
	docker tag $(IMAGE):latest $(IMAGE):$(VERSION)

docker-root.tar: docker-root/Dockerfile docker-root/rootfs.tar.xz
	docker build -t docker-root docker-root
	docker run --name docker-root docker-root
	docker export docker-root > $@
	docker rm docker-root

docker-root/rootfs.tar.xz:
	curl -L https://github.com/ailispaw/docker-root/releases/download/v$(VERSION)/rootfs.tar.xz \
		-o $@

release:
	docker push $(IMAGE):latest
	docker push $(IMAGE):$(VERSION)

clean:
	$(RM) -f docker-root/rootfs.tar.xz
	$(RM) -f docker-root.tar
	-docker rmi docker-root $(IMAGE):latest $(IMAGE):$(VERSION)

.PHONY: image release clean
