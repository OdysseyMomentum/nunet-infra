#!/bin/bash

# this needs sudo access...

COM1=$1
COM2=$2

install() {
	curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
	sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
	sudo apt-get update && sudo apt-get install nomad
	nomad
}

start() {
	case $COM2 in
	'server')
		echo "Starting server"
		SERVER_DIR="/etc/nunet-adapter/server"
		if [ ! -d $SERVER_DIR ]; then
		  sudo mkdir -p $SERVER_DIR
		fi
		
		sudo cp ./configs/server.hcl $SERVER_DIR/
		sudo cp ./configs/nomad_server.service /etc/systemd/system/


		sudo systemctl enable nomad_server.service
		sudo systemctl start nomad_server.service

		;;

	'client')
		echo "Starting client"
		if [ ! -d /etc/nunet-adapter/client ]; then
		  sudo mkdir -p /etc/nunet-adapter/client
		fi

		CLIENT_DIR="/etc/nunet-adapter/client"
		if [ ! -d $CLIENT_DIR ]; then
		  sudo mkdir -p $CLIENT_DIR
		fi
		
		sudo cp ./configs/client.hcl $CLIENT_DIR/
		sudo cp ./configs/nomad_client.service /etc/systemd/system/


		sudo systemctl enable nomad_client.service
		sudo systemctl start nomad_client.service

		;;

	'office-client')
		echo "Starting client"
		if [ ! -d /etc/nunet-adapter/client ]; then
		  sudo mkdir -p /etc/nunet-adapter/client
		fi

		CLIENT_DIR="/etc/nunet-adapter/client"
		if [ ! -d $CLIENT_DIR ]; then
		  sudo mkdir -p $CLIENT_DIR
		fi

		sudo cp ./configs/office-desktop.hcl $CLIENT_DIR/
		sudo cp ./configs/nomad_client_office.service /etc/systemd/system/


		sudo systemctl enable nomad_client_office.service
		sudo systemctl start nomad_client_office.service

		;;

	'dev')
		echo "Starting Dev"
		DEV_DIR="/etc/nunet-adapter/dev"
		if [ ! -d $DEV_DIR ]; then
		  sudo mkdir -p $DEV_DIR
		fi
		
		stop server
		stop client

		sudo cp ./configs/dev.hcl $DEV_DIR/
		sudo cp ./configs/nomad_dev.service /etc/systemd/system/


		sudo systemctl enable nomad_dev.service
		sudo systemctl start nomad_dev.service

		;;
	esac	
}

stop() {
	case $COM2 in
		'server')
			echo "Stopping Nomad Server"
			sudo systemctl stop nomad_server.service			
			;;
		'client')	
			echo "Stopping Nomad Client"
			sudo systemctl stop nomad_client.service			
			;;
		'office-client')
			echo "Stopping Nomad Office Client"
			sudo systemctl stop nomad_client_office.service
			;;
		'dev')	
			echo "Stopping Nomad Dev"
			sudo systemctl stop nomad_dev.service			
			;;			
	esac
}


restart() {
	case $COM2 in
		'server')
			echo "Restarting Nomad Server"
			sudo systemctl restart nomad_server.service			
			;;
		'client')	
			echo "Restarting Nomad Client"
			sudo systemctl restart nomad_client.service			
			;;
		'office-client')
			echo "Restarting Nomad Office Client"
			sudo systemctl restart nomad_client_office.service
			;;
		'dev')	
			echo "Restarting Nomad Dev"
			sudo systemctl restart nomad_dev.service			
			;;
	esac
}	

uninstall() {
	case $COM2 in
		'server')
			echo "Uninstalling Nomad Server"
			stop server
			sudo systemctl disable nomad_server.service			
			;;
		'client')	
			echo "Uninstalling Nomad Client"
			stop client
			sudo systemctl disable nomad_client.service			
			;;
		'office-client')
			echo "Uninstalling Nomad Office Client"
			sudo systemctl disable nomad_client_office.service
			;;
		'dev')	
			echo "Uninstalling Nomad Dev"
			stop dev
			sudo systemctl disable nomad_dev.service			
			;;
	esac
}	

status() {
	systemctl status nomad_server.service --no-pager		
	systemctl status nomad_client.service	--no-pager
	systemctl status nomad_client_office.service --no-pager
	systemctl status nomad_dev.service	--no-pager
	}	


case $COM1 in
	'start')
		echo "Starting nunet-adapter"
		start
		;;
	'stop')
		stop
		;;
	'restart')
		restart
		;;
	'status')
		status
		;;
	'install')
		install
		;;
	'uninstall')
		uninstall
		;;	
esac


exit 0
