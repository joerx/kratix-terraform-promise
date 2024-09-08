

./internal/scripts/worker-resource-builder:
	mkdir -p bin
	curl -sLo ./bin/worker-resource-builder.tar.gz https://github.com/syntasso/kratix/releases/download/v0.0.4/worker-resource-builder_0.0.4_linux_amd64.tar.gz
	tar -xvf ./bin/worker-resource-builder.tar.gz -C ./bin
	mv ./bin/worker-resource-builder-v* ./internal/scripts/worker-resource-builder
	chmod +x ./internal/scripts/worker-resource-builder

.PHONY: inject-deps
inject-deps: ./internal/scripts/worker-resource-builder
	./internal/scripts/inject-deps
