SHELL := /bin/bash

MAJOR_GOVERSION := $(shell go version | grep -o '1\.[8]' || true)

.PHONY: help
help:
	@ echo "### Terraform Provider Override Module:"
	@ echo
	@ echo "- all: check-deps build-and-install-provider"
	@ echo
	@ echo 

all: check-deps build-and-install-provider

.PHONY: check-deps
check-deps:

ifndef GOPATH
	$(error GOPATH is undefined)
endif

ifneq ($(MAJOR_GOVERSION),1.8)
	$(error MAJOR_GOVERSION not equal to 1.8)
endif
	@ echo "Dependencies are met"
		
.PHONY: build-and-install-provider
build-and-install-provider:
	git clone https://github.com/plinde/terraform-provider-statuscake.git $(GOPATH)/src/github.com/terraform-providers/terraform-provider-statuscake || true
	cd $(GOPATH)/src/github.com/terraform-providers/terraform-provider-statuscake && git checkout plinde-enhancements && go install && echo "built terraform-provider-statuscake from $(GOPATH)/src/github.com/terraform-providers/terraform-provider-statuscake/terraform-provider-statuscake and placed in $(GOPATH)/bin/terraform-provider-statuscake"
	ls -l $(GOPATH)/bin/terraform-provider-statuscake
	
