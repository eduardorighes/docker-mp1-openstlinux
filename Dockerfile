FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_US.utf8
ARG USER=builder
ARG PUID=1000
ARG PGID=1000

# From https://wiki.st.com/stm32mpu/wiki/PC_prerequisites

RUN apt-get update && apt-get install -y \
    gawk wget git-core git-lfs diffstat unzip texinfo gcc-multilib g++-multilib build-essential chrpath socat cpio python3 python3-pip python3-pexpect xz-utils debianutils iputils-ping python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev pylint3 pylint xterm \
    libmpc-dev libgmp-dev \
    libncurses5 libncurses5-dev libncursesw5-dev libssl-dev linux-headers-generic u-boot-tools device-tree-compiler bison flex g++ libyaml-dev libmpc-dev libgmp-dev \
    coreutils bsdmainutils sed curl bc lrzsz corkscrew cvs subversion mercurial nfs-common nfs-kernel-server libarchive-zip-perl dos2unix texi2html diffstat libxml2-utils

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

# fix python <-> python3
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 3

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
