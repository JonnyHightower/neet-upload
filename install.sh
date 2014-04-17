#!/bin/bash

export NEET=/opt/neet
export CONFIDR="${NEET}/etc"
export VERSION=`cat VERSION`
export INST="${PWD}"

if [ ! -d "$NEET" ]; then
	echo "Couldn't find neet installation. Exiting."
	exit 1
fi

. ${NEET}/core/installsupport

if [ ! -z $INVOKEDBYNEETUPDATE ] && [ $INVOKEDBYNEETUPDATE -eq 1 ]; then
	FILESTOREMOVE=""
	for file in $FILESTOREMOVE; do
		rm -f "$file"
	done
	echo -n "   + Installing updates to upload files..."
	#######################################################

	[ ! -d "${NEET}/upload" ] && mkdir -p "${NEET}/upload"
	cp -R content/* "${NEET}/upload/"
	chown -R root.root "${NEET}/upload/"
	chmod -R go-w "${NEET}/upload/"

	#######################################################
	newVersion neet-upload $VERSION
	echo "done"
else
	echo "This package is for the neet-update script and should not be installed manually."
	exit 1
fi

exit 0



