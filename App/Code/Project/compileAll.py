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



### ------------------
### Main entry point
### ------------------
def run(params):
    p = subprocess.Popen(params, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    for line in p.stdout.readlines():
        print(line)
    return p.wait()


pwd = os.getcwd()
print('Current directory: ' + pwd)


# Build all targets
print('Building all targets...')
command1 = 'xcodebuild \
                -target NetworkKit \
                -target NetworkSpecific \
                -target Domain \
                -target PlatformNetworkStatic \
                -target PlatformNetworkApi'
print('Using: \n' + command1)
os.system(command1)


print("")
print("Done! Targets have been built 🚀")
print("")

