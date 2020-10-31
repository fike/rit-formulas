
PHONY: init plan apply

# export ENV = ${TF_VAR_env}

init:
	terraform workspace select $${ENV}
	terraform init
	# $(MAKE) -C cloudflare init


plan: init
	terraform workspace select $${ENV}
	terraform plan -var-file=variables/$${ENV}.tfvars
	# $(MAKE) -C cloudflare plan

apply: init
	terraform workspace select $${ENV}
	terraform apply -var-file=variables/$${ENV}.tfvars -auto-approve
	# $(MAKE) -C cloudflare apply
	
destroy:
	terraform workspace select $${ENV}
	terraform destroy -var-file=variables/$${ENV}.tfvars -auto-approve
	

refresh:
	terraform workspace select $${ENV}
	terraform refresh -var-file=variables/$${ENV}.tfvars
	

t_bootstrap:
	terraform workspace new dev
	terraform workspace new homolog
	terraform workspace new prod
