source /usr/share/bash-preexec.sh

# function run before each command. plays sound and delays a bit so the sound
# makes sense
preexec() {
	(mpg123 /var/local/cmd.mp3 &> /dev/null & sleep 0.4)
}

echo NOSTROMO v5.3
echo -n initializing console...
sleep 1
echo DONE

echo -n initializing ship controls...
sleep 1
echo DONE

echo -n preparing personal terminal...
sleep 1
echo DONE

echo
echo You have new messages. Access your personal terminal by running:
echo
echo     alien-console
echo
