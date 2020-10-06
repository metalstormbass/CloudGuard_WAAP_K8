# CloudGuard_WAAP_K8
Written by Michael Braun

<p align="left">
    <img src="https://img.shields.io/badge/Version-1.0.0-green" />
</p>    

This document outlines how to deploy the [OWASP Juice Shop](https://github.com/bkimminich/juice-shop) and Cloudguard WAAP to Azure Kubernetes Service (AKS). Furthermore, this deployment is done with Github Actions and illustrates how to incorperate Cloudguard Shiftleft into a CI/CD pipeline.

From a high level, this is what happens:

Github Actions: <br>
    1. Prepares environment <br>
    2. Creates configuration files to connect to Terraform Cloud <br>
    3. Performs Shiftleft IAC scan <br>
    4. Performs Shiftleft Container Scan <br>
    5. Installs Terraform & Runs Terraform init, plan and apply. <br>
    6. Terraform: <br>
        a. Creates an AKS cluster. <br>
        b. Uses Helm to install WAAP Pod <br>
        c. Outputs URL <br>

## Prerequisites

[Github Account](https://github.com) <br>
[Azure Account](https://portal.azure.com) <br>
[Terraform Cloud Account](https://terraform.io) <br>
[Check Point Cloud Portal](https://portal.checkpoint.com) - Need WAAP Token <br>

## Setup 

Fork the [VulnerableAzure](https://github.com/metalstormbass/VulnerableAzure) repository into your personal Github account. 
<br>

### Microsoft Azure
 Create an App Registration in Azure. As this will be used multiple times, please note the following:

- Application (client) ID <br>
- Directory (tenant) ID <br>
- Secret <br>
- Subscription ID <br>

Ensure that you give this app registration "Contributor" permission. This is required for Terraform to build the environment.

### Terraform
Terraform Cloud is being used to host the variables and the state file. The actual run occurs in Github Actions.

Create a new workspace in your Orginization and select CLI-driven run. The configure your variables.

![](images/terraform1.png)

Start with the Environment Variables. Input the Azure App Registration information you noted earlier. Use the following keys.

![](/images/terraform2.PNG)

Then fill in the variables required to run the Terraform playbook. Reuse the Azure App Registration client id and secret for the client_id. <b>Note: You cannot have spaces or special characters. This is an Azure limitation</b>

![](/images/terraform3.PNG)

Under the user settings, select Tokens and create an API token. Note the value for later. 
![](/images/terraform4.PNG)

Finally, in the workspace you created, click on Settings > General Settings and note the Workspace ID. We need to this to setup the API call to Terraform.io
