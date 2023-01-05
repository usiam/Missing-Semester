# LECTURE 02


## Shell Scripting
In this lecture we discuss the fundamentals of using the shell such as variables, conditionals, loops, and functions. We also look at some tools and useful things that others have built


### Assigning value to variables
Assign a value to a variable using `varName=varValue`. Notice the lack of whitespace. Whitespaces are reserved †o separate arguments so do not use whitespaces. You can check your value using `echo $varName`. E.g. `foo=bar` and then `echo $foo`.


### Strings
Double quotes ("") and single quotes (''). Only for literal strings they are equivalent. However, for everything else they are not. For single quotes '' any variable inside it will get expanded to its value i.e. `echo 'Value is $foo'` will print `Value is bar` to the terminal but if double quotes "" are used, then the print message will say `Value is $foo`

        foo=bar
        echo "$foo"
        # prints bar
        echo '$foo'
        # prints $foo

### Functions
To sequentially run shell commands you want to define them in a function. We define a function called `mcd()`. This function will create a directory from the first argument and then cd to the location given in the first argument.

    mcd(){
    mkdir -p "$1"
    cd "$1"
}

Here `$1` is the first argument to the script/function. Unlike other scripting languages, bash uses a variety of special variables to refer to arguments, error codes, and other relevant variables. Here's a few of them:

* $0 - Name of the script
* $1 to $9 - Arguments to the script. $1 is the first argument and so on.
* $@ - All the arguments
* $# - Number of arguments
* $? - Return error  code of the previous command
* $$ - Process identification number (PID) for the current script
* !! - Entire last command, including arguments. A common pattern is to execute a command only for it to fail due to missing permissions; you can quickly re-execute the command with sudo by doing sudo !!
* $_ - Last argument from the last command. If you are in an interactive shell, you can also quickly get this value by typing Esc followed by . or Alt+.

More of them can be found <a href='https://tldp.org/LDP/abs/html/special-chars.html'>here</a>.


Commands will often return output using `STDOUT`, errors through `STDERR`, and a Return Code to report errors in a more script-friendly manner. The return code or exit status is the way scripts/commands have to communicate how execution went. A value of 0 usually means everything went OK; anything different from 0 means an error occurred. E.g. if we search for the string `foobar` in our `mcd.sh` script we will get a 1.

        grep foobar mcd.sh
        echo $?

### Conditionals
true will always have `0` error code and false will always have `1`. We can also use exit codes to either run one command or another. E.g.

        false || echo "Oops failed."
        
is an `OR` statement that will run the second if the first returns an exit code of `0`. On the other hand,

        true || echo "Oops failed."
        
will not print "Oops failed" to the output.

There is also the `AND` operator which is `&&`. This runs only if both the statements return an exit code of `0`.

        true && echo "Things went well"
        
will print "Things went well"

        false && echo "This won't print"
        
will not print anything to `STDOUT`.

The last one is the `;`. This will always run the second command regardless of fails.

        true ; echo "This will always run"
        # This will always run

        false ; echo "This will always run"
        # This will always run

### Command and Process Substitution
Sometimes you might want to store the output a command in a variable. E.g. you can store the output of `pwd` to a variable `foo` using:

        foo=$(pwd)
        echo $foo
        
More generally you can do what is called *command substitution* by using `$(command)`. So, you can say `echo "The datetime right now is $(date)"` to print a proper messsage before the date.

Another nifty lesser known feature is *process substitution.* `<(command)` will execute the `command` and place the output of the command in a temporary file and substitute the `<()` with that file's name. This is useful when certain commands want their inputs as files instead of `STDIN`. E.g. 

        diff <(ls foo) <(ls bar)
        
will show differences between files in dirs foo and bar. Another example is we can concatenate the contents of different files using `cat`. So if we want to write a file that has the `ls` of both the current and the parent directories we will want to use the following *process substitution*:

        cat <(ls) <(ls ..)

So here first the contents of the current directory are put into a temporary file, then the contents of the parent directory are put into a temporary file. Finally both of them are concatenated using `cat`.

### Quick example of a script using all that we have learned
Let's write a script that utilizes a bunch of the things we have learnt so far. The script will iterate through the arguments we provide, grep for the string foobar, and append it to the file as a comment if it’s not found.

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
            
Note the comparison we used above to check if the last exit code was `0` or not using `-ne 0`. There are a handful of other comparisons that can be used and are explained in the manpage for `test`. Another important thing to notice is the use of `[[]]` instead of `[]`. 

### Globbing
When launching scripts, we often will be giving it similar arguments. Bash has ways of making this easier by carrying out filename expansions. These techniques used by bash are called `globbing`. Two of the main globbing techniques are:

* Wildcards: Whenever you want to perform some wildcard matching you want to use `?` or `*` to match one or any amount of characters respectively i.e. `?` matches any ONE char and `*` matches any arbitrary number of characters. E.g. given the files `foo`, `foo1`, `foo2`, `foo10`, and `bar`, the command `rm foo?` will remove the first two - `foo1`, `foo2` - whereas `rm foo*` will remove everything except `bar`.

* Curly braces `{}`: Whenever you have a common substring in a series of commands, you can use curly braces for bash to expand this automatically. This comes in very handy when moving or converting files.
    
        convert image.{png,jpg}  
        # Will expand to
        # convert image.png image.jpg

        cp /path/to/project/{foo,bar,baz}.sh /newpath
        # Will expand to
        # cp /path/to/project/foo.sh /path/to/project/bar.sh /path/to/project/baz.sh /newpath        
        

You can also combine the two (or more) globbing techniques above:
    
        mv *{.py,.sh} folder
        # this will move all the .py and .sh files to folder
        
