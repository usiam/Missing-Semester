#!/bin/sh
echo "Starting program at $(date)" # date will be substituted

# print the name of the program being ran as well as the number of arguments and the process id
echo "Running program $0 with $# arguments and pid $$"

# loop through all the arguments
for file in "$@"; do
    grep foobar "$file" > /dev/null 2> /dev/null
    # When pattern is not found, grep has exit code 1
    # We redirect STDOUT and STDERR to a null register since we do not care about them and only care about the exit code
    if [[ $? -ne 0 ]]; then
        echo "$file does not contain the string foobar. Adding it now."
        echo "# foobar" >> "$file"
    fi
done
