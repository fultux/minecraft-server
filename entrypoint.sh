#!/bin/bash


verify_first_launch(){
	if [ -f /data/server.jar ];
       	then
		echo "Minecraft executable found in the data directory."
		return 0
	else
		echo "moving server.jar to the data directory"
		mv /tmp/server.jar /data
		chown minecraft:minecraft /data/server.jar
		java -Xmx${MEM_JAV}M -Xms${MEM_JAV}M -jar /data/server.jar nogui >/dev/null 2>&1
		sed -i 's|eula=false|eula=true|' /data/eula.txt
		return 0
	fi
}


launch_server(){
	java -Xmx${MEM_JAV}M -Xms${MEM_JAV}M -jar /data/server.jar nogui
}


verify_first_launch
if [ $? -eq 0 ];
then
	echo "First launch verification successful. Starting server..."
	launch_server
else
	echo "Something went wrong during the initial setup process.."
	exit 1
fi

