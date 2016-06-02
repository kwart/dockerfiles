# Image for converting Linux images to VHD format

There is a known bug in qemu-img versions >=2.2.1 that results in an improperly formatted VHD.
The issue will be fixed in an upcoming release of qemu-img. For now it is recommended to use
qemu-img version 2.2.0 or lower. 

Reference: https://bugs.launchpad.net/qemu/+bug/1490611

This image workarounds the issue as it's based on centos image which still contains the old qemu-img version.

## Run the image
```bash
IMGNAME=rhel-guest-7.2
docker run -e IMGNAME=$IMGNAME -it --rm -v `pwd`:/mnt:rw kwart/qemu-img
```

## Sample conversion commands in container

```bash
#resize to whole MB
#https://azure.microsoft.com/en-us/documentation/articles/virtual-machines-linux-create-upload-vhd-redhat/
qemu-img convert -f qcow2 -O raw $IMGNAME.qcow2 $IMGNAME.raw

MB=$((1024*1024)) IMGSIZE=$(qemu-img info -f raw --output json "${IMGNAME}.raw" | \
        gawk 'match($0, /"virtual-size": ([0-9]+),/, val) {print val[1]}')
IMGSIZEROUNDED=$((($IMGSIZE/$MB + 1)*$MB))
echo "Image size: $IMGSIZE, rounded: $IMGSIZEROUNDED"

qemu-img resize -f raw $IMGNAME.raw $IMGSIZEROUNDED
qemu-img convert -f raw -o subformat=fixed -O vpc $IMGNAME.raw $IMGNAME.vhd

exit
```
