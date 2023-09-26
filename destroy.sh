#!/bin/bash

echo "Confirma a deleção dos recursos?"
default_message="Pressione ENTER para continuar ou CTRL + C para sair..."

read_from_user(){
    read -p "${1}" my_var 
}

read_from_user "${default_message}"

cd infra/

echo -e "\n-----------------------------Deletando os recursos-------------------------------"
terraform destroy -auto-approve
echo "--------------------------------------------------------------------------------------"

echo "Recursos deletados com sucesso!"