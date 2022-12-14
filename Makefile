terraform-init:
	cd terraform && terraform init && cd ..

terraform-plan:
	cd terraform && terraform plan && cd ..

terraform-validate:
	cd terraform && terraform validate && cd ..

terraform-apply:
	cd terraform && terraform apply --auto-approve && cd ..

terraform-destroy:
	cd terraform && terraform destroy --auto-approve && cd ..

ansible-playbook-execute:
	cd ansible && ansible-playbook playbook.yml && cd ..
