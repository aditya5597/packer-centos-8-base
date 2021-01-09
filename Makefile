PROJECTID=$(shell gcloud config list --format 'value(core.project)')

#gcloud builds submit --config=cloudbuild.yaml .
.PHONY: build
build:
ifneq ($(PROJECTID),hpc-image-builder)
$(error PROJECTID is not set)
endif
	gcloud builds submit --config=cloudbuild.yaml --project hpc-image-builder . | tee /tmp/$(shell date +%y%m%d%h%s)-packer-build.out

