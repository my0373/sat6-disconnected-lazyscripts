#!/usr/bin/env bash

##
if [ $# -lt 1 ]
then
	echo "Usage: ${0} [/full/path/to_rhel7.iso] [/full/path/to/mountpoint]"
	exit 1
fi

## Get the ISO images
FULLISOPATH=$1
ISONAME=$(basename ${FULLISOPATH})
ISOPATH=$(dirname ${FULLISOPATH})
MOUNTPATH=$2


## Create the mountpoints
mkdir -p ${MOUNTPATH}

## Mount the images
mount -o loop ${FULLISOPATH} ${MOUNTPATH}

## Create the repositories
cat <<- EOF > /etc/yum.repos.d/rhel7server.repo
# cat
[rhel7iso]
name = RHEL7 Server
baseurl = file://${MOUNTPATH}/
enabled = 1
EOF

## Clean and repolist them
yum clean all
yum repolist

