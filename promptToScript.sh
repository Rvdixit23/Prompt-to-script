# The standard usage for the script
usage() { echo "Usage: $0 [-l <number of lines>] [-c <valid command>] [-f <filename>]" 1>&2; exit 1; }

LINES=
COMMAND=

while getopts ":l:c:f:" o; do
    case "${o}" in
        l)
            LINES=${OPTARG}
            if ! [[ "$LINES" -eq "$LINES" ]] ; then
                # Specifying usage if the value is not a number
                # Numeric value evaluations of non number gives false
                usage
            fi
            # Assigning Line and Command Priorities
            if [[ -z "${COMMAND}" ]] ; then
                LINE_PRIO=1
            else
                COMMAND_PRIO=1;
            fi
            ;;
        c)
            COMMAND=${OPTARG}
            ;;
        f)
            FILENAME=${OPTARG}
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

# Checking validity of COMMAND
# @todo Suppress output of which
if ! [[ -z "${COMMAND}" ]] ; then
    which ${COMMAND}
    if [[ $? -eq "1" ]] ; then
        echo "$0: ${COMMAND}: command not found"
        usage
    fi
fi

echo "Number of Lines = ${LINES}"
echo "Command = ${COMMAND}"


# Enable History in a non interactive shell
HISTFILE=~/.bash_history
set -o history
hist=`history|tail -n ${LINES}`
echo $hist

# @todo
# String Processing
# Check if file already exists
# Create script
# Exclude Script lines 
# Command and Line number priorities

# Creating the new script from history
# echo shabang line and x number of LINES of history to new script
# echo \#\!\/bin\/bash > $FILENAME.sh; history | tail -n $LINES >> $FILENAME.sh;
# chmod u+x $FILENAME.sh;


