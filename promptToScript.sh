#!/usr/bin/env bash
# The standard usage for the script
usage() { echo "Usage: $0 [-l <number of lines>] [-c <valid command>] [-f <filename>]" 1>&2;}

while getopts ":l:c:f:" o; do
    case "${o}" in
        l)
            LINES=${OPTARG}
            if ! [[ "$LINES" =~ ^[0-9]+$ ]] ; then
                usage
                exit 1
            fi
            if [[ -z "${COMMAND}" ]] ; then
                LINE_PRIO=1
            else
                COMMAND_PRIO=1;
            fi
            ;;
        c)
            COMMAND=${OPTARG}
            # Checking validity of COMMAND
			if [[ -n "${COMMAND}" ]] ; then
    			command -v "$COMMAND" &> /dev/null
    			if [[ $? -eq "1" ]] ; then
      				echo "$0: $COMMAND: command not found"
       				usage
       				exit 0
    			fi
			fi
            ;;
        f)
            FILENAME=${OPTARG}
            
            ;;
        *)
            usage
            exit 1
            ;;
    esac
done
if [[ -z "$FILENAME" ]] ; then
	usage
	exit 1
fi
if [[ -f "$FILENAME.sh" ]] ; then
	echo "File Already exists"
    exit 1
fi
echo "Number of Lines = $LINES"
echo "Command = $COMMAND"
echo "File = $FILENAME"
# Enable History in a non interactive shell
HISTFILE=~/.bash_history
set -o history
echo '#!/usr/bin/env bash' > "$FILENAME.sh"
history | tail -n "$LINES" >> "$FILENAME.sh";
chmod u+x "$FILENAME.sh"
# @todo
# String Processing
# Exclude Script lines 
# Command and Line number priorities
