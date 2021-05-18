/**
  ******************************************************************************
  * @file stm8s_it.h
  * @author STMicroelectronics - MCD Application Team
  * @version V2.0.0
  * @date 15-March-2011
  * @brief This file contains the headers of the interrupt handlers
  ******************************************************************************
  * @attention
  *
  * THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
  * WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE
  * TIME. AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY
  * DIRECT, INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING
  * FROM THE CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THE
  * CODING INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
  *
  * <h2><center>&copy; COPYRIGHT 2011 STMicroelectronics</center></h2>
  ******************************************************************************
  */ 

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef SYSTEM_H
#define SYSTEM_H

/* Includes ------------------------------------------------------------------*/
#include "stm8s.h"

/* Exported types ------------------------------------------------------------*/
/* Exported constants --------------------------------------------------------*/
/* Exported macro ------------------------------------------------------------*/

#define CS_pin                                                GPIO_PIN_6
#define CS_port                                               GPIOC

#define Light_pin                                             GPIO_PIN_0
#define Light_port                                            GPIOD

struct mem_data
	{
	    uint16_t Commutation_Period;
	    uint16_t Duty_Cycle;
	    uint16_t Vsystem;
	    uint16_t Back_EMF_Rising;
	    uint16_t Back_EMF_Falling;
	    uint16_t UI_Speed;
	    uint16_t Analog_Slider;
	};
	
	//extern struct mem_data memData1;

/* Exported functions ------------------------------------------------------- */
#endif

/******************* (C) COPYRIGHT 2011 STMicroelectronics *****END OF FILE****/
