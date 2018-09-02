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

import argparse

def myPrint(string):
	print(string.encode("ascii", "ignore").decode("ascii"))

### ------------------
### Main entry point
### ------------------
def run(params):
    p = subprocess.Popen(params, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
#    for line in p.stdout.readlines():
#        myPrint(line)
    return p.wait()


pwd = os.getcwd()
myPrint('Current directory: ' + pwd)




# Configuration/Default variables
defaultProjectPath = pwd

defaultSourceryPath = pwd + '/../Pods/Sourcery'

defaultSourceryTemplatesPath = defaultSourceryPath + '/Templates/'
defaultCustomTemplates = defaultProjectPath + '/AutogenerationTemplates/Templates/'

defaultAutoGeneratedPath = defaultProjectPath + '/Domain/AutoGenerated/'

parser = argparse.ArgumentParser(description = 'Auto Generate code with sourcery')
parser.add_argument('-p', '--projectPath',
					action = 'store',
					dest = 'projectPath',
					default = defaultProjectPath,
                    help = 'Project path')

parser.add_argument('-sp', '--sourceryPath',
					action = 'store',
					dest = 'sourceryPath',
					default = defaultSourceryPath,
                    help = 'Sourcery Path')

parser.add_argument('-st', '--sourceryTemplatesPath',
					action = 'store',
					dest = 'sourceryTemplatesPath',
					default = defaultSourceryTemplatesPath,
                    help = 'Sourcery templates path')
 
parser.add_argument('-ct', '--customTemplates',
					action = 'store',
					dest = 'customTemplates',
					default = defaultCustomTemplates,
                    help = 'Custom templates path')

parser.add_argument('-ap', '--autoGeneratedPath',
					action = 'store',
					dest = 'autoGeneratedPath',
					default = defaultAutoGeneratedPath,
                    help = 'Path for code generation')


args = parser.parse_args()


# Execute sourcery
#sourcery = args.sourceryPath + '/bin/sourcery'
sourcery = 'sourcery'

myPrint('Generating predefined templates')
command1 = sourcery + ' --sources ' + args.projectPath + ' --templates ' + args.sourceryTemplatesPath + ' --output ' + args.autoGeneratedPath # + ' --watch'
myPrint('Trying: \n' + command1)
os.system(command1)

myPrint('Generating custom templates')
command2 = sourcery + ' --sources ' + args.projectPath + ' --templates ' + args.customTemplates + ' --output ' + args.autoGeneratedPath # + ' --watch'
myPrint('Trying: \n' + command2)
os.system(command2)



myPrint("")
myPrint("Done! Don't try to understand magic... it works in misterious ways")
myPrint("")
