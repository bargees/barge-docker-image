IMAGE   := ailispaw/barge
VERSION := 2.4.0

image: Dockerfile barge.tar
	docker build -t $(IMAGE) .
	-docker rmi $(IMAGE):$(VERSION)
	docker tag $(IMAGE):latest $(IMAGE):$(VERSION)

barge.tar: barge/Dockerfile barge/rootfs.tar.xz
	docker build -t barge barge
	docker create --name barge barge
	docker export barge > $@
	docker rm barge

barge/rootfs.tar.xz:
	curl -L https://github.com/bargees/barge-os/releases/download/$(VERSION)/$(@F) -o $@

release:
	docker push $(IMAGE):latest
	docker push $(IMAGE):$(VERSION)

clean:
	$(RM) -f barge/rootfs.tar.xz
	$(RM) -f barge.tar
	-docker rmi barge $(IMAGE):latest $(IMAGE):$(VERSION)

.PHONY: image release clean
