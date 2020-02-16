#! /bin/sh

##
# This utility script that can be used to get the Git-SHA of given branch of a given repository
# The script will clone the repository to a directory specified 
# Arguments 
#	1. Git URL. 
#			Format: https://github.com/username/repo_name.git (For private Repos https://username:password@github.com/username/repo_name.git)
#	2. Branch : 
#			Format: origin/master
#	3. Directory
#			Format: /home/scripts
##


### Argument mapping

git_url=$1
git_branch=$2
working_directory=$3

##### Function definitions

# Validate the command line arguments 
# $1 git_url
# $2 git_branch
# $3 working_directory 

validate_arguments() {
	# Git URL should be specified
	if [ -z $1 ] 
	then
		echo "\e[31m Git URL should be specified \e[0m"
		exit 1
	fi
	# If branch is not defined default to origin/master 
	if [ -z $2 ]
	then
		git_branch=origin/master
	fi
	# If directory not specified default to working directory
	if [ -z $3 ]
	then
		working_directory=$PWD
	fi
}

# Install git if not found

install_required_packages() {
	git_executable=$(which git)
	if [ -z $git_executable ] # If git not available download package without prompting
	then
		apt-get install git -y	>/dev/null # Result is not shown in terminal
	fi
}


# Get the directory name from Git URL

get_repository_name() {
	git_repo=${git_url##*/} # Will get repo_name.git string
	repo_name=${git_repo%.*} # Will get repo_name only
}



# Clone the repository if not available else git pull

get_repo() {
	if [ -z $repo_name ] # If repository name is undefined exit
	then
		echo "\e[31m Git URL is malformed \e[0m"
		exit 1
	fi
	if [ ! -d $repo_name ] # If the directory exist
	then
		git clone $git_url >/dev/null 2>&1 # Results are not shown in terminal. Seems like git clone is writing to STRERR
	fi

	cd $repo_name
	git pull >/dev/null
}


# Get Git info, in this case only SHA

get_git_info() {
	git_sha=$(git rev-parse $git_branch)
	echo $git_sha

}


### Main functions

validate_arguments $git_url $git_branch $working_directory
install_required_packages
get_repository_name
get_repo
get_git_info