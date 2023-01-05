  
# LECTURE 01


## Introduction 

This lecture will cover how to use the shell to do useful things. 

On the shell you write *commands* and *arguments* that are executed to do what the command tells the shell to. 

For example you can type `date` and it should show you the date and time.

You can also give commands with *arguments* or *multiple arguments* separated by a whitespace. One example is `echo` which prints whatever argument it gets. So,
    `echo Hello` will print **Hello** in the shell or you can use `echo "Hello World"` to print Hello World or `echo "Hello\ World"` to do the same.
    Very important to notice is the '\' character. It is used to *escape* a whitespace character because remember whitespace separates arguments.
    
By now you might be wondering how your computer knows these keywords or these commands? Well your computer comes with these things just like say it comes with a web browser. 

Your shell can search for programs i.e. know where a program is located. It does this through an *Environment Variable* much like those you might be familiar with in programming languages. So, your shell is a programming language. So it can do things like loops, conditions, define variables and functions and what not. This will be covered in Lecture 02.

### What is an *Environment Variable*?

- Variables that are set when you start your shell. E.g.
`PATH` is an env variable and you can search for **all the paths that your shell search for programs**. You can print a colon-separated list of paths in the shell using `echo $PATH`. So when the shell receives a command, it searches through all these paths and finds that command and executes it.

### How do you find the location of the program you ran?

- There is a command called `which` that will print the directory where the shell found your command. So, `which echo` will tell you where the echo program is located

### What is a path?

- There are two types: (1) Absolute (2) Relative. 


(2) Relative paths are relative to the current location.


To find the current directory we use `pwd` which prints the working directory. From this you can now change your directories using `cd <DIR NAME>`. 

There are some special directories that exist such as `cd .` means current directory and `cd ..` means change to the parent directory. 

Usually you want to use the path that is shorter however in some cases Absolute paths should be used. E.g. if you write a program that runs another program you want to make sure you can run it from anywhere so you want to use an absolute path otherwise the program may run for me but not for someone else as they can name their directories differently. 

One special character for `cd` is `~`. Using the command `cd ~` will change your working directory to the home directory. `~` just expands to '*/home/username*'. There is also `cd -` which changes working directory to the directory you were previously in. It is useful to toggle between two dirs.


### How do you figure out what's in your current directory?

- You can list all the items in your current dir. using `ls`. But `ls` also takes in arguments e.g. `ls ..` lists the items in the parent directory.

### How do we know that `ls` can be given a path?

- Most programs take arguments called *flags* or *options*. The most common one is `--help`. So running `ls --help` will give a bunch of info about the command. So, running `ls --help`. Anything that doesn't take a value is a flag and anything that does is an option. A special flag for ls is `ls -l` which is a long form listing of the files that gives additional info.

### What are some of these info?

- The lines should look like this:

`-rw-r--r--@ 1 usiam  staff  3559 Dec 18 16:11 notes.md`

The first word is either d or - and if it's a d that means that file is a directory. The next 9 letters are rwxrwxrwx. These show the *permissions* to either read (r), write (w) or execute (x) a file. As you can see there are 3 groups of *rwx*.

The first three *rwx* are perimissions for the owner of the file. Second group is for permissions of the group that own the file. The final 3 are permissions for everyone else. 

Running `ls -l` on this directory will print the following: 

`-rw-r--r--@ 1 usiam  staff  3559 Dec 18 16:11 notes.md` 

So, from here we see that notes.md is a file (notice there is no d) and the owner of the file has read and write perms. The group and everyone else only have read perm.

*rwx* do not have the same meaning for a directory. 
> r: are you allowed to see which files are in this directory - think of it as being able to list its contents say using `ls`

> w: are you allowed to rename, create or remove files in that directory. If you have write perms on a file but not the directory then you can't delete the file but you can empty it.

> x: for a directory this is known as *search*. So are you allowed to enter this directory. To be able to `cd` into a directory you will need execute (x) perms on not only that directory but ALL of its parent directories. E.g. to be able to access a file in the path "/home/username/coding/missingsemester/lec01/notes.md" I would need execute perms for the directories - root, home, username, coding, missingsemester, and lec01. 

