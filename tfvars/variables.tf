variable "instances" {
  type = map(any)
}
variable "zone_id" {
  default = "Z10447913ID88SGRCG6FY"
  type    = string
}
variable "domain_name" {
  default = "jagadeesh.online"
  type    = string
}
variable "common_tags" {
  type = map(any)
  default = {
    Project   = "expense"
    Terraform = true
  }
}
variable "tags" {
  type = map(any)
}