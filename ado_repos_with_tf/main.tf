terraform {
  required_version = ">= 0.13"
  required_providers {
    azuredevops = {
      source = "microsoft/azuredevops"
      version = ">=0.1.0"
    }
  }
}

provider "azuredevops" {
  org_service_url       = "https://dev.azure.com/multi-stage-deploy/"
  personal_access_token = var.pat
}

data "azuredevops_project" "example" {
  name = "MilantestProject"
}

# For some reason this is not working and we need separate script in root folder for project creation


# data "local_file" "foo" {
#     filename = "${path.module}/projectname.txt"
# }

# resource "azuredevops_project" "multi-stage-deploy" {
#   name               = data.local_file.foo.content
#   visibility         = "private"
#   version_control    = "Git"
#   work_item_template = "Agile"
# }

resource "azuredevops_git_repository" "infra_with_tf" {
  project_id = data.azuredevops_project.example.id
  name       = "ado_repos_with_tf"
  initialization {
    init_type = "Clean"
  }
}