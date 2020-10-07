terraform {
      backend "remote" {
         # The name of your Terraform Cloud organization.
         organization = "REPLACE.ORGANIZATION"

         # The name of the Terraform Cloud workspace to store Terraform state files in.
         workspaces {
           name = "REPLACE.WORKSPACE"
         }
       }
     }
