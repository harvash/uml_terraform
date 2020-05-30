# Terraform Module

## Overview

This Terraform Module is used to setup DMW Oracle IaaS VM

## Installation of Terraform

https://learn.hashicorp.com/terraform/getting-started/install.html

## Directory Structure

The directory structure of the timocco-terraform repository is as follows:

```bash
├── README.md
└── tf/sandbox
    ├── backend.tf
    ├── provider.tf
    ├── sandbox.tfvars
    ├── sandbox_secrets.tfvars
    ├── shared.tf
    ├── tenant.tf
    ├── main.tf
    ├── tf_sandbox.sh
    ├── var.tf
    └── version.tf
```

## Initialize the live workspace


cd tf/sandbox && terraform init && terraform workspace new sandbox
