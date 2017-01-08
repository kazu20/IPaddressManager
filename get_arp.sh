#!/bin/bash

sudo arp-scan -l -interface en0 |grep ^[0-9]|grep -v packet

