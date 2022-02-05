nomad-validate:
	./scripts/validate-jobs.sh

plan:
	cd terraform && terraform plan -var-file=.tfvars -out .plan

apply:
	cd terraform && terraform apply .plan
