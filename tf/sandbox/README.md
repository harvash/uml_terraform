# Terraform Module

## Overview

This Terraform Module is used to setup DMW Oracle IaaS VM

## Files
README.md: This README

ansible.cfg: ansible configuration file for the playbooks that terraform calls

ansible_playbooks: contains the playbooks

id_rsa: Generated private key (ssh-keygen -t rsa)

id_rsa.place_holder: Empty file to remind you to generate it

id_rsa.pub: Generated public key (ssh-keygen -t rsa)

id_rsa.pub.place_holder: Empty file to remind you to generate it

main.tf:  Your code should go here (used to generate the Azure IaaS VMs)

provider.tf: Resource Definitions for providers

sandbox.tfvars:  Your variables you supply for your terraform runs

sandbox_secrets.tfvars: Secrets you have for Terraform, should not check into GITHUB

sandbox_secrets.tfvars.example: Example of Secret Variables

tennants.tf: Definition of Tennant Components

tf_sandbox.sh: wrapper script for Terraform runs

var.tf: Varialbe Definitions

version.tf: Specify the required version of the Terraform binary

