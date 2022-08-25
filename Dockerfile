FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && apt-get upgrade -y && apt-get install -y \
  build-essential \
  supervisor openssh-server sudo mlocate less vim iproute2 lsof \
  x11-apps mesa-utils libgl1-mesa-glx ubuntu-drivers-common \
  x11vnc xvfb \
  vice \
  && rm -rf /var/lib/apt/lists/*

# Create vice user and set password
RUN useradd -rm -d /home/vice -s /bin/bash -g root -G sudo -u 1000 vice
RUN echo 'vice:areyoukeepingup' | chpasswd

# Also set the root password
RUN echo "root:Docker!" | chpasswd

# Copy the sshd_config file to the /etc/ssh/ directory
COPY sshd_config /etc/ssh/

# Create the supervisord log director
RUN mkdir -p /var/log/supervisor

# Copy and configure the ssh_setup file
RUN mkdir -p /tmp
COPY ssh_setup.sh /tmp
RUN chmod +x /tmp/ssh_setup.sh \
    && (sleep 1;/tmp/ssh_setup.sh 2>&1 > /dev/null)

# Create VNC user config directory
RUN mkdir /home/vice/.vnc

# Setup a VNC password
RUN x11vnc -storepasswd 10print /home/vice/.vnc/passwd

# Install VICE kernal and BASIC ROMs
COPY vice-3.6.0/data/C64/kernal vice-3.6.0/data/C64/chargen vice-3.6.0/data/C64/basic /usr/lib/vice/C64/
COPY vice-3.6.0/data/DRIVES/d1541II vice-3.6.0/data/DRIVES/d1571cr vice-3.6.0/data/DRIVES/dos* /usr/lib/vice/DRIVES/

# Pulse Audio - FIXME
#RUN echo 'load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1;172.17.0.0/24' >> /etc/pulse/system.pa 
#RUN echo 'load-module module-zeroconf-publish' >> /etc/pulse/system.pa 

COPY vicerc /home/vice/.config/vice/vicerc
COPY vicerc /root/.config/vice/vicerc

COPY tcpser.tar.gz tcpser_build.sh /root/
RUN chmod +x /root/tcpser_build.sh \
    && (sleep 1;/root/tcpser_build.sh 2>&1) 

EXPOSE 2222 5900 6400

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY vice.sh /home/vice/vice.sh
COPY x11vnc.sh /home/vice/x11vnc.sh

CMD ["/usr/bin/supervisord"]

