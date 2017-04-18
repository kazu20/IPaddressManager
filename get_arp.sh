#!/bin/bash
source config/NetworkInterface.cnf

arp-scan -l --interface $NetworkInterface |grep ^[0-9]|grep -v packet|grep -v DUP
