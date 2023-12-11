#----------------------
# Terraform Environment
#----------------------
AZENV=dev
TERRAFORM=/usr/local/bin/terraform
TEAM=estruturante
COST=/usr/local/bin/infracost
subdev=c8287b60-d0a7-47d2-8b18-775a2c0a8356
subqas=5f9f8ebf-773c-4d0d-87a9-f7b20e42dba3 
subprd=699393db-d8e2-4e81-a315-1162123ca4c7

#----------------------
# Terraform 
#----------------------

all: prepare-documentation troca-subscription  create-workspaces tf-setup  validate-code   

validate-code: tf-validate tf-format 
 
create-environent: tf-setup  tf-apply 

auto-create-environent: tf-apply-auto

destroy-environment: tf-setup tf-plan-destroy

auto-destroy-environment:  tf-plan-destroy-auto

prepare-documentation:  prepare-docs

troca-subscription: tf-subscription-${AZENV}

IdontHaveBucks: tf-pay


#----------------------
# Terraform Steps
#----------------------

tf-checkov:
	@checkov --download-external-module true  -d .

 
databricks-renew-token: 
	@bash ./tfvalida-adbw.sh ${AZENV} ${TEAM}


create-workspaces:
	@terraform workspace new ${AZENV}  &> /dev/null 
	@terraform workspace select ${AZENV} &> /dev/null 
	@terraform workspace list 

tf-subscription-dev: 
	@echo ........................................................................................................
	@echo "🖥 Subscription ${AZENV} - ${subdev} "
	@echo ........................................................................................................
	@az account set --subscription=${subdev}
	@echo ">> Done 🏁"

tf-subscription-qas: 
	@echo ........................................................................................................
	@echo "🖥 Subscription ${AZENV} - ${subqas} "
	@echo ........................................................................................................
	@az account set --subscription=${subqas}
	@echo ">> Done 🏁"

tf-subscription-prd: 
	@echo ........................................................................................................
	@echo "🖥 Subscription ${AZENV} - ${subprd} "
	@echo ........................................................................................................
	@az account set --subscription=${subprd}
	@echo ">> Done 🏁"


tf-setup: 
	@echo ........................................................................................................
	@echo "🖥 Initializing Code Env -> ${AZENV} .."
	@echo ........................................................................................................
	@echo ""
	@terraform init -backend-config="../../environments/backend.${AZENV}.tfbackend" -reconfigure  
	@echo ">> Done 🏁"


tf-update-module: 
	@echo ........................................................................................................
	@echo "🖥 Updating modules Env -> ${AZENV} .."
	@echo ........................................................................................................
	@echo ""
	@terraform  get -update 
	@echo ">> Done 🏁"



tf-format:
	@echo ........................................................................................................
	@echo "📝 Validating Code  Env -> ${AZENV} .."
	@echo ........................................................................................................
	@echo ""
	@terraform fmt 
	@echo ">> Done 🏁"

tf-validate:
	@echo ........................................................................................................
	@echo "🖥 Validating Syntax..."
	@echo ........................................................................................................
	@echo ""
	@terraform validate
	@echo ">> Done 🏁"

tf-plan: 
	@echo ........................................................................................................
	@echo "Creating Execution Plan  Env -> ${AZENV} ..."
	@echo ........................................................................................................
	@echo ""
	@terraform workspace select ${AZENV} 
	@terraform plan  -var-file="../../environments/variables-azure.tfvars" -var-file="../../environments/variables-env.${AZENV}.tfvars" 
	@echo ">> Done 🏁"

tf-apply:
	@echo ........................................................................................................
	@echo "Applying Execution Plan..."
	@echo ........................................................................................................
	@echo ""
	@terraform workspace select ${AZENV} 
	@terraform apply -var-file="../../environments/variables-azure.tfvars" -var-file="../../environments/variables-env.${AZENV}.tfvars"
	@echo ">> Done 🏁"


tf-apply-auto:
	@echo ........................................................................................................
	@echo "Applying Execution Plan..."
	@echo ........................................................................................................
	@echo ""
	@terraform workspace select ${AZENV} 
	@terraform apply -var-file="../../environments/variables-azure.tfvars" -var-file="../../environments/variables-env.${AZENV}.tfvars"  -auto-approve -compact-warnings  
	@echo ">> Done 🏁"




tf-pay:
	@echo ........................................................................................................
	@echo " Estimated cost of resources"
	@echo ........................................................................................................
	@echo ""
	@terraform workspace select ${AZENV} 
	@${COST} breakdown --path . --terraform-var-file "../../environments/variables-azure.tfvars" --terraform-var-file "../../environments/variables-env.${AZENV}.tfvars"  --terraform-var-file "../../environments/backend.${AZENV}.tfbackend"  --show-skipped
	@echo ">> Done 🏁"





tf-plan-destroy: 
	@echo ........................................................................................................
	@echo "Creating Execution Plan to destroy all..."
	@echo ........................................................................................................
	@echo ""
	@terraform workspace select ${AZENV} 
	@terraform destroy -var-file="../../environments/variables-azure.tfvars" -var-file="../../environments/variables-env.${AZENV}.tfvars" 
	@echo ">> Done 🏁"


tf-plan-destroy-auto: 
	@echo ........................................................................................................
	@echo "Creating Execution Plan to destroy all..."
	@echo ........................................................................................................
	@echo ""
	@terraform workspace select ${AZENV} 
	@terraform destroy -var-file="../../environments/variables-azure.tfvars" -var-file="../../environments/variables-env.${AZENV}.tfvars" -auto-approve  
	@echo ">> Done 🏁"



#----------------------
# Documentation Steps
#----------------------
.PHONY: cleanup-docs

cleanup-docs: 
	@rm ./docs-recursos.md


prepare-docs:
	@echo "Preparando arquivo de Tfvars..."
	@terraform-docs markdown  .  --output-file Docs-Recursos.md
	@echo ">> Done 🏁"


