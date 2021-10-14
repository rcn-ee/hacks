#!/bin/bash

sudo rm -f /boot/firmware/tiboot3.bin ;\
sudo rm -f /boot/firmware/tispl.bin ;\
sudo rm -f /boot/firmware/u-boot.img ;\
sudo rm -f /boot/firmware/sysfw.itb ;\
sync

sudo cp -v ./tiboot3.bin /boot/firmware/ ;\
sudo cp -v ./tispl.bin /boot/firmware/ ;\
sudo cp -v ./u-boot.img /boot/firmware/ ;\
sudo cp -v ./sysfw.itb /boot/firmware/ ;\
sync

