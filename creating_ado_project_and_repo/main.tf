terraform {
  required_providers {
    azuredevops = {
      source = "microsoft/azuredevops"
      version = "0.9.1"
    }
  }
}

provider "azuredevops" {
  org_service_url       = "https://dev.azure.com/multi-stage-deploy"
  personal_access_token = var.pat
}

resource "azuredevops_project" "adoterraform" {
  name               = "ADO_with_tf"
  visibility         = "private"
  version_control    = "Git"
  work_item_template = "Agile"
}

# data "azuredevops_git_repository" "example-single-repo" {
#   project_id = azuredevops_project.adoterraform.id
#   name       = azuredevops_project.adoterraform.name
# }

resource "azuredevops_git_repository" "tfcode" {
  project_id     = azuredevops_project.adoterraform.id
  name           = "TFcode"
  default_branch = "refs/heads/main"
  initialization {
    init_type = "Clean"
  }
  lifecycle {
    ignore_changes = [
      # Ignore changes to initialization to support importing existing repositories
      # Given that a repo now exists, either imported into terraform state or created by terraform,
      # we don't care for the configuration of initialization against the existing resource
      initialization,
    ]
  }
}

resource "azuredevops_git_repository_branch" "new_branch" {
  repository_id = azuredevops_git_repository.tfcode.id
  name          = "nas-brenc"
  ref_branch    = azuredevops_git_repository.tfcode.default_branch
}

resource "azuredevops_git_repository_file" "default_pipeline" {
  repository_id       = azuredevops_git_repository.tfcode.id
  file                = "test.yml"
  content             = file("${path.module}/test.yml")
  branch              = format("refs/heads/%s", azuredevops_git_repository_branch.new_branch.name)
  commit_message      = "Add yml file via terraform"
  overwrite_on_create = true
}


