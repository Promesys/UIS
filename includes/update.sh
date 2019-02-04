		# Run an update and upgrade for packages
		echo "Checking for available software updates"
		echo ''
		sudo apt-get update -y &>/dev/null
		echo "Applying critical updates"
		echo ''
		sudo apt-get upgrade -y  &>/dev/null
        # Install essential dependencies
		echo "Installing essential dependencies"
		echo ''
		sudo apt-get install -y build-essential  &>/dev/null