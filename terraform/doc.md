# Terraform

## Install
* wget https://releases.hashicorp.com/terraform/0.12.20/terraform_0.12.20_linux_amd64.zip
* unzip terraform_0.12.20_linux_amd64.zip
* mv terraform ~/Documentos/DevOps
* vim ~/.profile  
```bash
export PATH="$HOME/bin:$HOME/.local/bin:/home/edynson/Documents/DevOps:$PATH"
export PATH=$PATH:~/Documents/DevOps
```
* source ~/.profile

## Commands
* terraform --version
* terraform --help
* terraform --help plan
* terraform plan --destroy
* terraform apply
* terraform destroy
* terraform plan --target aws_security_group.allow_ssh_anywhere
* terraform apply --auto-approve
* terraform destroy --force
* terraform destroy -target aws_instance.web
* terraform validate
* terraform fmt
* terraform import aws_eip.eip ID_CONSOLE_AWS
* terraform apply --target aws_eip.eip
* terraform providers
* terraform show
* terraform tain aws_eip.eip
* terraform workspace new testing
* terraform workspace selected default
* echo aws_instance.web.private_ip | terraform console

* sudo apt install graphviz
* terraform graph | dot -Tsvg > graph.svg
* terraform state list
