## Packer

#### Note: issue 7663
    Packer does not support Google osLogin role.  Until this issue is resolved packer builds have to be run from their own project.

#### Quickstart
  - Clone the repo.
  - Checkout a feature branch and apply updates.
      - Minimally bup the verison number.
  - Push the feature branch to origin and submit a pull request.  When the pull request is processed the new image will be built.
  - Spin up a compute instance from the new image by doing the following,
      gcloud compute instances create <INSTANCE NAME> --image=centos-7-base-full-<BUILD DATE>-<BUILD VERSION> \ 
       --image-project=hpc-image-builder --metadata=osLogin=TRUE --zone=<INSTANCE ZONE> \
       --service-account=<INSTNCE SERVICE ACCOUNT> 
        
#### Overview


####  tl;dr

  - Run a manual build,
    gcloud buils submit .

  - Manual build long form
    gcloud compute instances create <INSTANCE NAME> --image=<IAMGE NAME> --image-project=<IMAGE PROJECT> \
    --metadata=osLogin=TRUE --zone=<INSTANCE ZONE> --service-account=<SERVICE ACCOUNT>
 
  - To update the repo without triggering a build add "skip ci" to the commit message.
