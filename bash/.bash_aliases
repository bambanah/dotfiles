#!/bin/bash

# Config
alias valias="nvim ~/.bash_aliases"
alias vbashrc="nvim ~/.bashrc"

# Commands
alias vim="nvim"
alias v="nvim"

# ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Git
alias gclean="git clean -df && git reset --hard"
alias glog="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

# Misc.
alias gimme="sudo chown -R wm-admin"
function repos() {
	cd "/home/wm-admin/repos/${1:-.}" || exit
}

#
# ----- C#Bot -----
#

# --- Lazy
alias src="cd serverside/src"

# First time setup
setup_cbot() {
	echo -e "Installing clientside dependencies...\n\n"
	cd clientside || exit
	yarn install

	echo -e "\n\nCreating initial DB migration...\n\n"
	cd ../serverside/src || exit
	dotnet ef migrations add InitialMigration

	echo -e "\n\nSeeding database...\n\n"
	dotnet ef database update

	echo -e "\n\nProject has been set up. Run with 'dotnet run'."
	echo -e "Make sure to check the handover for any required code changes."
}

# --- .NET
alias d="dotnet"
alias drun="dotnet run"
alias cdrun="cd serverside/src && dotnet run"

# Empty and reseed database
alias dbreset="dotnet ef database drop -f && dotnet ef database update"

# Reset and Run
alias rr="dotnet ef database drop -f && dotnet ef database update && dotnet run"

# --- Postgres
alias psql-postgres="psql postgres -h 127.0.0.1"

# --- Docker
alias dup="docker-compose up"

#
# ----- LAMPBot -----
#

# --- Virtual Machines

# Basic VM commands
alias sshvm="ssh user@192.168.56.103"
alias listvms="VBoxManage list vms"

# Basic alias
alias sa="./site_admin.sh"

# Minification
alias m="./site_admin.sh minify"
alias mm="./site_admin.sh minify -no-minification"

# VM UUID Swapper
# If no argument is provided, return the current VM
switchvm() (
	# Define initial variables
	betaID=81c31bb5-890c-48f7-aa44-ca3b6ffb1280
	testID=b46665d6-057f-41b1-ad09-ea8ed040910e
	UUID=${1,,}

	# Can run command from Parent or child directories
	if [ -f ./site_admin.sh ]; then
		site_admin=./site_admin.sh
		project_config=config/project_config.sh
	elif [ -f ../site_admin.sh ]; then
		site_admin=../site_admin.sh
		project_config=../config/project_config.sh
	else
		printf '\nNo site_admin.sh found in current or parent directory.\n'
		return;
	fi

	# Get currently assigned UUID and check for a match with a known ID
	currentID=$(grep "VM_UUID" $project_config | cut -d "=" -f 2)
	[[ $currentID == "$betaID" ]] && match="Beta"
	[[ $currentID == "$testID" ]] && match="Test"

	# Helper script for actually updating the UUID in project_config
	switch() {
		bash $site_admin vm_stop 2>/dev/null
		sed -i "s/^VM_UUID=.*/VM_UUID=$1/" $project_config
		bash $site_admin vm_start
		
		# TODO: Wait for the vm to start up then link_site
		#	echo -e "\nVM Switched. Waiting for bootup then linking site..."
		# bash $site_admin link_site
	}

	if [ -z "$1" ]; then
		echo -e "Usage: switchvm [beta|test|UUID]\n"
		echo -e "Switches the VM_UUID property in project_config.sh.\n"
		echo -e "If passing a VM UUID, must be of format XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX\n"
		printf 'Current UUID: %s' "$currentID"
		if [ -n "$match" ]; then
			echo " ($match)"
		fi
	elif [ -n "$match" ] && [ "${match,,}" == "$UUID" ] ; then
		printf '%s is already the active VM.\n' "$match"
	else
		if [ "$UUID" = "beta" ]; then
			switch $betaID
			echo "Switched to Beta VM (UUID: $betaID)"
			echo -e "\nVM Switched. You will need to link_site once the VM is running."
		elif [ "$UUID" = "test" ]; then
			switch $testID
			echo "Switched to Test VM (UUID: $testID)"
			echo -e "\nVM Switched. You will need to link_site once the VM is running."
		elif [[ "$UUID" =~ ^[0-9a-z]{8}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{12}$ ]]; then
			switch "$UUID"
			echo "Switched to VM with UUID of $UUID"
			echo -e "\nVM Switched. You will need to link_site once the VM is running."
		else
			echo "Invalid VM. Must be either 'beta', 'test' or a valid UUID"
		fi
	fi
)

#
# ----- NGR -----
#

alias ngr-deps="~/repos/myNGR.Parent/manage_local_servers.sh start_server dependencies"

alias ngr-uat-tunnel="ssh -N -L 7778:sqllstrAGNGR.my.cloud:9999 ngradmin@103.235.96.36 &"
alias ngr-prd-tunnel="ssh -N -L 7777:sqllstrNGRprod.my.cloud:9999 ngradmin@103.235.96.36 &"
alias ngr-dev-db-container="sudo docker exec -it myngr_db_1 /bin/bash"
alias ngr-dev-db-container-root="sudo docker exec -it --privileged --user root myngr_db_1 /bin/bash"
alias ngr-edocs-error-log="nc 192.168.15.114 5678"
alias ngr-rc="set -a; source ~/repos/myNGR.Parent/myNGR/.env.development; RAILS_ENV=development bundle exec rails c"

