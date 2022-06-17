1. This architect designed in standalone VPC and Security Group


2. Here two s3 bucket using for serving media and static files and its corresponding module is below

   1. aws-s3-media-website-bucket --> for media
   2. aws-s3-static-website-bucket --> for static


This two s3 bucket uses a custom domain name using cloud front and its name and modules are below
   
   1. static.terraformcloudfront.tk  --> static s3 bucket
   2. media.terraformcloudfront.tk   --> media s3 bucket

coresponding mentioned above cloud front using module is 'ACM' and This certificate has been issued in 'us-east-1'.

3. The 'terraform.tfvars' file using the security group 'inbond rules' and assigned variables for each application for redis,load balancer,elastic search,acm,s3 bucket and RDS.
 
 
3.  Load balancer using the domain name as 'lb.terraformcloudfront.tk' and its module is 'elb' and ceritfcate has been issued using module 'ACM-2'.

load balancer target group attached to Autoscaling and alarm set in cloudwatch for scale up and scale down policies.

4. Below is the mentoned modules for services

  1. Auto scaling --> as
  2. Virtual Private Cloud --> vpc
  3. Security Group --> SG
  4. Elastic Search --> es
  5. redis          --> redis
  6. Relation Databse services --> rds
