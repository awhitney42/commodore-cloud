FROM nvidia/cuda:11.4.0-base-ubuntu20.04
CMD nvidia-smi

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && apt-get upgrade -y && apt-get install -y \
  build-essential \
  supervisor openssh-server sudo mlocate less vim iproute2 \
  x11-apps mesa-utils libgl1-mesa-glx ubuntu-drivers-common \
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

RUN wget http://www.zimmers.net/anonftp/pub/cbm/crossplatform/emulators/VICE/vice-3.6.tar.gz
RUN tar zxvf vice-3.6.tar.gz
RUN cp vice-3.6.0/data/C64/kernal vice-3.6.0/data/C64/chargen vice-3.6.0/data/C64/basic /usr/lib/vice/C64
RUN cp vice-3.6.0/data/DRIVES/d1541II vice-3.6.0/data/DRIVES/d1571cr vice-3.6.0/data/DRIVES/dos* /usr/lib/vice/DRIVES

#RUN echo 'load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1;172.17.0.0/24' >> /etc/pulse/system.pa 
#RUN echo 'load-module module-zeroconf-publish' >> /etc/pulse/system.pa 

COPY vicerc /home/vice/.config/vice/vicerc

COPY tcpser.tar.gz tcpser_build.sh /root/
RUN chmod +x /root/tcpser_build.sh \
    && (sleep 1;/root/tcpser_build.sh 2>&1) 

EXPOSE 80 2222

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["/usr/bin/supervisord"]
#CMD ["/usr/sbin/sshd", "-D"]

