packer {
  required_plugins {
    # COMPLETE ME
    # add necessary plugins for ansible and aws
    aws = {
      source  = "github.com/hashicorp/amazon"
      version = ">= 1.3"
    }
    ansible = {
      source  = "github.com/hashicorp/ansible"
      version = ">= 1.1.2"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  # COMPLETE ME
  # add configuration to use Ubuntu 24.04 image as source image
  ami_name      = "lab8"
  instance_type = "t3.micro"
  region        = "us-west-2"
  vpc_id        = "vpc-0fde6cda7dcaf4b81"
  subnet_id     = "subnet-0a0ddf0276a849bdf"
  associate_public_ip_address = true

  source_ami_filter {
    filters = {
		  // COMPLETE ME complete the "name" argument below to use Ubuntu 24.04
      name = "ubuntu-*-24.04*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
      architecture       = "x86_64"
    }
    most_recent = true
    owners      = ["099720109477"] 
	}
  # ssh_username = "ubuntu"
  ssh_username = var.ssh_username
}

build {
  # COMPLETE ME
  # add configuration to: 
  # - use the source image specified above
  # - use the "ansible" provisioner to run the playbook in the ansible directory
  # - use the ssh user-name specified in the "variables.pkr.hcl" file
  sources = ["source.amazon-ebs.ubuntu"]

  provisioner "shell" {
    inline = [
      "sudo apt update -y",
      "sudo apt install -y ansible"
    ]
  }

  provisioner "ansible" {
    playbook_file = "../ansible/playbook.yml"
    extra_arguments = ["--extra-vars", "ANSIBLE_HOST_KEY_CHECKING=False", "--extra-vars", "ANSIBLE_NOCOWS=1", "-vvv"]
    # ansible_env_vars = ["ANSIBLE_HOST_KEY_CHECKING=False", "ANSIBLE_NOCOWS=1"]
	  # extra_arguments  = ["--extra-vars", "-vvv"]

    user = var.ssh_username
  }
}
