# Exercises

* For this course, you need to be using a Unix shell like Bash or ZSH. If you are on Linux or macOS, you don’t have to do anything special. If you are on Windows, you need to make sure you are not running `cmd.exe` or PowerShell; you can use Windows Subsystem for Linux or a Linux virtual machine to use Unix-style command-line tools. To make sure you’re running an appropriate shell, you can try the command `echo $SHELL`. If it says something like `/bin/bash` or `/usr/bin/zsh`, that means you’re running the right program.

* Create a new directory called missing under `/tmp`.
        mkdir /tmp/missing
 
* Look up the `touch` program. The `man` program is your friend.
        man touch
        
* Use `touch` to create a new file called semester in missing.
        touch /tmp/missing/semester
        
* Write the following into that file, one line at a time:\
`#!/bin/sh`\
`curl --head --silent https://missing.csail.mit.edu`
    
    The first line might be tricky to get working. It’s helpful to know that `#` starts a comment in Bash, and `!` has a special meaning even within double-quoted (") strings. Bash treats single-quoted strings (') differently: they will do the trick in this case. See the Bash quoting manual page for more information.

        echo '#!/bin/sh\ncurl --head --silent https://missing.csail.mit.edu' >> semester

* Try to execute the file, i.e. type the path to the script `(./semester)` into your shell and press enter. Understand why it doesn’t work by consulting the output of `ls` (hint: look at the permission bits of the file).
        ./semester
    Gives an error that says no permission to execute:
    <span style="color:red">zsh: permission denied: ./semester</span>

    Using `ls -l` we can see the following:
        -rw-r--r--  1 usiam  wheel  61 Jan  3 16:10 semester

* Run the command by explicitly starting the `sh` interpreter, and giving it the file semester as the first argument, i.e. `sh semester`. Why does this work, while `./semester` didn’t?
        sh semester
        
    We can't execute this file due to permissions and thus cannot see the *shebang* `#!/bin/sh` that would tell the shell which program to use.
    
* Look up the `chmod` program (e.g. use `man chmod`).
        man chmod

* Use `chmod` to make it possible to run the command `./semester` rather than having to type `sh semester`. How does your shell know that the file is supposed to be interpreted using sh? See this page on the shebang line for more information.
        
        chmod 701 ./semester

    The shebang `#!/bin/sh` which tells the shell to use the sh program to run the file. We can also use 
    
        chmod 777 ./semester
    
    to allow all permissions for all users (owner, group, and everyone else).

* Use `|` and `>` to write the “last modified” date output by `semester` into a file called `last-modified.txt` in your home directory.
        
        ./semester | grep -i last-modified | tee last-modified.txt
        OR
        ./semester | grep -i last-modified > last-modified.txt
        

* Write a command that reads out your laptop battery’s power level or your desktop machine’s CPU temperature from /sys. Note: if you’re a macOS user, your OS doesn’t have sysfs, so you can skip this exercise.
        Using a mac so can't do this :(
        

