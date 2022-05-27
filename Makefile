nomad-validate:
	./scripts/validate-jobs.sh

init:
	cd terraform && terraform init

init-upgrade:
	cd terraform && terraform init -upgrade

plan:
	cd terraform && terraform plan -var-file=.tfvars -out .plan

apply:
	cd terraform && terraform apply .plan

format:
	cd terraform && terraform fmt -recursive -check
