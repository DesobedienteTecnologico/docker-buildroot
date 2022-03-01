FROM ubuntu:20.04

LABEL Description="Ubuntu 20.04 - For Buildroot work enviroment with X11" Version="1.0"

# Variables
ENV UID=1000
ENV GID=1000
ENV USER="user"
ENV BUILDROOT_VERSION="2021.02.10"

# Install packages without prompting the user to answer any questions
ENV DEBIAN_FRONTEND noninteractive 

# Install packages
RUN apt-get update && apt-get install -y \
apt-utils \
locales \
lsb-release \
mesa-utils \
git \
subversion \
vim \
nano \
terminator \
xterm \
wget \
curl \
htop \
libssl-dev \
dbus-x11 \
software-properties-common \
build-essential \
ncurses-base \
ncurses-bin \
libncurses5-dev \
sed \ 
dialog \
bash \
gdb valgrind && \
apt-get clean && rm -rf /var/lib/apt/lists/*


RUN echo "LC_ALL=en_US.UTF-8" >> /etc/environment
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
RUN echo "LANG=en_US.UTF-8" > /etc/locale.conf
RUN locale-gen en_US.UTF-8


# create user and add to group
RUN groupadd --gid $GID $USER \
  && useradd -s /bin/bash --uid $UID --gid $GID -m $USER

USER $USER

# Install Buildroot
RUN mkdir /home/$USER/ws
RUN wget https://www.buildroot.org/downloads/buildroot-$BUILDROOT_VERSION.tar.gz -O /home/$USER/ws/buildroot.tar.gz \
  && tar -xzf /home/$USER/ws/buildroot.tar.gz -C /home/$USER/ws/ \ 
  && rm /home/$USER/ws/buildroot.tar.gz

# Terminator Config
RUN mkdir -p /home/$USER/.config/terminator/
COPY assets/terminator_config /home/$USER/.config/terminator/config 

# VIM Config
COPY assets/vim_config /home/$USER/.vimrc 

# ---
CMD ["terminator"]
