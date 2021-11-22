FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_US.utf8
ARG USER=builder
ARG PUID=1000
ARG PGID=1000

RUN dpkg --add-architecture i386

RUN apt-get update && apt-get install -y \
	bc \
	bison \
	bsdmainutils \
	build-essential \
	chrpath \
	cmake \
	coreutils \
	corkscrew \
	cpio \
	curl \
	cvs \
	debianutils \
	device-tree-compiler \
	diffstat \
	diffstat \
	dos2unix \
	flex \
	g++ \
	gawk \
	gcc-multilib \
	git \
	git-core \
	iputils-ping \
	libarchive-zip-perl \
	libc6:i386 \
	libegl1-mesa \
	libgmp-dev \
	libgmp-dev \
	libmpc-dev \
	libmpc-dev \
	libncurses5 \
	libncurses5-dev \
	libncursesw5-dev \
	libsdl1.2-dev \
	libssl-dev \
	libstdc++6:i386 \
	libxml2-utils \
	libyaml-dev \
	linux-headers-generic \
	lrzsz \
	mercurial \
	nfs-common \
	nfs-kernel-server \
	pylint3 \
	pylint \
	xterm \
	python \
	python3 \
	python3-distutils \
	python3-git \
	python3-jinja2 \
	python3-pexpect \
	python3-pip \
	sed \
	socat \
	subversion \
	subversion \
	texi2html \
	texinfo \
	u-boot-tools \
	unzip \
	wget \
	xz-utils 

# Set up locales                                                                 
RUN apt-get install -y \
    locales && \
    locale-gen en_US.UTF-8 && \
    update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 

# Aditional tools
RUN apt-get install -y \
    sudo vim gdisk tree tmux zip

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# repo tool
RUN curl https://storage.googleapis.com/git-repo-downloads/repo > /usr/local/bin/repo && \
	chmod a+rx /usr/local/bin/repo

# User management                                                           
RUN groupadd -g ${PGID} ${USER} && \
    useradd -u ${PUID} -g ${PGID} -m ${USER} && \
    usermod -a -G sudo ${USER} && \
    usermod -a -G users ${USER}
RUN echo "${USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER ${USER}

WORKDIR /repo
