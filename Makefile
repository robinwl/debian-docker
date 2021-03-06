DEBIAN_SUITE=wheezy
DEBIAN_MIRROR=http://gce_debian_mirror.storage.googleapis.com/
DOCKER_REPO=google/debian
ROOTFS_TAR=google-debian-${DEBIAN_SUITE}.tar.bz2
MKIMAGE=mkimage-debootstrap.sh
MKIMAGE_URL=https://raw.githubusercontent.com/dotcloud/docker/master/contrib/mkimage-debootstrap.sh

.PHONY: docker-image update-mkimage clean

all: docker-image

docker-image: ${ROOTFS_TAR}
	docker build -t ${DOCKER_REPO}:${DEBIAN_SUITE} .

${ROOTFS_TAR}: ${MKIMAGE}
	./${MKIMAGE} -t ${ROOTFS_TAR} ${DEBIAN_SUITE} ${DEBIAN_MIRROR}

update-mkimage: 
	wget -N ${MKIMAGE_URL}

clean:
	rm -f ${ROOTFS_TAR}
