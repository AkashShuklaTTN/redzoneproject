##Network
variable "vpc_cdr" {}

variable "public1_cdr" {}

variable "public2_cdr" {}

variable "private_cdr" {}

#3asg
variable "ami-ins" {}
variable "ins-type" {}
variable "desired-cap" {}
variable "max-count" {}
variable "min-count" {}
variable "min-healthy" {}

##database
variable "db-ami" {}
variable "db-instance" {}
variable "db-privateip" {}

##monitoring
variable "mon-ami" {}
variable "mon-instance" {}
variable "mon-privateip" {}

variable "ip-test" {}
