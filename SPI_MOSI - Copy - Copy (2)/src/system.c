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

/* Private defines -----------------------------------------------------------*/

#define CS_pin                                                GPIO_PIN_6
#define CS_port                                               GPIOC

#define Light_pin                                             GPIO_PIN_0
#define Light_port                                            GPIOD

void clock_setup(void);
void GPIO_setup(void);
void SPI_setup(void);

//void Write(unsigned char value);

uint8_t byte;

/* Private function prototypes -----------------------------------------------*/
/* Private functions ---------------------------------------------------------*/

void main(void)
{
	
	clock_setup();
	GPIO_setup();
	SPI_setup();
	enableInterrupts();
	
	
	
/* Infinite loop */
  while (1)
  {
		/*
      //GPIO_WriteLow(Light_port, Light_pin);
			if(SPI_GetFlagStatus(SPI_FLAG_RXNE) == 1) 
			{
				GPIO_WriteLow(Light_port, Light_pin);
				byte = SPI_ReceiveData();
		  }
			
			if (byte == 'a')
			{
				//GPIO_WriteLow(Light_port, Light_pin);
			}
			*/
  }
}

/*
void Write(unsigned char value)
{
    while(SPI_GetFlagStatus(SPI_FLAG_BSY));
    GPIO_WriteLow(CS_port, CS_pin);
                
    SPI_SendData(value);
    while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
                
    GPIO_WriteHigh(CS_port, CS_pin);
		GPIO_WriteLow(Light_port, Light_pin);
}
*/
void clock_setup(void)
{
     CLK_DeInit();
                
     CLK_HSECmd(DISABLE);
     CLK_LSICmd(DISABLE);
     CLK_HSICmd(ENABLE);
     while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
                
     CLK_ClockSwitchCmd(ENABLE);
     CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
     CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
                
     CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, 
     DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
                
     CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, ENABLE);
     CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
     CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, DISABLE);
     CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
     CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, DISABLE);
     CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
     CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, DISABLE);
     CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, DISABLE);
}
 
 
void GPIO_setup(void)
{
	
     GPIO_DeInit(GPIOC);
     GPIO_Init(GPIOC, ((GPIO_Pin_TypeDef)GPIO_PIN_5 | GPIO_PIN_6), 
               GPIO_MODE_OUT_PP_HIGH_FAST);
				
		 GPIO_DeInit(Light_port);		
		 GPIO_Init(Light_port, Light_pin, GPIO_MODE_OUT_PP_HIGH_FAST);
}
 
 
void SPI_setup(void)
{
     SPI_DeInit();
     SPI_Init(SPI_FIRSTBIT_MSB, 
              SPI_BAUDRATEPRESCALER_2, 
              SPI_MODE_SLAVE, 
              SPI_CLOCKPOLARITY_HIGH, 
              SPI_CLOCKPHASE_1EDGE, 
              SPI_DATADIRECTION_2LINES_FULLDUPLEX, 
              SPI_NSS_SOFT, 
              0x00);
		 SPI_ITConfig(SPI_IT_RXNE,ENABLE);
     SPI_Cmd(ENABLE);
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
