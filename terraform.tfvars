sg_ingress_rules = {
  "rds" = {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP"
  },
  "http" = {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP"
  },
  "ssh" = {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH"
},
"https" = {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP"
  }
}



# RDs 

  allocated_storage    = "20"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  name                 = "TerraformMySQL"
  username             = "mysqladmin"
  password             = "mysql_123"
  parameter_group_name = "default.mysql5.7"
  identifier           = "sayone-rds"
 # skip_final_snapshot  = true
 #publicly_accessible  = true

#s3
 bucket_name = "teraformstatic123"
 bucket_name1 = "terraformmedia678"

#acm
 domain = "terraformcloudfront.tk"


 #Redis
    redis_cluster_id           = "cluster-redis"
    redis_engine               = "redis"
    redis_node_type            = "cache.t2.micro"
    redis_num_cache_nodes      =  1
    redis_parameter_group_name = "default.redis6.x"
    redis_engine_version       = "6.x"
    redis_port                 = "6379"


#elastic_search
    elasticsearch_version = "7.8"
    instance_count        = 1
    volume_size           = 10
 
#loadbalancer
  
    load_balancer_type = "application"
    instance_accesskey = "" 
    instance_secretkey = ""
    ami               = "ami-008e1e7f1fcbe9b80" 
    key_name          = "test"

    instance_type     = "t2.micro"
    AWS_REGION        =   "us-east-2"
    availability-zone1 = "us-east-2a"
    availability-zone2 = "us-east-2b"
