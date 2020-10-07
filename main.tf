terraform {
      backend "remote" {
         # The name of your Terraform Cloud organization.
         organization = "ENTER_ORGANIZATION_HERE"

         # The name of the Terraform Cloud workspace to store Terraform state files in.
         workspaces {
           name = "ENTER_WORKSPACE_HERE"
         }
       }
     }
