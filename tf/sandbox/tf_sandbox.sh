#!/bin/bash

OPERATION=${1:-plan}

terraform fmt && \
terraform init && \
terraform workspace select sandbox && \
terraform $OPERATION -var-file sandbox.tfvars -var-file sandbox_secrets.tfvars
