#!/bin/ksh
# the line above tells unix which shell interpreter to use on this text
#

# $ variables
# $? is the return code from the previous statement
# $0 is the os program name
# $# is the number of parameters passed to this text
# $1, $2, $3 ... are each of the parameters
# ${#varname} counts the charlengthin varname
# $(cmd) returns the value of that command - $(date) for example

#
echo Conditionals
#

# if
if [ $# -eq 0 ] ; then
	print No parameters passed
else
	print $# parameters passed
fi

if [[ "$quitnow" = "yes" ]] ; then
	keeplooping=0
fi

# case
# notice |=or and * is wildcard
print Want to quit?
read answer
case $answer in
	yes|Yes|y|Y)
		echo got a 'yes'
		;;
	no|No|n|N)
		echo got a 'no'
		;;
	q*|Q*)
		echo got a 'quit'
		exit
		;;
	*)
		echo Default clause - unrecognized case value.
		;;
esac

#
# LOOPING: while, until, for
# continue, break, select

# While
# two exits from the while loop: true condition or break statement
echo While you don't enter 'yes' ... I'll keep asking!
keeplooping=1;
while [[ $keeplooping -eq 1 ]] ; do
	echo While you don't enter 'yes' ... I'll keep asking!
	read quitnow
	if [[ "$quitnow" = "yes" ]] ; then
		keeplooping=0
	fi
	if [[ "$quitnow" = "q" ]] ; then
		break;  # exit the loop
	else
		continue; # jump to nxt iteration of the loop
	fi
done

# Until
until [[ $stopnow -eq 1 ]] ; do
	echo just run this once
	stopnow=1;
	echo we should not be here again.
done

list="cardinal venial mortal"
for sins in $list ; do         # also try - "for var in one two three; do"
	echo $sins
done

# Braces expand a variable to its value
two=2
echo 1${two}3

### arrays
# This is an OPTIONAL way to quickly null out prior values

# consider variables as results from statements
dirlist=`ls`

set -A array
#
array[1]="one"
array[2]="two"
array[3]="three"
three=3
print ${array[1]}
print ${array[2]}
print ${array[three]}

exit

BASH commands


alias		set a phrase to represent a complex cmd: alias ll='ls -al'
unalias		throw away a defined alias

bind

command
compgen
complete
declare
enable
env		all the env variable statements
eval

exit		ends the prg, pass it a return code
export		makes a local variable available outside the prg
hash

bg		restarts a suspended job and runs it in the background
fg		switches a background job to the foreground
jobs		lists the jobs spawned, children of the current process or shell
disown		removes a process from the current shell or process
wait		stops the current job until all the background ones finish
kill		aborts a job, by job number
exec		starts a new shell and executes the command
			nonzero return only when redir error
set		sets a var but allows a variety of os options
unset		throw away a local variable
logout		exits a shell

let
local

pushd		takes a new dir as arg, pushes curdir to stack and cd newdir
popd   		cd to the directory on top of the deck
                   pushd /var      - save where you are and cd /var
                   popd            - returns you to your old dir
fc 		Fix Command - accesses commands from history cache
printf          c print command - does NOT have a cr at the end.
dirs		like pwd, except uses ~ for home so it can be relative
sleep		argument is seconds; sleeps or waits x secs
readonly	makes variables readonly
return		ends the current program/function and returns an error code
shift		when >9 args, there's no $10, so shift X makes $n=$n+X
source
suspend
test
trap
typeset
uname		shows current version info, especially with the -a option
ulimit		show/set users limits to mem,files,buffers,processes, etc
umask		file creation mask - sets the default chmod for this user
times		prints out the user & system times used by this shell & children


SUBPROGRAMMING

basename        strips the directory from a filename; basename $0 ie
builtin		allows you to create a fn with same name as a native fn
			cd() { builtin cd /home }

These commands manip 'shell options' (lookem up)
  shopt
  setopt          a simpler version of 'set -o'
  getopts

