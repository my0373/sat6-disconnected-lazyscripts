#!/usr/bin/env bash
ISODIR=/var/lib/isos/
ISOS=$(ls ${ISODIR})
DEST=/var/www/html/pub/sat-import/

for ISO in ${ISOS}
do
    MNTPATH="/mnt/${ISO}/"
    ISOFILE="${ISODIR}${ISO}"

    echo "Copying ${ISOFILE}"
    mkdir -p ${MNTPATH}
    mount -o loop ${ISOFILE} ${MNTPATH}
    cp -ruv ${MNTPATH}* ${DEST}
    umount ${MNTPATH}
    rmdir ${MNTPATH}
done
restorecon -rv ${DEST}
