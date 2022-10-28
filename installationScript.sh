#!/bin/bash

#https://github.com/RED-WAY/MANOInstallation/raw/main/manOS.jar
MANOS_URL=https://raw.githubusercontent.com/RED-WAY/MANOInstallation/main/manOS.jar
JAVA_VERSION=11
	
echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) Inicializando o instalador do man.OS"
sleep 2

echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) Olá, gostaria de iniciar a instalação do man.OS? (S/N)"
read confirm
if [ \"$confirm\" == \"S\" ]
	then
		clear
		echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) Verificando versão do JAVA..."
		sleep 2
		java -version
		if [ $? -eq 0 ]
			then
				echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) Você já possui o JAVA instalado!"
			else
				echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) Não foi identificada nenhuma versão instalada :("
				sleep 1
				echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) O JAVA é um sistema fundamental para o funcionamento da aplicação"
				sleep 1
				echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) Começar instalação do JAVA (S/N)?"
				read confirm
			if [ \"$confirm\" == \"S\" ]
				then
					echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7)  Baixando repositório..."
					sleep 2
					sudo add-apt-repository -qq ppa:webupd8team/java -y
					clear
					echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7)  Atualizando sistema..."
					sleep 2
					sudo apt -qq update && sudo apt -qq upgrade -y
					clear

					if [ $JAVA_VERSION -eq 11 ]
						then
							echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) Instalando JAVA na versão 11..."
							echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) Confirme a instalação quando solicitado"
							sudo apt -qq install default-jre ; apt install -qq openjdk-11-jre-headless; -y
							clear
							echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) Java instalado com sucesso!"
							sleep 2
							clear
						fi
				else 	
					echo "Finalizando instalação..."
					sleep 2
					clear
					exit
			fi
		fi

	echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) Baixando o sistema man.OS..."
	sleep 2
	wget --no-check-certificate --content-disposition -O $HOME/manOS.jar $MANOS_URL
	
	else
		echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) Digito inválido!"
fi
echo "Finalizando instalação..."
sleep 2
clear
exit
# ===================================================================
# All rights reserved: REDWAY Corp.
# Creative Commons @2022
# Podera modificar e reproduzir para uso pessoal.
# Proibida a comercialização e a exclusão da autoria.
# ===================================================================
