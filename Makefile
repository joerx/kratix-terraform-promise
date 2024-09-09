IMAGE_TAG ?= $(shell git rev-parse --short HEAD)
IMAGE_NAME = ghcr.io/joerx/kratix-terraform-promise:$(IMAGE_TAG)
CWD = $(shell pwd)

.PHONY: build
build:
	PIPELINE_NAME=$(IMAGE_NAME) ./internal/scripts/pipeline-image build

./internal/scripts/worker-resource-builder:
	mkdir -p bin
	curl -sLo ./bin/worker-resource-builder.tar.gz https://github.com/syntasso/kratix/releases/download/v0.0.4/worker-resource-builder_0.0.4_linux_amd64.tar.gz
	tar -xvf ./bin/worker-resource-builder.tar.gz -C ./bin
	mv ./bin/worker-resource-builder-v* ./internal/scripts/worker-resource-builder
	chmod +x ./internal/scripts/worker-resource-builder

.PHONY: inject-deps
inject-deps: ./internal/scripts/worker-resource-builder
	./internal/scripts/inject-deps

.PHONY: test
test: build
	chmod 777 ./internal/configure-pipeline/test-output
	docker run \
		-v $(CWD)/internal/configure-pipeline/test-input:/kratix/input \
		-v $(CWD)/internal/configure-pipeline/test-output:/kratix/output $(IMAGE_NAME)
	cat ./internal/configure-pipeline/test-output/*

.PHONY: test
push: build
	docker push $(IMAGE_NAME)
