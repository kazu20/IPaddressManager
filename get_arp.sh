#!/bin/bash
source config/NetworkInterface.cnf

sudo arp-scan -l --interface $NetworkInterface |grep ^[0-9]|grep -v packet

