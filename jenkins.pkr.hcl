packer {
  required_plugins {
    docker = {
      version = ">= 0.0.7"
      source  = "github.com/hashicorp/docker"
    }
  }
}



variable "docker_image" {
  type    = string
  default = "jenkins/ssh-agent"
}



source "docker" "jenkins" {
  image  = var.docker_image
  commit = true
}



build {
  name = "jenkins"
  sources = [
    "source.docker.jenkins",
  ]
  provisioner "shell" {
    inline = [
      "pwd",
      "sudo packer init .",
      "sudo packer build jenkins.pkr.hcl",

    ]
  }



  post-processor "docker-tag" {
    repository = "jenkins"
    tags       = ["jenkins_v1.0"]
    only       = ["docker.jenkins"]
  }
}

