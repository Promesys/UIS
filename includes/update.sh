		# Run an update and upgrade for packages
		echo "Checking for available software updates"
		echo ''
		sudo apt-get update -y &>/dev/null
		echo "Applying critical updates"
		echo ''
		sudo apt-get upgrade -y  &>/dev/null