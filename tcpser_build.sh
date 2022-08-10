#!/bin/sh

cd /root
tar zxvf tcpser.tar.gz
cd /root/tcpser
make
mkdir -p /usr/local/bin
cp tcpser /usr/local/bin

