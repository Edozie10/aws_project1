# terraform_glossary
# https://registry.terraform.io/ 
# put everything you learn and how you get things set up


 <!-- # Core component to create the virtual network in your AWS account.    SRC= amazoneQ-->

# to set up a Vpc module first we start by identifying the component of the vpc
# this compnent varies from organization to organization however there are basic component that every vpc should have which is what i will be using  in my setup. 

<!-- 
1. VPC  
   - Core component to create the virtual network in your AWS account.

2. Subnets  
   - Public Subnets: Subnets with internet access for resources like web servers.
   - Private Subnets: Subnets without direct internet access for internal resources.

3. Internet Gateway
   - Provides internet access to resources in public subnets.

4. NAT Gateway (optional)  
   - Enables private subnets to access the internet (e.g., for software updates) without exposing them directly.

5. Elastic IP (optional, if using NAT Gateway)  
   - Provides a static public IP for the NAT Gateway.

6. Route Tables  
   - Public Route Table: Routes for public subnets (typically pointing to the internet gateway).
   - Private Route Table: Routes for private subnets (typically pointing to the NAT Gateway).

7. VPC Peering (optional)  
   - Connects multiple VPCs to allow inter-VPC communication.

8. Security Groups 
   - Defines inbound and outbound traffic rules for instances and resources in your VPC.

9. Network ACLs (optional)  
   - Controls inbound and outbound traffic at the subnet level, offering additional security.

10. PC Flow Logs (optional)  
   - Logs network traffic within the VPC for monitoring, troubleshooting, or security analysis.

These are the primary resources that could be part of your VPC Terraform module, depending on your specific requirements. -->



<!-- # Local .terraform directories
**/.terraform/*

# .tfstate files
*.tfstate
*.tfstate.*

# Crash log files
crash.log
crash.*.log

# Exclude all .tfvars files, which are likely to contain sensitive data, such as
# password, private keys, and other secrets. These should not be part of version 
# control as they are data points which are potentially sensitive and subject 
# to change depending on the environment.
*.tfvars
*.tfvars.json

# Ignore override files as they are usually used to override resources locally and so
# are not checked in
override.tf
override.tf.json
*_override.tf
*_override.tf.json

# Ignore transient lock info files created by terraform apply
.terraform.tfstate.lock.info

# Include override files you do wish to add to version control using negated pattern
# !example_override.tf

# Include tfplan files to ignore the plan output of command: terraform plan -out=tfplan
# example: *tfplan*

# Ignore CLI configuration files
.terraformrc
terraform.rc -->





