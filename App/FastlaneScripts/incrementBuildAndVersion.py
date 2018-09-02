#!/usr/bin/env python3
# -*- coding: utf-8 -*-


### ------------------
### Imports and pipes
### ------------------

import os
import sys
# reload(sys)
# sys.setdefaultencoding('utf-8')
import plistlib
import xml.etree.ElementTree
import argparse


### ------------------
### Helpers
### ------------------
def readContentsOfFile(pathToFile):
	if os.path.exists(pathToFile):
		return open(pathToFile, 'r').read()
	sys.exit('The file %s does not exist' % pathToFile)

# Rename content
def replaceAllContentInFile(filePath, newContent):
	# Write data
	f = open(filePath,'w')
	f.write(newContent)
	f.close()


def incrementVersion(infoPlist):
    if not os.path.exists(infoPlist):
        print('The file %s does not exist' % infoPlist)
        return None
        
    plistData = plistlib.readPlist(infoPlist)


    ### Editing .plist
    version = plistData['CFBundleShortVersionString']
    print('Current .plist version %s' % version)

    buildNumber = plistData['CFBundleVersion']

    # Split version into components ~> M.s.b
    components = version.split(".")   
    # Get last component ~> b
    lastComponent = buildNumber
    # Convert it to int to operate  ~> int(b)
    lastComponentNumber = int(lastComponent)
    # Increment it by one ~> b++
    lastComponentNumberIncreased = lastComponentNumber + 1 

    # Convert components into strings
    componentsString = results = list(map(str, components))

    # Let last component to be 3 digit ~> bbb
    # print('lastComponentNumberIncreased %s' % lastComponentNumberIncreased)
    lastComponentNumberIncreasedString = "%03d" % (lastComponentNumberIncreased)
    # print('~> Min 3 digits %s' % lastComponentNumberIncreasedString)
    lastComponentNumberIncreasedString = lastComponentNumberIncreasedString[-3:]
    # print('~> Limit to %s' % lastComponentNumberIncreasedString)

    # Replace last component increased ~> M.s.b++
    componentsString[-1] = lastComponentNumberIncreasedString


    # Join into version number
    newVersion = '.'.join(componentsString)
    # print('New .plist version %s' % newVersion)

    # Replace version number
    plistData['CFBundleShortVersionString'] = newVersion
    # Replace build number
    plistData['CFBundleVersion'] = str(lastComponentNumberIncreased)

    ### ------------------
    ### Store .plist
    ### ------------------
    plistlib.writePlist(plistData, infoPlist)
    print('Version set to %s' % (newVersion))
    print('Build set to %s' % (lastComponentNumberIncreasedString))

def main():

    ### ------------------
    ### Main + Arguments
    ### ------------------

    # Configuration/Default variables
    defaultPlistPath = '../Code/Project/Project/OtherResources/Info.plist'

    parser = argparse.ArgumentParser(description = 'Increment build/version number')

    parser.add_argument('-pl', '--plist',
    					action = 'store',
    					dest = 'plist',
    					default = defaultPlistPath,
                        help = 'Relative path to Info.plist or similar')

    args = parser.parse_args()

    ### ------------------
    ### Read .plist
    ### ------------------
    infoPlist = args.plist
    incrementVersion(infoPlist)

if __name__ == '__main__':
    main()




