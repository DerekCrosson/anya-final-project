module "services" {
  source = "./modules/services"
}

module "self_hosted_ci_runners" {
  source = "./modules/self_hosted_ci_runners"
}
