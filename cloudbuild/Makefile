PROJECT_ID=$(shell gcloud config list --format 'value(core.project)')

#gcloud builds submit --config=cloudbuild.yaml .
.PHONY: build
build:
ifneq ($(PROJECT_ID),hpc-image-builder-dev-2acb)
$(error PROJECT_ID is not set)
endif
	gcloud builds submit --config=cloudbuild.yaml --project ${PROJECT_ID} . | tee /tmp/$(shell date +%y%m%d%h%s)-packer-build.out

