variable "stage" {
type = string
}

variable "region" {
type = string 
}



variable  "ami_id" {
type= string
}


variable "instance_type" {
type= string
}

variable  "key_name" {
type = string 
}

variable "config_file_url" {
type = string
default = "https://raw.githubusercontent.com/khatrisourav/Techeazy_4thAssignment/main/configs/dev.json"
}




