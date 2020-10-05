#binary to build
BIN := myapp


VERSION := $(shell git describe --tags --always --dirty)
OS := $(if $(GOOS),$(GOOS),$(shell go env GOOS))
ARCH := $(if $(GOARCH),$(GOARCH),$(shell go env GOARCH))

BUILD_IMAGE ?= golang:1.13-alpine

build-%:
	@$(MAKE) build                        \
	    --no-print-directory              \
	    GOOS=$(firstword $(subst _, ,$*)) \
	    GOARCH=$(lastword $(subst _, ,$*))


build: bin/$(OS)_$(ARCH)/$(BIN)

# Directories that we need created to build/test.
BUILD_DIRS := bin/$(OS)_$(ARCH)     \
              .go/bin/$(OS)_$(ARCH) \
              .go/cache

# The following structure defeats Go's (intentional) behavior to always touch
# result files, even if they have not changed.  This will still run `go` but
# will not trigger further work if nothing has actually changed.
OUTBIN = bin/$(OS)_$(ARCH)/$(BIN)
$(OUTBIN): .go/$(OUTBIN).stamp
	@true

# This will build the binary under ./.go and update the real binary if needed.
.PHONY: .go/$(OUTBIN).stamp
.go/$(OUTBIN).stamp: $(BUILD_DIRS)
	@echo "making $(OUTBIN)"
	@docker run                                                 \
	    -i                                                      \
	    --rm                                                    \
	    -u $$(id -u):$$(id -g)                                  \
	    -v $$(pwd):/src                                         \
	    -w /src                                                 \
	    -v $$(pwd)/.go/bin/$(OS)_$(ARCH):/go/bin                \
	    -v $$(pwd)/.go/bin/$(OS)_$(ARCH):/go/bin/$(OS)_$(ARCH)  \
	    -v $$(pwd)/.go/cache:/.cache                            \
	    --env HTTP_PROXY=$(HTTP_PROXY)                          \
	    --env HTTPS_PROXY=$(HTTPS_PROXY)                        \
	    $(BUILD_IMAGE)                                          \
	    /bin/sh -c "                                            \
	        ARCH=$(ARCH)                                        \
	        OS=$(OS)                                            \
	        VERSION=$(VERSION)                                  \
	        ./build/build.sh                                    \
	    "
	@if ! cmp -s .go/$(OUTBIN) $(OUTBIN); then \
	    mv .go/$(OUTBIN) $(OUTBIN);            \
	    date >$@;                              \
	fi


# Example: make shell CMD="-c 'date > datefile'"
shell: $(BUILD_DIRS)
	@echo "launching a shell in the containerized build environment"
	@docker run                                                 \
	    -ti                                                     \
	    --rm                                                    \
	    -u $$(id -u):$$(id -g)                                  \
	    -v $$(pwd):/src                                         \
	    -w /src                                                 \
	    -v $$(pwd)/.go/bin/$(OS)_$(ARCH):/go/bin                \
	    -v $$(pwd)/.go/bin/$(OS)_$(ARCH):/go/bin/$(OS)_$(ARCH)  \
	    -v $$(pwd)/.go/cache:/.cache                            \
	    --env HTTP_PROXY=$(HTTP_PROXY)                          \
	    --env HTTPS_PROXY=$(HTTPS_PROXY)                        \
	    $(BUILD_IMAGE)                                          \
	    /bin/sh $(CMD)


version:
	@echo $(VERSION)


$(BUILD_DIRS):
	@mkdir -p $@

clean:
	rm -rf .go bin