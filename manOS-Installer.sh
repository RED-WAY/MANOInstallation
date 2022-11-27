#!/bin/bash

JAVA_VERSION=11

# ---------- JAR VARS ----------
MANOS_LOGIN=redway-admin
MANOS_TOKEN=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
MANOS_AUTH="?login=${MANOS_LOGIN}&token=${MANOS_TOKEN}"

MANOS_GITHUB=https://raw.githubusercontent.com/RED-WAY
MANOS_REPO=MANOInstallation
MANOS_BRANCH=main
MANOS_FOLDERS=/builds/
MANOS_PATH=${MANOS_GITHUB}/${MANOS_REPO}/${MANOS_BRANCH}${MANOS_FOLDERS}

manos_jar() {
	echo ${MANOS_PATH}manOS-$1.jar${MANOS_AUTH}
}

# ---------- END OF JAR VARS ----------

MANOS_DB_DOCKER_VERSION=1.0.2

clear
echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) Inicializando o instalador do man.OS..."
sleep 1

echo "

███╗   ███╗ █████╗ ███╗   ██╗    ██████╗ ███████╗
████╗ ████║██╔══██╗████╗  ██║   ██╔═══██╗██╔════╝
██╔████╔██║███████║██╔██╗ ██║   ██║   ██║███████╗
██║╚██╔╝██║██╔══██║██║╚██╗██║   ██║   ██║╚════██║
██║ ╚═╝ ██║██║  ██║██║ ╚████║██╗╚██████╔╝███████║
╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝ ╚═════╝ ╚══════╝                                                 

"
sleep 3

echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) Olá, gostaria de iniciar a instalação do man.OS? (s/n)"
read confirm
clear
if [[ \"$confirm\" == \"s\" ]]; then
	echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) Atualizando sistema..."
	sleep 1
	sudo apt update && sudo apt upgrade -y
	clear
	echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) Sistema atualizado!"
	sleep 2
	clear

	# -------------------------------- JAVA INSTALLATION --------------------------------
	echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) Verificando versão do JAVA..."
	sleep 2
	java -version
	if [[ $? -eq 0 ]]; then
		echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) Você já possui o JAVA instalado!"
	else
		echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) Não foi identificada nenhuma versão instalada :("
		sleep 1
		echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) O JAVA é um sistema fundamental para o funcionamento da aplicação"
		sleep 1
		echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) Começar instalação do JAVA? (s/n)"
		read confirm
		if [[ \"$confirm\" == \"s\" ]]; then
			echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) Baixando repositório..."
			sleep 1
			sudo add-apt-repository -qq ppa:webupd8team/java -y
			clear

			if [[ $JAVA_VERSION -eq 11 ]]; then
				echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) Instalando JAVA na versão 11..."
				echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) Confirme a instalação quando solicitado"
				sudo apt install default-jre -y
				clear
				sudo apt install openjdk-11-jre-headless -y
				clear
				echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) Java instalado com sucesso!"

			fi
		else
			clear
			echo "Finalizando instalação do sistema..."
			sleep 1
			echo "Impossível o funcionamento sem o JAVA..."
			sleep 2
			clear
			echo "REDWAY Corp."
			exit
		fi
	fi
	# -------------------------------- END OF JAVA INSTALLATION --------------------------------

	sleep 2
	clear

	# -------------------------------- DOCKER INSTALLATION --------------------------------
	echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) Verificando versão do Docker..."
	sleep 2
	docker --version
	if [[ $? -eq 0 ]]; then
		echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) Você já possui o Docker instalado!"
	else
		echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) Não foi identificada nenhuma versão instalada :("
		sleep 1
		echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) O Docker é necessário para o backup dos dados capturados"
		sleep 1
		echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) Começar instalação do Docker? (s/n)"
		read confirm
		if [[ \"$confirm\" == \"s\" ]]; then
			echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) Baixando repositório..."
			sleep 1
			sudo apt-get install docker.io -y
			clear
			echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) Docker baixado!"
			sleep 2
			clear
			echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) Configurando inicialização..."
			sleep 1
			sudo systemctl docker enable
			sudo systemctl start docker
			sleep 1
			clear
			echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) Docker instalado e configurado!..."
			sleep 2
			clear

		else

			clear
			echo "Finalizando instalação do sistema..."
			sleep 1
			echo "Impossível o funcionamento sem o Docker..."
			sleep 2
			clear
			echo "REDWAY Corp."
			exit
		fi
	fi

	echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) Baixando imagem de MySQL do man.OS..."
	sudo docker pull mendesco/manos-db-img:$MANOS_DB_DOCKER_VERSION
	echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) Inicializando e configurando container MySQL..."
	sudo docker rm -f manos-db
	sudo docker run -dp 3306:3306 --name manos-db mendesco/manos-db-img:$MANOS_DB_DOCKER_VERSION
	clear
	echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) Docker e MySQL prontos!"
	# -------------------------------- END OF DOCKER INSTALLATION --------------------------------

	sleep 2
	clear

	# -------------------------------- JAR INSTALLATION --------------------------------

	show_menu() {
		normal=$(echo "\033[m")
		menu=$(echo "\033[36m")   #Blue
		number=$(echo "\033[33m") #yellow
		bgred=$(echo "\033[41m")
		fgred=$(echo "\033[31m")
		echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) Qual versão do manOS deseja instalar:"
		printf "\n${menu}************${normal}\n"
		printf "${menu}**${number} 1)${menu} GUI ${normal}${menu}**\n"
		printf "${menu}**${number} 2)${menu} CLI ${normal}${menu}**\n"
		printf "${menu}************${normal}\n"
		printf "Escolha entre ${menu}GUI ${normal}e ${menu}CLI ${normal}ou ${fgred}x para sair${normal}."
		read opt
	}

	option_picked() {
		msgcolor=$(echo "\033[01;31m") # bold red
		normal=$(echo "\033[00;00m")   # normal white
		message=${@:-"${normal}Erro: Nenhuma mensagem identificada!"}
		printf "${msgcolor}${message}${normal}\n"
	}

	clear
	show_menu
	while [ $opt != '' ]; do
		if [ $opt = '' ]; then
			break
		else
			case $opt in
			1)
				clear
				echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) Baixando o sistema man.OS COM interface gráfica..."
				sleep 2
				sudo rm -f $(find $HOME/ -name "manOS-GUI.jar")
				curl -LJ "$(manos_jar GUI)" -o $HOME/manOS-GUI.jar
				export MANOS_MODE="GUI"
				echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) man.OS foi instalado com SUCESSO :)"
				sleep 2
				clear
				break
				;;
			2)
				clear
				echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) Baixando o sistema man.OS para SERVIDORES..."
				sleep 2
				sudo rm -f $(find $HOME/ -name "manOS-CLI.jar")
				curl -LJ "$(manos_jar CLI)" -o $HOME/manOS-CLI.jar
				export MANOS_MODE="CLI"
				echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) man.OS foi instalado com SUCESSO :)"
				sleep 2
				clear
				break
				;;
			x)
				break
				;;
			\n)
				break
				;;
			*)
				clear
				option_picked "[manoBOT]: Escolha uma opção do menu!"
				show_menu
				;;
			esac
		fi
		sudo rm -r -f $(find $HOME/ -name "REDWAY")
	done
	# -------------------------------- END OF JAR INSTALLATION --------------------------------

	# -------------------------------- CREATING ALIASES --------------------------------
	echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) Criando atalhos..."
	sudo echo "alias manos-help='
	echo ""manos-start -\> utilize na primeira utilização do sistema para configurar o token""
	echo ""manos-log -\> inicia o sistema em plano de fundo \(NÃO FAZ LOGS\)""
	echo ""manos -\> inicia o sistema em plano de fundo \(COM LOGS\)""
	echo ""manos-stop -\> finaliza o man.OS""
	echo ""manos-reset -\> encerra a conexão da máquina com o site""
	echo ""manos-clean -\> remove o man.OS da máquina""
	'" >$HOME/.bash_aliases
	sudo echo "alias manos-stop='sudo pkill -f manOS-${MANOS_MODE}'" >>$HOME/.bash_aliases
	sudo echo "alias manos-start='manos-stop && sudo java -jar $(find $HOME/ -name "manOS-${MANOS_MODE}.jar")'" >>$HOME/.bash_aliases
	sudo echo "alias manos-log='manos-start &'" >>$HOME/.bash_aliases
	sudo echo "alias manos='manos-start > /dev/null &'" >>$HOME/.bash_aliases
	sudo echo "alias manos-reset='manos-stop && sudo docker rm -f manos-db && sudo docker run -dp 3306:3306 --name manos-db mendesco/manos-db-img:$MANOS_DB_DOCKER_VERSION'" >>$HOME/.bash_aliases
	sudo echo "alias manos-clean='manos-stop && sudo docker rm -f manos-db && sudo docker rmi -f mendesco/manos-db-img:${MANOS_DB_DOCKER_VERSION} && sudo rm -f $(find $HOME/ -name "manOS-${MANOS_MODE}.jar") && sudo rm -r -f $(find $HOME/ -name "REDWAY")'" >>$HOME/.bash_aliases
	sleep 1
	echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) Atalhos criados!"
	sleep 2
	clear
	# -------------------------------- END OF CREATING ALIASES --------------------------------

	sleep 2
	clear
	echo "

███    ███  █████  ███    ██ ██    ██  █████  ██      
████  ████ ██   ██ ████   ██ ██    ██ ██   ██ ██      
██ ████ ██ ███████ ██ ██  ██ ██    ██ ███████ ██      
██  ██  ██ ██   ██ ██  ██ ██ ██    ██ ██   ██ ██      
██      ██ ██   ██ ██   ████  ██████  ██   ██ ███████ 

"
	echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) Alguns atalhos foram criados:"
	echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) manos-start -> utilize na primeira utilização do sistema para configurar o token"
	sleep 1
	echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) manos-log -> inicia o sistema em plano de fundo (NÃO FAZ LOGS)"
	sleep 1
	echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) manos -> inicia o sistema em plano de fundo (COM LOGS)"
	sleep 1
	echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) manos-stop -> finaliza o man.OS"
	sleep 1
	echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) manos-reset -> encerra a conexão da máquina com o site"
	sleep 1
	echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) manos-clean -> remove o man.OS da máquina"
	sleep 1
	echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) manos-help -> traz a lista de comandos disponíveis"

	sleep 4
fi

echo "$(tput setaf 10)[manoBOT]:$(tput setaf 7) Finalizando instalação..."
echo "REDWAY Corp."
exec bash

exit
# ===================================================================
# All rights reserved: REDWAY Corp.
# Creative Commons @2022
# Pode modificar e reproduzir para uso pessoal.
# Proibida a comercialização e a exclusão da autoria.
# ===================================================================
