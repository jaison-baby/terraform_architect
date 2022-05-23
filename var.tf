variable "AWS_REGION" {
   description = "Default region."
}

variable "availability-zone1" {
  description = "availiablilty zone1"
}

variable "availability-zone2" {
  description = "availabilty zone2"
}
variable "instance_accesskey" {
  description = "Value of the Name tag for the EC2 instance"
}
variable "instance_secretkey" {
  description = "Value of the Name tag for the EC2 instance"
}
variable "sg_ingress_rules" {
  description = "Ingress security group rules"
  type        = map
}

variable "allocated_storage" {
  description ="allocated storage space for rds"
}
variable "engine" {
     description = "rds engine specification"
}
variable "engine_version" {
   description = " rds engine version specification"
}
variable "instance_class" {
   description = " rds engine instance_class specification"
}
variable "name" {
    description = "rds name specification"
}
variable "username" {
    description = "rds db username specification"
}
variable "password" {
    description = "rds db instance password specification"
}
variable "parameter_group_name" {
    description = "rds db engine parameter_group_name specification"
}

variable "identifier" {
    description = "rds db engine identifier name"
}

//variable "skip_final_snapshot" {
//    description = "rds db engine snapshot"
//}


//S3variables

variable "bucket_name" {
  description = "Name of the static s3 bucket"
}

variable "bucket_name1" {
  description = "Name of the media s3 bucket"
}

variable "tags" {
  description = "Tags to set on the bucket."
  type        = map(string)
  default     = {
                   Terraform   = "true"
                    Environment = "dev"
  }
}

#cloudfront


#acm

variable "domain" {
  description = "Domain name to issue certificate."
}

#loadbalancer


#variable "lb_instance" {
# description = "LB instance"
#}

variable "load_balancer_type" {
    description = "specify load-balancer type"
}



variable "ami" {
  description = "AMI of LB."
}

variable "instance_type" {
  description = "LB instance type"
}

variable "ec2_count" {
  type = number
  default = "1"
}

variable "key_name" {
description = "instance key"
}

variable "tagelb" {
description = "terraform instance tag name"
type = map(string)
default     = {
                    Terraform   = "ELB"
                    Environment = "TEST"
  }
}

#elastic search




variable "elasticsearch_version" {
    description = "define elasticsearch version"
}
variable "instance_count" {
    description = "define instance count"
}
variable "volume_size" {
    description = "define volume_size"
}


#redis


variable "redis_cluster_id" {
      description = "redis cluster id"
}
variable "redis_engine" {
      description = "redis_engine"
}
variable "redis_node_type" {
      description = "redis_nodetype"
}
variable "redis_num_cache_nodes" {
      description = "redis_num_cache_nodes"
}
variable "redis_parameter_group_name" {
      description = "redis_parameter_group_name"
}
variable "redis_engine_version" {
      description = "redis_engine_version"
}
variable "redis_port" {
      description = "redis_port"
}


