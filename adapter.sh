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
	esac
}	

status() {
	systemctl status nomad_server.service --no-pager		
	systemctl status nomad_client.service	--no-pager
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
esac


exit 0