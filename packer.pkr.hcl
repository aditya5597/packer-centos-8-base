variable "image_version" {
  type    = string
  default = "40"
}

variable "disable_default_service_account" {
  type    = string
  default = "false"
}

variable "disk_size" {
  type    = string
  default = "20"
}

variable "image_description" {
  type    = string
  default = "packer-image"
}

variable "image_family" {
  type    = string
  default = "nyuhpc-centos-8"
}

variable "image_role" {
  type    = string
  default = "base"
}

variable "machine_type" {
  type    = string
  default = "e2-standard-2"
}

variable "os_name" {
  type    = string
  default = "centos"
}

variable "os_version" {
  type    = string
  default = "8"
}

variable "project_id" {
  type    = string
  default = ""
}

variable "service_account_email" {
  type    = string
  default = ""
}

variable "source_image_family" {
  type    = string
  default = "centos-8"
}

variable "ssh_user" {
  type    = string
  default = "packer"
}

variable "subnetwork" {
  type    = string
  default = ""
}

variable "tags" {
  type    = list(string)
  default = ["packer",]
}

variable "test_image_family" {
  type    = string
  default = "test-nyuhpc-centos-8"
}

variable "zone" {
  type    = string
  default = "us-central1-a"
}
# The "legacy_isotime" function has been provided for backwards compatability, but we recommend switching to the timestamp and formatdate functions.

locals {
  date = "${legacy_isotime("20060102")}"
}

source "googlecompute" "autogenerated_1" {
  account_file                    = "account.json"
  disable_default_service_account = "${var.disable_default_service_account}"
  disk_size                       = "${var.disk_size}"
  image_family                    = "${var.image_family}"
  image_name                      = "${var.os_name}-${var.os_version}-${var.image_role}-${local.date}-v${var.image_version}"
  machine_type                    = "${var.machine_type}"
  project_id                      = "${var.project_id}"
  service_account_email           = "${var.service_account_email}"
  source_image_family             = "${var.os_name}-${var.os_version}"
  ssh_username                    = "${var.ssh_user}"
  state_timeout                   = "8m"
  subnetwork                      = "${var.subnetwork}"
  tags                            = "${var.tags}"
  zone                            = "${var.zone}"
}

build {
  sources = ["source.googlecompute.autogenerated_1"]

  provisioner "shell" {
    inline = ["sudo setenforce 0", "sudo sed -i 's/^SELINUX=enforcing/SELINUX=permissive/g' /etc/selinux/config"]
  }

  provisioner "shell" {
    inline = ["sudo dnf -y install epel-release"]
  }

  provisioner "shell" {
    inline = ["sleep 10", "sudo dnf -y install ansible"]
  }

  provisioner "shell" {
    inline = ["sudo dnf -y config-manager --disable epel"]
  }

  provisioner "file" {
    destination = "/tmp/github_known_hosts"
    source      = "github_known_hosts"
  }

  provisioner "shell" {
    inline = [ "cat /tmp/github_known_hosts >> ~/.ssh/known_hosts" ]
  }

  provisioner "file" {
    destination = "/tmp/id_rsa"
    source      = "id_rsa"
  }

  provisioner "shell" {
    inline = ["cp /tmp/id_rsa ~/.ssh/id_rsa", "chmod 600 ~/.ssh/id_rsa"]
  }

  provisioner "shell-local" {
    command =  "ansible-galaxy install -r ./ansible/requirements.yml -p ./ansible/roles/ -f " 
  }

  provisioner "ansible-local" {
    clean_staging_directory = true
    playbook_dir            = "./ansible"
    playbook_file           = "ansible/playbooks/${var.os_name}-${var.os_version}-${var.image_role}.yml"
    playbook_paths          = ["./ansible/playbooks"]
    role_paths              = ["./ansible/roles", "./ansible/roles/local"]
  }

}
