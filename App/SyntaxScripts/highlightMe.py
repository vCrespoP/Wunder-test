#!/usr/bin/env python3
# -*- coding: utf-8 -*-


### ------------------
### Imports and pipes
### ------------------

import os
import sys
import subprocess
# Make sure to execute in a terminal 
# export PYTHONIOENCODING=UTF-8

import time
import argparse



### ------------------
### Run terminal
### ------------------
def run(params):
    p = subprocess.Popen(params, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    for line in p.stdout.readlines():
        print(line)
    return p.wait()


# Configuration/Default variables
defaultCodePath = '../Code/Project'
defaultFolder = ''
defaultFlags = 'TODO:|FIXME:'

parser = argparse.ArgumentParser(description = 'Unifies code style')

parser.add_argument('-p', '--path',
					action = 'store',
					dest = 'codePath',
					default = defaultCodePath,
                    help = 'Path to main code folder')

parser.add_argument('-f', '--folder',
                    action = 'store',
                    dest = 'folder',
                    default = defaultFolder,
                    help = 'Folder to search into')

parser.add_argument('-fl', '--flags',
                    action = 'store',
                    dest = 'flags',
                    default = defaultFlags,
                    help = 'Flags to search')

args = parser.parse_args()


pathToSearch = args.codePath + '/' + args.folder

# Highlight
print('Searching ' + pathToSearch + ' for ' + args.flags)

start = time.time()
os.chdir(pathToSearch)
command = 'find %s \( -name "*.swift" \) -print0 | xargs -0 egrep --with-filename --line-number --only-matching "(%s).*\$" | perl -p -e "s/(%s)/ warning: \$1/"' % (pathToSearch, args.flags, args.flags)
print('Executing ' + command)
os.system(command)

end = time.time()
print("Time to highlight: %.2f seconds" % (end - start))


# Clean Up
print("Cleaning...")


print("")
print(" >>>>> Please check all warnings <<<<< ")
print("")

