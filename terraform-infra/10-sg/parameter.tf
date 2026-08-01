resource "aws_ssm_parameter" "sg_ids" {
  count       = length(var.sg_names)
  name        = "/${var.project}/${var.environment}/${var.sg_names[count.index]}_sg_id"
  description = "The ID of the main VPC"
  type        = "String"
  value       = module.sg[count.index].sg_ids
}
