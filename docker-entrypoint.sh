#!/bin/bash

echo "Container is running!!!"

# Authenticate gcloud using service account
#gcloud auth activate-service-account --key-file $GOOGLE_APPLICATION_CREDENTIALS
# Set GCP Project Details
#gcloud config set project $GCP_PROJECT


git config --global user.name "rashmibanthia"
git config --global user.email "rjain29@gmail.com"

#/bin/bash
pipenv shell
