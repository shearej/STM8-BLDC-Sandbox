   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.1 - 30 Jun 2020
   3                     ; Generator (Limited) V4.4.12 - 02 Jul 2020
   4                     ; Optimizer V4.4.12 - 02 Jul 2020
  48                     ; 46 INTERRUPT_HANDLER(NonHandledInterrupt, 25)
  48                     ; 47 {
  49                     	switch	.text
  50  0000               f_NonHandledInterrupt:
  54                     ; 51 }
  57  0000 80            	iret	
  79                     ; 59 INTERRUPT_HANDLER_TRAP(TRAP_IRQHandler)
  79                     ; 60 {
  80                     	switch	.text
  81  0001               f_TRAP_IRQHandler:
  85                     ; 64 }
  88  0001 80            	iret	
 110                     ; 70 INTERRUPT_HANDLER(TLI_IRQHandler, 0)
 110                     ; 71 {
 111                     	switch	.text
 112  0002               f_TLI_IRQHandler:
 116                     ; 75 }
 119  0002 80            	iret	
 141                     ; 82 INTERRUPT_HANDLER(AWU_IRQHandler, 1)
 141                     ; 83 {
 142                     	switch	.text
 143  0003               f_AWU_IRQHandler:
 147                     ; 87 }
 150  0003 80            	iret	
 172                     ; 94 INTERRUPT_HANDLER(CLK_IRQHandler, 2)
 172                     ; 95 {
 173                     	switch	.text
 174  0004               f_CLK_IRQHandler:
 178                     ; 99 }
 181  0004 80            	iret	
 204                     ; 106 INTERRUPT_HANDLER(EXTI_PORTA_IRQHandler, 3)
 204                     ; 107 {
 205                     	switch	.text
 206  0005               f_EXTI_PORTA_IRQHandler:
 210                     ; 111 }
 213  0005 80            	iret	
 236                     ; 118 INTERRUPT_HANDLER(EXTI_PORTB_IRQHandler, 4)
 236                     ; 119 {
 237                     	switch	.text
 238  0006               f_EXTI_PORTB_IRQHandler:
 242                     ; 123 }
 245  0006 80            	iret	
 268                     ; 130 INTERRUPT_HANDLER(EXTI_PORTC_IRQHandler, 5)
 268                     ; 131 {
 269                     	switch	.text
 270  0007               f_EXTI_PORTC_IRQHandler:
 274                     ; 135 }
 277  0007 80            	iret	
 300                     ; 142 INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6)
 300                     ; 143 {
 301                     	switch	.text
 302  0008               f_EXTI_PORTD_IRQHandler:
 306                     ; 147 }
 309  0008 80            	iret	
 332                     ; 154 INTERRUPT_HANDLER(EXTI_PORTE_IRQHandler, 7)
 332                     ; 155 {
 333                     	switch	.text
 334  0009               f_EXTI_PORTE_IRQHandler:
 338                     ; 159 }
 341  0009 80            	iret	
 363                     ; 205 INTERRUPT_HANDLER(SPI_IRQHandler, 10)
 363                     ; 206 {
 364                     	switch	.text
 365  000a               f_SPI_IRQHandler:
 369                     ; 213 }
 372  000a 80            	iret	
 395                     ; 220 INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11)
 395                     ; 221 {
 396                     	switch	.text
 397  000b               f_TIM1_UPD_OVF_TRG_BRK_IRQHandler:
 401                     ; 225 }
 404  000b 80            	iret	
 427                     ; 232 INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler, 12)
 427                     ; 233 {
 428                     	switch	.text
 429  000c               f_TIM1_CAP_COM_IRQHandler:
 433                     ; 237 }
 436  000c 80            	iret	
 459                     ; 269  INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
 459                     ; 270 {
 460                     	switch	.text
 461  000d               f_TIM2_UPD_OVF_BRK_IRQHandler:
 465                     ; 274 }
 468  000d 80            	iret	
 491                     ; 281  INTERRUPT_HANDLER(TIM2_CAP_COM_IRQHandler, 14)
 491                     ; 282 {
 492                     	switch	.text
 493  000e               f_TIM2_CAP_COM_IRQHandler:
 497                     ; 286 }
 500  000e 80            	iret	
 523                     ; 295  INTERRUPT_HANDLER(TIM3_UPD_OVF_BRK_IRQHandler, 15)
 523                     ; 296 {
 524                     	switch	.text
 525  000f               f_TIM3_UPD_OVF_BRK_IRQHandler:
 529                     ; 300 }
 532  000f 80            	iret	
 555                     ; 307  INTERRUPT_HANDLER(TIM3_CAP_COM_IRQHandler, 16)
 555                     ; 308 {
 556                     	switch	.text
 557  0010               f_TIM3_CAP_COM_IRQHandler:
 561                     ; 312 }
 564  0010 80            	iret	
 586                     ; 347 INTERRUPT_HANDLER(I2C_IRQHandler, 19)
 586                     ; 348 {
 587                     	switch	.text
 588  0011               f_I2C_IRQHandler:
 592                     ; 353 }
 595  0011 80            	iret	
 618                     ; 360  INTERRUPT_HANDLER(UART2_TX_IRQHandler, 20)
 618                     ; 361 {
 619                     	switch	.text
 620  0012               f_UART2_TX_IRQHandler:
 624                     ; 365   }
 627  0012 80            	iret	
 650                     ; 372  INTERRUPT_HANDLER(UART2_RX_IRQHandler, 21)
 650                     ; 373 {
 651                     	switch	.text
 652  0013               f_UART2_RX_IRQHandler:
 656                     ; 386   }
 659  0013 80            	iret	
 681                     ; 434  INTERRUPT_HANDLER(ADC1_IRQHandler, 22)
 681                     ; 435 {
 682                     	switch	.text
 683  0014               f_ADC1_IRQHandler:
 687                     ; 440 }
 690  0014 80            	iret	
 713                     ; 461  INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
 713                     ; 462 {
 714                     	switch	.text
 715  0015               f_TIM4_UPD_OVF_IRQHandler:
 719                     ; 466 }
 722  0015 80            	iret	
 745                     ; 474 INTERRUPT_HANDLER(EEPROM_EEC_IRQHandler, 24)
 745                     ; 475 {
 746                     	switch	.text
 747  0016               f_EEPROM_EEC_IRQHandler:
 751                     ; 479 }
 754  0016 80            	iret	
 766                     	xdef	f_EEPROM_EEC_IRQHandler
 767                     	xdef	f_TIM4_UPD_OVF_IRQHandler
 768                     	xdef	f_ADC1_IRQHandler
 769                     	xdef	f_UART2_TX_IRQHandler
 770                     	xdef	f_UART2_RX_IRQHandler
 771                     	xdef	f_I2C_IRQHandler
 772                     	xdef	f_TIM3_CAP_COM_IRQHandler
 773                     	xdef	f_TIM3_UPD_OVF_BRK_IRQHandler
 774                     	xdef	f_TIM2_CAP_COM_IRQHandler
 775                     	xdef	f_TIM2_UPD_OVF_BRK_IRQHandler
 776                     	xdef	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
 777                     	xdef	f_TIM1_CAP_COM_IRQHandler
 778                     	xdef	f_SPI_IRQHandler
 779                     	xdef	f_EXTI_PORTE_IRQHandler
 780                     	xdef	f_EXTI_PORTD_IRQHandler
 781                     	xdef	f_EXTI_PORTC_IRQHandler
 782                     	xdef	f_EXTI_PORTB_IRQHandler
 783                     	xdef	f_EXTI_PORTA_IRQHandler
 784                     	xdef	f_CLK_IRQHandler
 785                     	xdef	f_AWU_IRQHandler
 786                     	xdef	f_TLI_IRQHandler
 787                     	xdef	f_TRAP_IRQHandler
 788                     	xdef	f_NonHandledInterrupt
 807                     	end