You can also use the ellipsis `...` to expand all the items e.g.
        
        touch {foo,bar}/{a..h}
        # This creates files foo/a, foo/b, ... foo/h and also bar/a, bar/b, ... bar/h


### Scripting in other languages
Scripts need not be in bash; they can also be in something like `python`. E.g. we can print out the arguments in reverse using the following:

        #!/usr/local/bin/env python
        import sys
        for arg in reversed(sys.argv[1:]):
            print(arg)

The kernel knows to execute this script with a python interpreter instead of a shell command because we included a shebang line at the top of the script. It is good practice to write shebang lines using the env command that will resolve to wherever the command lives in the system, increasing the portability of your scripts. To resolve the location, env will make use of the PATH environment variable we introduced in the first lecture.


### Differences in shell functions and scripts
Some differences between shell functions and scripts that you should keep in mind are:

* Functions have to be in the same language as the shell, while scripts can be written in any language. This is why including a shebang for scripts is important.
* Functions are loaded once when their definition is read. Scripts are loaded every time they are executed. This makes functions slightly faster to load, but whenever you change them you will have to reload their definition.
* Functions are executed in the current shell environment whereas scripts execute in their own process. Thus, functions can modify environment variables, e.g. change your current directory, whereas scripts can’t. Scripts will be passed by value environment variables that have been exported using `export`
* As with any programming language, functions are a powerful construct to achieve modularity, code reuse, and clarity of shell code. Often shell scripts will include their own function definitions.

## Shell Tools

### Debugging shell commands using `shellcheck`
Bash scripting is fairly unintuitive. Therefore, there exist tools like `shellcheck` to help find/debug errors in sh/bash scripts. If you use `shellcheck mcd.sh` you should see:

        In mcd.sh line 1:
        mcd(){
        ^-- SC2148 (error): Tips depend on target shell and yours is unknown. Add a shebang or a 'shell' directive.
        

        In mcd.sh line 3:
            cd "$1"
            ^-----^ SC2164 (warning): Use 'cd ... || exit' or 'cd ... || return' in case cd fails.

        Did you mean:
            cd "$1" || exit

        For more information:
          https://www.shellcheck.net/wiki/SC2148 -- Tips depend on target shell and y...
          https://www.shellcheck.net/wiki/SC2164 -- Use 'cd ... || exit' or 'cd ... |..

`shellcheck` will give you syntax errors e.g. misplaced spaces, wrong names, etc.

Another example is if we run `shellcheck example.sh`

        In example.sh line 12:
        if [[ $? -ne 0 ]]; then
           ^------------^ SC3010 (warning): In POSIX sh, [[ ]] is undefined.
              ^-- SC2181 (style): Check exit code directly with e.g. 'if ! mycmd;', not indirectly with $?.

        For more information:
          https://www.shellcheck.net/wiki/SC3010 -- In POSIX sh, [[ ]] is undefined.
          https://www.shellcheck.net/wiki/SC2181 -- Check exit code directly with e.g...

### Finding how to use commands
We have already talked about `man` which gives the manual of a command if the provider allows installation of the manual alongside the program. However, the manpage of a command is usually incredibly long and dense and is hard to understand. We will install a tool called `tldr` that will give a much shorter and succint overview of a command alongside examples.


### Finding files
To find files we use `find` command. One way to use find is the following 

        # find root_folder -name "name here" -type "type here"
        find . -name src -type d

This will recursively look for all directories with the name src in the current folder.  Instead of using names we can also use paths

        find . -path "*/test/*.py" -type f
        
This will give us all the `.py` files regardless of how many directories there are between the current directory and the `.py` file.

You can find files in other ways using modified time, size, owners, etc.

        # files that were last modified in the last day using
        find . -mtime 1
        
        # all zip files within the size range 10k and 10M
        find . -size +10k -size -10M -name "*.tar.gz"
        

Once you find a file you can also modify the file. For example, you might want to find and delete all the files with a certain extention. The way you do that is:
        
        # The {} is replaced by the file name when found
        find . -name "*.tmp" -exec rm {} \;


### Finding code
What if we aren't really concerned about the files themselves but instead the contents of the files. Then you use `grep`. Let's say we want to find all the instances of the word *foo* in a directory.
        
        # -R will recursively search every file in the specified directory 
        grep foo -R .

We can also use a tool called `ripgrep` or `rg`. It works in a similar way except has better formatting. Let's search for the line `import sys` in all `.py` files in the current directory.

        rg 'import sys' -t py .
        
`rg` has a lot of useful flags/options. One of them is context `-C` that allows us to get the context around that line we are looking for.

        rg 'import sys' -t py -C 5 

Let's print all the files (including hidden files) that don't match the given pattern.
        
        # searching for all sh files that don't have a shebang
        # the -u searches hidden files as well
        rg -u --files-without-match "^#\!" -t sh

There's also the `--stats` flag that gives a summary statistic of all the `rg` results.

        rg 'import sys' -t py -C 5 --stats .
        
        1 matches
        1 matched lines
        1 files contained matches
        6 files searched
        157 bytes printed
        133 bytes searched
        0.000053 seconds spent searching
        0.003988 seconds

### Finding shell commands
You can find previously ran commands as well. The easiest (but slowest) way to do it is just using the up arrow on the keyboard. Some other alternatives are `history`. Or you can also `Ctrl + R` for backward search.


### Directory Navigation
You can list everything in the current directory using `ls` but you can also recursively list all the other folders inside as well using `ls -R`. Using `ls -l` will give a long form list as well.

Certain tools like `tree`, `broot`, or `nnn` will give a much better representation. `broot` in particular is nice and also includes fuzzy matching. To exit out of `broot` using `ctrl + Q`. `nnn` is more scenic and easy to navigate around using arrow keys (use `Q` to quit).

