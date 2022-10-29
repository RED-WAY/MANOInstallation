#!/bin/bash

JAVA_VERSION=11
MANOS_OPTIONS="GUI CLI"
MANOS_GUI_URL=https://raw.githubusercontent.com/RED-WAY/MANOInstallation/main/MANOJava-1.0-jar-with-dependencies.jar
MANOS_CLI_URL=https://raw.githubusercontent.com/RED-WAY/MANOInstallation/main/installationScript.sh

clear
echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) Inicializando o instalador do man.OS..."
sleep 2

echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) Olá, gostaria de iniciar a instalação do man.OS? (s/n)"
read confirm
if [[ \"$confirm\" == \"s\" ]]
	then
		clear
		echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) Verificando versão do JAVA..."
		sleep 2
		java -version
		if [[ $? -eq 0 ]]
			then
				echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) Você já possui o JAVA instalado!"
				sleep 2
			else
				echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) Não foi identificada nenhuma versão instalada :("
				sleep 1
				echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) O JAVA é um sistema fundamental para o funcionamento da aplicação"
				sleep 1
				echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) Começar instalação do JAVA (s/n)?"
				read confirm
			if [[ \"$confirm\" == \"s\" ]]
				then
					echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7)  Baixando repositório..."
					sleep 2
					sudo add-apt-repository -qq ppa:webupd8team/java -y
					clear
					echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7)  Atualizando sistema..."
					sleep 2
					sudo apt update && sudo apt upgrade -y
					clear

					if [[ $JAVA_VERSION -eq 11 ]]
						then
							echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) Instalando JAVA na versão 11..."
							echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) Confirme a instalação quando solicitado"
							sudo apt -qq install default-jre ; apt -qq install openjdk-11-jre-headless; -y
							clear
							echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) Java instalado com sucesso!"
							sleep 2
							clear
						fi
				else 	
					echo "Finalizando instalação..."
					sleep 2
					clear
					echo "REDWAY Corp."
					exit
			fi
		fi

	clear

	show_menu(){
	    normal=`echo "\033[m"`
	    menu=`echo "\033[36m"` #Blue
	    number=`echo "\033[33m"` #yellow
	    bgred=`echo "\033[41m"`
	    fgred=`echo "\033[31m"`
		echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) Qual versão do manOS deseja instalar:"
	    printf "\n${menu}************${normal}\n"
	    printf "${menu}**${number} 1)${menu} GUI ${normal}${menu}**\n"
	    printf "${menu}**${number} 2)${menu} CLI ${normal}${menu}**\n"
	    printf "${menu}************${normal}\n"
	    printf "Escolha entre ${menu}GUI ${normal}e ${menu}CLI ${normal}ou ${fgred}x para sair${normal}."
	    read opt
	}

	option_picked(){
	    msgcolor=`echo "\033[01;31m"` # bold red
	    normal=`echo "\033[00;00m"` # normal white
	    message=${@:-"${normal}Erro: Nenhuma mensagem identificada!"}
	    printf "${msgcolor}${message}${normal}\n"
	}

	clear
	show_menu
	while [ $opt != '' ]
	    do
	    if [ $opt = '' ]
			then
			break;
	    	else
				case $opt in
	        	1) clear;
					echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) Baixando o sistema man.OS COM interface gráfica..."
					sleep 2
					wget --no-check-certificate --content-disposition -O $HOME/manOS-GUI.jar $MANOS_GUI_URL
					echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) man.OS foi instalado com SUCESSO :)"
					sleep 2
					clear
					break
	        	;;
	        	2) clear;
					echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) Baixando o sistema man.OS para SERVIDORES..."
					sleep 2
					wget --no-check-certificate --content-disposition -O $HOME/manOS-CLI.jar $MANOS_CLI_URL
					echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) man.OS foi instalado com SUCESSO :)"
					sleep 2
					clear
					break
	        	;;
	        	x)break;
	        	;;
	        	\n)break;
	        	;;
	        	*)clear;
	        	    option_picked "[manoBOT]: Escolha uma opção do menu!";
	        	    show_menu;
	        	;;
				esac
	    fi
	done

fi

echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) Finalizando instalação..."
sleep 2
clear
echo "REDWAY Corp."
exit
# ===================================================================
# All rights reserved: REDWAY Corp.
# Creative Commons @2022
# Podera modificar e reproduzir para uso pessoal.
# Proibida a comercialização e a exclusão da autoria.
# ===================================================================