### Can we move/copy/rename files on the shell?

- Of course, we can move and rename a file with the same command `mv <path_of_current_file> <path_to_new_file>` so we can move the `notes.md` file and rename it using `mv notes.md ../lec01_notes.md`. If we keep the name of the new file same then it only moves instead of move + rename. 

To copy and rename a file the command is `cp <path_of_current_file> <path_to_new_file>` so we can copy the `notes.md` file and rename it using `cp notes.md ../lec01_notes.md`. If we keep the name of the new file same then it only copy instead of copy + rename.
 
### Can we remove files on the shell?

- Yep, that's also simple. Just use `rm <path_to_file>`. This however will not remove a directory as it is not by default a recursive command. To remove a directory and everything in it we use `rm -r <path_to_dir>`. We can also delete an **empty** directory using `rmdir <path_to_dir>`.


### Can we create files/directories on the shell?

- Yes again. We can create files using `touch <path_to_file>` and empty directories using `mkdir <path_to_dir>`



### Let's inspect the manual page of different programs

- The command `man <program_name>` will give you a manual page for the program e.g. `man ls`. *Note: to quit the manual page you have to press q*


### Is the shell getting too busy and crowded?

- Use `ctrl + l` to clear the shell.



## Getting started with streams

So far what we have done is just call programs on one file or directory. The shell is most powerful when you combine many different programs and make them interact with each other through their outputs. The way to do this is through *streams*.

There are two main streams: (1) Input stream - your keyboard (2) Output stream - the stream the program prints to

The shell let's you play around with these streams. E.g. you might not want to print the output to the terminal but instead put it in a text file. 

The most straight forward way to do this is using: < or >

> program \< file: Rewire the inputs of this program to be the contents of this file

> program \> file : Rewire the outputs of the program to be the contents of this file

Example:
`echo hello > hello.txt` puts the text hello which is the ouput of the program echo (remember it prints the arguments in the shell) into a text file called *hello.txt*

We can check this using the command `cat <path_to_file>`. If we run `cat notes.md` that means the input to `cat` is notes.md and so it prints out the contents of this file. By default `cat` duplicates its input to its output. This means we should be able to wire the contents of one file to another file. E.g. `cat < notes.md > ../lec01_notes.md` will put the contents of notes.md as the input of `cat` and then the output of `cat` which is the contents in notes.md will be output into the file '../lec01_notes.md'. This is equivalent to copying the notes.md file to lec01_notes.md in the parent directory.


Instead of rewriting a file we can also append to it using `>>`

## Pipelines in the shell using pipe `|`

What pipe means is take the output of the program to the left and make it the input of the program to the right. 

Let's look at a simple interaction between two programs. If we want to list in detail all the contents of a directory and grab the last one and write it to a text file what do we do?

The command for that would look like the following:

`ls -l / | tail -n1 > notes.txt`

Let's look at another example where we get the *content-length* in the google.com header:

`curl --head --silent google.com`

will give you all the header info of google.com.
Next we want to search for *content-length* using the program `grep` that lets us search for specific things in an input stream. Additionally since we want to make the search non-sensitive to case we use a flag. The command would be:

`grep --ignore-case content-length`

Finally, we (1) change --ignore-content to -i and use pipe to combine the two.

`curl --head --silent google.com | grep -i content-length`

We can chain this with `cut d ' '` to separate the output of the previous into a list. Since we want the second item (or field) we use `-f2`

`curl --head --silent google.com | grep -i content-length | cut -d ' ' -f2`

## The root user

It is the admin user for macOS and linux with user-id 0. The root user is special because it can do whatever with any files on your system. Most times you want to avoid being the root user since you will be able to easily destroy your computer without any restriction.

However, sometimes you may NEED to be the root user. The way you do something as a root user is using the `sudo` command - do as the super user. `sudo` will be followed by the command you want to run.






