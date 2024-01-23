# # This created the CNAME Record for Components
# resource "aws_route53_record" "record" {
#   zone_id = var.LB_TYPE  == "internal" ?  data.terraform_remote_state.vpc.outputs.PRIVATE_HOSTED_ZONE_ID : data.terraform_remote_state.vpc.outputs.PUBLIC_HOSTED_ZONE_ID
#   name    = var.LB_TYPE  == "internal" ? "${var.COMPONENT}-${var.ENV}.${data.terraform_remote_state.vpc.outputs.PRIVATE_HOSTED_ZONE_NAME}" : "${var.COMPONENT}-${var.ENV}.${data.terraform_remote_state.vpc.outputs.PUBLIC_HOSTED_ZONE_NAME}"
#   type    = "CNAME"
#   ttl     = 10
#   records = var.LB_TYPE  == "internal" ? [data.terraform_remote_state.alb.outputs.PRIVATE_ALB_ADDRESS] : [data.terraform_remote_state.alb.outputs.PUBLIC_ALB_ADDRESS]
# }

# This created the CNAME Record for Components
resource "aws_route53_record" "record" {
  zone_id = var.LB_TYPE  == "internal" ?  data.terraform_remote_state.vpc.outputs.PRIVATE_HOSTED_ZONE_ID : data.terraform_remote_state.vpc.outputs.PUBLIC_HOSTED_ZONE_ID
  name    = "${var.COMPONENT}-${var.ENV}"
  type    = "CNAME"
  ttl     = 10
  records = var.LB_TYPE  == "internal" ? [data.terraform_remote_state.alb.outputs.PRIVATE_ALB_ADDRESS] : [data.terraform_remote_state.alb.outputs.PUBLIC_ALB_ADDRESS]
}