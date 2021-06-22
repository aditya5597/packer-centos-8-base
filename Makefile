PROJECT_ID=$(shell gcloud config list --format 'value(core.project)')
PROJECT_NAME=$(shell gcloud projects describe ${PROJECT_ID} --format='value(name)')
DATE=$(shell date +%y%m%d%h%s)
LATEST="8-4-2105"

.PHONY: build
build:
	gcloud builds submit --substitutions _SUBNETWORK="${PROJECT_NAME}-subnet-01" --config=cloudbuild-${LATEST}.yaml --project ${PROJECT_ID}  . | tee /tmp/$(shell date +%y%m%d%h%s)-packer-build.out

.PHONY: build-8-4-2105
build-8-4-2105:
	gcloud builds submit --substitutions _SUBNETWORK="${PROJECT_NAME}-subnet-01" --config=cloudbuild-8-4-2105.yaml --project ${PROJECT_ID}  . | tee /tmp/$(shell date +%y%m%d%h%s)-packer-build.out

.PHONY: test
test:
	echo ${PROJECT_ID}
	echo ${PROJECT_NAME}
