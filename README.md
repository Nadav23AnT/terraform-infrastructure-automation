
# Terraform AWS Cloud Infrastructure Automation

## Description

This **Terraform project** automates the provisioning of a comprehensive AWS cloud infrastructure. The created infrastructure includes setting up VPC, Internet Gateways, Routes, Subnets, and Security Groups. In addition to these networking components, the configuration scripts in this project automatically attach an Elastic IP to the network interface. 

The primary objective of this project is to facilitate the quick and efficient deployment of an Ubuntu server, subsequently setting up Apache2 on it. This end-to-end automation ensures a streamlined and error-free setup, significantly reducing the manual effort involved in configuring each component separately.

## Table of Contents

- [Getting Started](#Quick-Start)
  - [Prerequisites](###prerequisites)
  - [Installation](###installation)
- [Terraform Configuration](#installation)
- [Examples](#examples)

### Prerequisites

List any prerequisites that users need to have in order to use your project. For example:

- **Terraform** (version: 1.5.6)
- **AWS** account with appropriate permissions

## Quick-Start

For a quick start, clone the repository and follow the setup instructions mentioned in the [Installation](###Installation) section of this document. 

---

## Features
- **VPC Setup**: Configuration of a Virtual Private Cloud to facilitate isolated cloud resources.
- **Internet Gateway and Route Tables**: Ensures proper routing of network traffic.
- **Subnet Creation**: Setup of subnets for organizing resources.
- **Security Groups Configuration**: Implementation of security rules for resource access.
- **Elastic IP Attachment**: Automatic attachment of Elastic IP to the network interface.
- **Ubuntu Server Deployment**: Deployment of an Ubuntu server within the configured network.
- **Apache2 Setup**: Installation and configuration of the Apache2 web server on the Ubuntu server.

Whether you are looking to quickly deploy a web server or set up a complex network for your applications on AWS, this Terraform project can be a starting point to automate and streamline the entire process. 


### Installation

Explain how to install your project, including any specific commands or steps. For example:

```bash
# Clone the repository
git clone https://github.com/Nadav23AnT/terraform-infrastructure-automation.git

# Change into the project directory
cd terraform-infrastructure-automation

# Initialize Terraform
terraform init

# Apply the configuration
terraform apply
