output "sg_ids" {
  description = "The list of ID's of the SG from module"
  value       = module.sg[*].sg_ids
}
