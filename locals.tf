locals {
  common_tags = { 
     projectname = var.project_name
     environment = var.environment
     terraform = "true"
  }
  common_name_suffix = "${var.project_name}-${var.environment}" # roboshop-dev
  az_names = slice(data.aws_availability_zones.available.names, 0, 2) # get first two AZs
}
