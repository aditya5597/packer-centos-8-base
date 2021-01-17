PROJECT_ID=$(shell gcloud config list --format 'value(core.project)')
PROJECT_NAME=$(shell gcloud projects describe ${PROJECT_ID} --format='value(name)')

#gcloud builds submit --config=cloudbuild.yaml .
.PHONY: build
build:
ifneq ($(PROJECT_ID),hpc-image-builder-dev-2acb)
$(error PROJECT_ID is not set)
endif
	gcloud builds submit --substitutions _SUBNETWORK="${PROJECT_NAME}-subnet-01" --config=cloudbuild.yaml --project ${PROJECT_ID}  . | tee /tmp/$(shell date +%y%m%d%h%s)-packer-build.out

.PHONY: test
test:
	echo ${PROJECT_ID}
	echo ${PROJECT_NAME}
