
/**
  ******************************************************************************
  * @file main.c
  * @brief This file contains the main function for this template.
  * @author STMicroelectronics - MCD Application Team
  * @version V2.0.0
  * @date 15-March-2011
  ******************************************************************************
  *
  * THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
  * WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE
  * TIME. AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY
  * DIRECT, INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING
  * FROM THE CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THE
  * CODING INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
  *
  * <h2><center>&copy; COPYRIGHT 2009 STMicroelectronics</center></h2>
  * @image html logo.bmp
  ******************************************************************************
  */


/* Includes ------------------------------------------------------------------*/
#include "stm8s.h"
#include "system.h"

/* Private defines -----------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/

void clock_setup(void);
void GPIO_setup(void);
void UART2_setup(void);
void innit_data(struct mem_data *);

void getData(struct data *, struct mem_data *);

void UARTsend(uint8_t);
void sendData(struct mem_data *);

struct data
{
    uint8_t SOF;
    uint16_t Commutation_Period;
    uint16_t Duty_Cycle;
    uint16_t Vsystem;
    uint16_t Back_EMF_Rising;
    uint16_t Back_EMF_Falling;
    uint16_t UI_Speed;
    uint16_t Analog_Slider;
};
	
	

static struct mem_data memData1 = {0,0,0,0,0,0,0};

//struct memData *memptr, memData1;

/* Private functions ---------------------------------------------------------*/

void main(void)
{
	struct mem_data *memptr = &memData1;

	clock_setup();
	GPIO_setup();
	UART2_setup();
	innit_data(memptr);
	
/* Infinite loop */
  while (1)
  {			
			sendData(memptr);
			memptr -> Commutation_Period++;
  }
}

void sendData(struct mem_data *memptr1)
{
    struct data *ptr, data1; //create data struct to send over UART
		uint16_t *ptr2;

		uint8_t i;
		uint8_t k;
		uint16_t value;
		
	  ptr = &data1;
		
    getData(ptr, memptr1); //fill data struct with motor data
		
		ptr2 = &data1.Commutation_Period; //pointer to the first index of data struct

    UARTsend(data1.SOF); //start of frame message. only works for 1 byte

    for(i = 0; i < sizeof(data1); i++) //index through struct
		{
			for(k = 0; k < sizeof(*ptr2); k++) // multi-byte message sending
			{
				value = (*ptr2);
				value >>= (8 *k);
				value &= 0xFF;
				UARTsend(value); 
			}
			ptr2++;
		}
		
}

void getData(struct data *ptr, struct mem_data *memptr)
{
    ptr -> SOF = 0xA5;
		ptr -> Commutation_Period = memptr -> Commutation_Period;
		ptr -> Duty_Cycle = memptr -> Duty_Cycle;
		ptr -> Vsystem = memptr -> Vsystem;
		ptr -> Back_EMF_Rising = memptr -> Back_EMF_Rising;
		ptr -> Back_EMF_Falling = memptr -> Back_EMF_Falling;
		ptr -> UI_Speed = memptr -> UI_Speed;
		ptr -> Analog_Slider = memptr -> Analog_Slider;
}

void UARTsend(uint8_t value)
{
    UART2_SendData8(value);
    while ( 0 == (UART2->SR & UART2_SR_TXE) );
}

void innit_data(struct mem_data *memptr)
{
		memptr -> Commutation_Period = 0x01;
		memptr -> Duty_Cycle = 0x02;
		memptr -> Vsystem = 0x03;
		memptr -> Back_EMF_Rising = 0x04;
		memptr -> Back_EMF_Falling = 0x05;
		memptr -> UI_Speed = 0x06;
		memptr -> Analog_Slider = 0x07;
	
}

void clock_setup(void)
{
     CLK_DeInit();
                
     CLK_HSECmd(DISABLE);
     CLK_LSICmd(DISABLE);
     CLK_HSICmd(ENABLE);
     while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
                
     CLK_ClockSwitchCmd(ENABLE);
     CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV2);
     CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
                
     CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, 
     DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
                
     CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, DISABLE);
     CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
     CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, DISABLE);
     CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
     CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART2, ENABLE);
     CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
     CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, DISABLE);
     CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, DISABLE);
}
 
 
void GPIO_setup(void)
{
	/*
     GPIO_DeInit(GPIOC);
     GPIO_Init(GPIOC, ((GPIO_Pin_TypeDef)GPIO_PIN_5 | GPIO_PIN_6), 
               GPIO_MODE_IN_FL_NO_IT); // GPIO_MODE_OUT_PP_HIGH_FAST);
							 
		 GPIO_DeInit(GPIOE);
     GPIO_Init(GPIOE, ((GPIO_Pin_TypeDef)GPIO_PIN_5), 
               GPIO_MODE_IN_FL_NO_IT); // GPIO_MODE_OUT_PP_HIGH_FAST);
		*/
     
		 GPIO_DeInit(GPIOD); 
		 //GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_OUT_PP_HIGH_FAST);
		 //GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_IN_PU_NO_IT);



		 //GPIO_DeInit(Light_port);		
		 GPIO_Init(Light_port, Light_pin, GPIO_MODE_OUT_PP_HIGH_FAST);
		 
		 GPIO_WriteLow(Light_port, Light_pin);

}

void UART2_setup(void) 
{ 
    UART2_DeInit();
		UART2_Init(38400, 
		           UART2_WORDLENGTH_8D, 
							 UART2_STOPBITS_1, 
							 UART2_PARITY_NO, 
							 UART2_SYNCMODE_CLOCK_DISABLE, 
							 UART2_MODE_TXRX_ENABLE); 
							 
		UART2_ITConfig(UART2_IT_RXNE, ENABLE); 
		enableInterrupts();
							 
		UART2_Cmd(ENABLE); 
}
 

#ifdef USE_FULL_ASSERT

/**
  * @brief  Reports the name of the source file and the source line number
  *   where the assert_param error has occurred.
  * @param file: pointer to the source file name
  * @param line: assert_param error line source number
  * @retval : None
  */
void assert_failed(u8* file, u32 line)
{ 
  /* User can add his own implementation to report the file name and line number,
     ex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */

  /* Infinite loop */
  while (1)
  {
  }
}
#endif

/******************* (C) COPYRIGHT 2009 STMicroelectronics *****END OF FILE****/
