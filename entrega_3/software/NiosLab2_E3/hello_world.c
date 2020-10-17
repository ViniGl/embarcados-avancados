#include <stdio.h>
#include "system.h"
#include <alt_types.h>
#include <io.h> /* Leiutura e escrita no Avalon */

//#define SIM

// LED Peripheral
#define REG_DATA_OFFSET 1
#define REG_DATA_OFFSET_MOTOR 0
#define PERIPHERAL_MOTOR_0_BASE 0x81000
//#define PIO_1_BASE 0x81080

void init_motor(unsigned int *p_motor, int motor_offset){
	*(p_motor+REG_DATA_OFFSET_MOTOR) = (0x0);
}

void start_motor(unsigned int *p_motor, int motor_offset){

	*(p_motor+REG_DATA_OFFSET_MOTOR) = (0x1);
}

void stop_motor(unsigned int *p_motor, int motor_offset){

	*(p_motor+REG_DATA_OFFSET_MOTOR) = (0x0);
}

void change_dir(unsigned int *p_motor, int motor_offset){
	unsigned int mask = *(p_motor+REG_DATA_OFFSET_MOTOR) & 0x2;
	if (mask == 0){
		*(p_motor+REG_DATA_OFFSET_MOTOR) = (0x3);
	}
	else{
		*(p_motor+REG_DATA_OFFSET_MOTOR) = (0x1);
	}

}

int current_dir(unsigned int *p_motor, int motor_offset){

	return *(p_motor + motor_offset) & 0x2;
}

void set_speed(unsigned int *p_motor, int motor_offset, int speed){

	unsigned int dir = current_dir(p_motor, motor_offset);
	printf("%s", *(p_motor + motor_offset));
	switch (speed)
	{
	   case 0:
		   *(p_motor+REG_DATA_OFFSET_MOTOR) = (0x1) | dir;
		   break;

	   case 1:
		   *(p_motor+REG_DATA_OFFSET_MOTOR) = (0x5) | dir;
		   break;

	   case 2:
		   *(p_motor+REG_DATA_OFFSET_MOTOR) = (0x9) | dir;
		   break;

	   case 3:
		   *(p_motor+REG_DATA_OFFSET_MOTOR) = (0xD) | dir;
	}

}

int main(void){
  unsigned int led = 0;
  unsigned int *p_led = (unsigned int *) PERIPHERAL_LED_OK_0_BASE;
  unsigned int *p_motor = (unsigned int *) PERIPHERAL_MOTOR_0_BASE;

//  start_motor(p_motor, REG_DATA_OFFSET_MOTOR);
//  usleep(2000000);
//  change_dir(p_motor, 0);
//  usleep(2000000);
//  stop_motor(p_motor, 0);

  start_motor(p_motor, REG_DATA_OFFSET_MOTOR);
  usleep(2000000);
  set_speed(p_motor, 0 , 1);
  usleep(2000000);
  set_speed(p_motor, 0 , 2);
  usleep(2000000);
  set_speed(p_motor, 0 , 3);
  stop_motor(p_motor, REG_DATA_OFFSET_MOTOR);

  return 0;
}
