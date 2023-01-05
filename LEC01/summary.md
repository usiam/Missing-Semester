# SUMMMARY

`date`: prints out the date and time to the terminal

`$PATH`: a colon separated path variable that the shell searches through to run programs like `echo` or `date`

`echo`: prints the argument onto the terminal   

`pwd`: prints the working directory

`cd <path>`: changes the directory to the given path

`ls`: list command to list all the contents of the current path. You can also use `-l` flag for a long form content with descriptions of users, permissions, and more.

`touch <pathToFile>`: Program to create an empty file

`mkdir <pathToDir>`: Program to create an empty directory

`mv <pathtoOldFile> <pathToNewFile>`: Moves a file from current path to another another. If file name is changed then the file is also renamed.

`cp <pathtoOldFile> <pathToNewFile>`: Copies a file from current path to another another. If file name is changed then the file is also renamed.

`rm <pathToFile>`: Removes a file. If given the `-r` recursive flag then can also remove a directory and all of its contents.

`rmdir <pathToDir>`: Can only remove an empty directory

`man <command>`: Used to display the manual of a program. Such as using `man ls` will show the manual for the `ls` command. USE `q` to quit.

`clear`: Clears the terminal and moves to top. Shorcut: ctrl + l

`cat`: By default `cat` duplicates its input to its output

`streams`: A concept to route the inputs and outputs of different files into other files. Mainly two important streams - the input and the output. Using \< you can put the contents of a file as an input to a command. And using \> you can put the output of a command as the input to a file. E.g. `cat < notes.md > copiedNotes.md` will first put the contents of notes.md as an input to `cat` and then put the outputs of cat which is just the contents as the output of copiedNotes.md.

`tail`: Gets the k tails of an output. The number is specified using the option `-nk` where k is the number of lines from the end to be selected. E.g. `tail -n1` will get the last line. 

`curl`: curl is a command-line tool for transferring data using various network protocols. It stands for 'Client URL.' You can get the header information from google.com using `curl --head google.com`

`grep`: The `grep` command searches for lines that contain strings that match a pattern. For example you can search for the count of times the word 'man' is found in notes.md using `grep 'man' -c notes.md`

`pipeline`: Pipe `|` allows the shell to interact between different commands. More specifically, the output of the command on the left of `|` is the input of the command to the right. You can use the following command to pipe the output of the header info from google.com and search for the word 'content-length' without case-sensitivity: `curl --head --silent google.com | grep -i content-length` 

`cut`: The cut command in UNIX is a command for cutting out the sections from each line of files and writing the result to standard output. You can get the specific value of the content length by piping the following: `curl --head --silent google.com | grep -i content-length | cut -d ' ' -f2`. This piece of command is getting the content-length and then splitting it on the delimeter (d) ' ' and getting the second field (f)

`tee`: ![tee](https://media.geeksforgeeks.org/wp-content/uploads/tee-command-linux.jpg) tee command reads the standard input and writes it to both the standard output and one or more files. Suppose we want to count number of words, lines, and characters in our notes.md file and also want to save the output to new text file so to do both activities at same time, we use tee command. `wc notes.md | tee counts.txt`

`sudo <command>`: Run a command as root user. Stands for 'do as super user'
