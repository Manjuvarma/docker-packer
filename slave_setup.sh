#!/bin/bash
sudo packer init .
sudo packer validate jenkins.pkr.hcl
sudo packer build jenkins.pkr.hcl
