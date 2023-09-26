#!/bin/bash

echo "Iniciando a criação dos recursos do Lab01 para a aula de Arquitetura Network..."
default_message="Pressione ENTER para continuar ou CTRL + C para sair..."

read_from_user(){
    read -p "${1}" my_var 
}

read_from_user "${default_message}"

cd infra/

echo -e "\n-----------------------------Iniciando o Terraform-------------------------------"
terraform init
echo "--------------------------------------------------------------------------------------"

echo -e "\n-----------------------------Validando as configurações-------------------------------"
terraform plan
echo "--------------------------------------------------------------------------------------"

echo "ATENÇÃO!!! Só prossiga caso o Terraform Plan tenha sido bem sucedido!"
read_from_user "${default_message}"

echo -e "\n-----------------------------Criando recursos-------------------------------"
terraform apply -auto-approve
access_url=$(terraform output -raw out_ec2_instance_access)
echo "--------------------------------------------------------------------------------------"

echo -e "\n------------------------Recursos Criados-------------------------------"
echo "URL de Acesso -> ${access_url}"
echo "--------------------------------------------------------------------------------------"