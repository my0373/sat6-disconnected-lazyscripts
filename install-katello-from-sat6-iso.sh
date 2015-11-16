#!/usr/bin/bash
set -x
##
if [ $# -lt 1 ]
then
	echo "Usage: ${0} [/full/path/to_sat6.iso] [/full/path/to/mountpoint]"
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
cat <<- EOF > /etc/yum.repos.d/rhel7rhscl.repo
# cat
[rhel7rhscl]
name = RHEL7 RHSCL
baseurl = file://${MOUNTPATH}/RHSCL/
enabled = 1
EOF

## Clean and repolist them
yum clean all
yum repolist

## Run the ./install_packages
cd ${MOUNTPATH}/
./install_packages
set +x

