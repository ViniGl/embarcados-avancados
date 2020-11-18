#
TARGET = hps_gpio
ALT_DEVICE_FAMILY ?= soc_cv_av
SOCEDS_ROOT ?= $(SOCEDS_DEST_ROOT)
HWLIBS_ROOT = $(SOCEDS_ROOT)/ip/altera/hps/altera_hps/hwlib
CROSS_COMPILE = arm-linux-gnueabihf-
CFLAGS = -g -Wall   -D$(ALT_DEVICE_FAMILY) -I$(HWLIBS_ROOT)/include/$(ALT_DEVICE_FAMILY)   -I$(HWLIBS_ROOT)/include/
LDFLAGS =  -g -Wall 
CC = $(CROSS_COMPILE)gcc
# CC = gcc

ARCH= arm

SCP_PATH = root@169.254.0.13
CP_PATH = /root
TARGET_PATH = "./$(TARGET)"


build: $(TARGET)

$(TARGET): main.o 
	$(CC) $(LDFLAGS)   $^ -o $@ 

%.o : %.c
	$(CC) $(CFLAGS) -c $< -o $@

.PHONY: clean
clean:
	rm -f $(TARGET) *.a *.o *~

deploy:
	scp $(TARGET_PATH) $(SCP_PATH):$(CP_PATH) 

run:
	ssh $(SCP_PATH) $(TARGET_PATH)

test:
	echo $(CC) $(CFLAGS) -c $< -o $@