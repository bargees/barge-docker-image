IMAGE   := ailispaw/barge
VERSION := 2.2.4
PATCH   := .1

image: Dockerfile barge.tar
	docker build -t $(IMAGE):armhf .
	-docker rmi $(IMAGE):$(VERSION)-armhf
	docker tag $(IMAGE):armhf $(IMAGE):$(VERSION)-armhf

barge.tar: barge/Dockerfile barge/rootfs.tar.xz
	docker build -t barge barge
	docker create --name barge barge
	docker export barge > $@
	docker rm barge

barge/rootfs.tar.xz:
	wget -qO $@ https://github.com/bargees/barge-os/releases/download/$(VERSION)-rpi$(PATCH)/$(@F)

release:
	docker push $(IMAGE):armhf
	docker push $(IMAGE):$(VERSION)-armhf

clean:
	$(RM) -f barge/rootfs.tar.xz
	$(RM) -f barge.tar
	-docker rmi barge $(IMAGE):armhf $(IMAGE):$(VERSION)-armhf

.PHONY: image release clean
