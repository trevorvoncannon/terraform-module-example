# Postscript Terraform Stack

<p align="center">
  <img src="https://github.com/trevorvoncannon/postscript/blob/main/images/postscript.jpg?raw=true">
</p>

## What it does

This repo contains terraform modules for building EC2 instances, RDS instances, and VPCs. Each of the aforementioned modules exist in the `modules` directory - with an example usage in the `aws` directory

## Modules

### VPC

This is a fairly straightforward module. It allocates an IP range in IPAM (for subnet tracking purposes) and creates a VPC using a subnet from the first cidr - this can use the entire CIDR block if you choose. 

The module then creates three subnets: 1 public and 2 private with an internet gateway and corresponding route table in the public subnet. :warning: It is important to note that the two private subnets should be in different availability zones to facilitate the upcoming RDS deployment.

### EC2

This module creates any number of EC2 instances you wish to deploy, along with a security group. There is an example of how to create multiple instances in `aws/terraform.tfvars`.

### RDS

Like the EC2 module, this module creates any number of RDS database instances and a security group that allows any resource with the EC2 security group to acces the database.


## Main deployment

In the `aws` directory you will find the main.tf to deploy all three modules. Simply update the terraform.tfvars with your desired variables to custom the deployment
