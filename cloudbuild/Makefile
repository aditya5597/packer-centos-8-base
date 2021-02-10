PROJECT_ID=$(shell gcloud config list --format 'value(core.project)')
PROJECT_NAME=$(shell gcloud projects describe ${PROJECT_ID} --format='value(name)')
DATE=$(shell date +%y%m%d%h%s)

.PHONY: build
build:
	gcloud builds submit --config=cloudbuild.yaml --project ${PROJECT_ID} . | tee /tmp/${DATE}-packer-build.out

.PHONY: test
test:
	echo ${PROJECT_ID}
	echo ${PROJECT_NAME}
