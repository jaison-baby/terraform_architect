provider "aws" {
    region = var.AWS_REGION
    access_key = var.instance_accesskey
    secret_key = var.instance_secretkey
}

resource "aws_instance" "nginx_server" {
  ami  = var.ami
  instance_type = var.instance_type
  count    = var.ec2_count
  key_name = var.key_name
  tags = var.tags
  subnet_id = module.vpc.subnetid
  vpc_security_group_ids = [module.SG.sgid]
  user_data = <<-EOF
             #!/bin/bash
             sudo yum install httpd -y
             sudo systemctl start httpd.service
             EOF
}

resource "aws_eip" "nginx_eip" {
  vpc        = true


  instance = aws_instance.nginx_server[0].id
  depends_on = [module.vpc.gatewayid]

}


module "vpc" {
 source  = "./modules/vpc"
 availability-zone1 = var.availability-zone1
 availability-zone2 = var.availability-zone2
 }

module "SG" {

source  = "./modules/SG"
a_vpc_id            =  module.vpc.vpcid
sg_ingress_rules = var.sg_ingress_rules
availability-zone1 = var.availability-zone1

}


module "website_s3_bucket" {
  source = "./modules/aws-s3-static-website-bucket"

    bucket_name1 = var.bucket_name1
    tags = var.tags
  cloudfront_origin_arn = module.cloudfront.cloudfront_identity 
}


module "website_s3_bucket1" {
  source = "./modules/aws-s3-media-website-bucket"

    bucket_name = var.bucket_name
    tags = var.tags
  cloudfront_origin_arn = module.cloudfront1.cloudfront_identity
}



module "cloudfront1" {
    source = "./modules/CF-1"
     s3_domain = module.website_s3_bucket.domain
    acm_certificate = module.acm.acm_arn
}


module "cloudfront" {
    source = "./modules/CF"
     s3_domain = module.website_s3_bucket.domain
    acm_certificate = module.acm.acm_arn
}
module "acm" {
    source = "./modules/ACM"
    domain = var.domain
    domain_name = module.cloudfront.domain
    zone_id =  module.cloudfront.hosted_zone

}

module "acm2" {
    source = "./modules/ACM-2"
    domain = var.domain
    alb_dns = module.ELB.elb_dns
    alb_zone_id = module.ELB.elb_zone_id

}



module "ELB" {
    source = "./modules/elb"
    lb_sg  = module.SG.sgid
    lb_subnet = module.vpc.subnetid
    lb_subnet2 = module.vpc.subnetid2
    lb_vpc     = module.vpc.vpcid
    load_balancer_type = var.load_balancer_type
    lb_instance = aws_instance.nginx_server[0].id
    acm_certificate = module.acm2.acm_cert
}

resource "time_sleep" "wait_30_seconds" {
  depends_on = [aws_instance.nginx_server]

  create_duration = "300s"
}
module "AS" {

source  = "./modules/as"

security_groupid = module.SG.sgid

as_subnet1 = module.vpc.subnetid

instance_id2 = aws_instance.nginx_server[0].id

sg1 = module.SG.sgid

key_name = var.key_name

alb1 = module.ELB.elb_arn

wait_30_seconds = time_sleep.wait_30_seconds
}

module "redis" {
   source = "./modules/redis"
   availability-zone1 = var.availability-zone1
   redis_sg          = module.SG.sgid
   sb1      = module.vpc.subnetid
   sb2      = module.vpc.subnetid2
   redis_cluster_id = var.redis_cluster_id
   redis_engine = var.redis_engine
   redis_node_type = var.redis_node_type
   redis_num_cache_nodes = var.redis_num_cache_nodes
   redis_parameter_group_name =var.redis_parameter_group_name
   redis_engine_version = var.redis_engine_version
   redis_port           = var.redis_port
}


module "rds" {

source  = "./modules/rds"
security-groupid     = module.SG.sgid
subnetid             = module.vpc.subnetid
subnetid2            = module.vpc.subnetid2
allocated_storage    = var.allocated_storage
engine               = var.engine
engine_version       = var.engine_version
instance_class       = var.instance_class
name                 = var.name
username             = var.username
password             = var.password
parameter_group_name = var.parameter_group_name
// skip_final_snapshot  = var.skip_final_snapshot
identifier           = var.identifier
}

module "elasticsearch" {
     source = "./modules/es"
     elasticsearch_version = var.elasticsearch_version
     instance_count        = var.instance_count
     volume_size           = var.volume_size
}
