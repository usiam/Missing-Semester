#!/bin/sh

count=0

# write a while loop that goes on until the exit code of the previous ran script (./random.sh) is not 0
until [[ "$?" -ne 0 ]]; do
    count=$((count+1))
    # &> will write the output of random.sh to a file
    ./random.sh &> out.txt
done

# once the loop stops print the count and also the output
echo "Script failed after $count attempts\n-------"
cat out.txt
    


