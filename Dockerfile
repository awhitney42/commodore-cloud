FROM nvidia/cuda:11.4.0-base-ubuntu20.04
CMD nvidia-smi
#FROM ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive

#RUN sed -i -e's/ main/ main contrib non-free/g' /etc/apt/sources.list

RUN apt-get update -y && apt-get upgrade -y && apt-get install -y \
  build-essential \
  openssh-server sudo mlocate less vim iproute2 \
  x11-apps mesa-utils libgl1-mesa-glx ubuntu-drivers-common alsa-utils pulseaudio \
  vice \
  && rm -rf /var/lib/apt/lists/*

# Create vice user and set password
RUN useradd -rm -d /home/vice -s /bin/bash -g root -G sudo -u 1000 vice
RUN echo 'vice:areyoukeepingup' | chpasswd

RUN wget http://www.zimmers.net/anonftp/pub/cbm/crossplatform/emulators/VICE/vice-3.6.tar.gz
RUN tar zxvf vice-3.6.tar.gz
RUN cp vice-3.6.0/data/C64/kernal vice-3.6.0/data/C64/chargen vice-3.6.0/data/C64/basic /usr/lib/vice/C64
RUN cp vice-3.6.0/data/DRIVES/d1541II vice-3.6.0/data/DRIVES/d1571cr vice-3.6.0/data/DRIVES/dos* /usr/lib/vice/DRIVES

#RUN echo 'load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1;172.17.0.0/24' >> /etc/pulse/system.pa 
#RUN echo 'load-module module-zeroconf-publish' >> /etc/pulse/system.pa 

COPY vicerc /home/vice/.config/vice/vicerc

RUN mkdir /var/run/sshd
RUN echo 'X11UseLocalhost no' >> /etc/ssh/sshd_config

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
