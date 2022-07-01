# Three parts,  1. BEGIN clause- for headers on reports, etc
#               2. main body, unnamed for operations on each record
#               3. END clause for summarization, results of operations, etc.
#               -  you can also define functions in the beginning
#
#   $ awk -f prgfilename datafilename
#   $ awk '{prgtxt}' datafilename
#         ^notice the quotes are NOT ` execution marks
#
# Built-in variables
#   FS is field separator, can also be passed in by --fieldseparator
#   NF is the current field number on the current record
#   NR is the current record number in the file
#   ARGC is number of parameters
#   ARGV is array of parameters
#   $1, $2 ... are the fields on the record; $0 is the full record
#
# Commands
#
# print    includes a trailing newline char
# printf   doesn't add a newline char, appends to cursuor

function family() {}

BEGIN { FS=","; print "Membership Summary Report"  ; }

      { children += $3;
        t += 1;
        if ($4=="Single") s += 1;
        if ($4=="Married") m += 1; }

# another if/then technique uses "search patterns"
# weakness : the search text can occur anywhere on the line

      /Single/ { print $1 " is single!" }


END { print "Total children = " children ;
      print t " Total members" ;
      print "\t"  s " Single members" ;
      print "\t" m " Married members" ;
      print NR " active members" ;
      printf NF " fields on each member\n"
    }

# awk "\Married\ {print $1}" members.dat
# THE \SINGLE\ IS A "SEARCH PATTERN AND ACTS LIKE A GREP ON THE DATA RECORDS