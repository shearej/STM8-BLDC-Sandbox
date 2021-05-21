   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.1 - 30 Jun 2020
   3                     ; Generator (Limited) V4.4.12 - 02 Jul 2020
   4                     ; Optimizer V4.4.12 - 02 Jul 2020
  19                     	bsct
  20  0000               L3_memData1:
  21  0000 0000          	dc.w	0
  22  0002 0000          	dc.w	0
  23  0004 0000          	dc.w	0
  24  0006 0000          	dc.w	0
  25  0008 0000          	dc.w	0
  26  000a 0000          	dc.w	0
  27  000c 0000          	dc.w	0
 132                     ; 60 void main(void)
 132                     ; 61 {
 134                     	switch	.text
 135  0000               _main:
 137  0000 89            	pushw	x
 138       00000002      OFST:	set	2
 141                     ; 62 	struct mem_data *memptr = &memData1;
 143  0001 ae0000        	ldw	x,#L3_memData1
 144  0004 1f01          	ldw	(OFST-1,sp),x
 146                     ; 64 	clock_setup();
 148  0006 cd00b1        	call	_clock_setup
 150                     ; 65 	GPIO_setup();
 152  0009 cd0112        	call	_GPIO_setup
 154                     ; 66 	UART2_setup();
 156  000c cd012d        	call	_UART2_setup
 158                     ; 67 	innit_data(memptr);
 160  000f 1e01          	ldw	x,(OFST-1,sp)
 161  0011 cd0093        	call	_innit_data
 163  0014               L55:
 164                     ; 72 			sendData(memptr, 14);
 166  0014 4b0e          	push	#14
 167  0016 1e02          	ldw	x,(OFST+0,sp)
 168  0018 ad08          	call	_sendData
 170  001a be00          	ldw	x,L3_memData1
 171  001c 5c            	incw	x
 172  001d bf00          	ldw	L3_memData1,x
 173  001f 84            	pop	a
 174                     ; 73 			memData1.Commutation_Period++;
 177  0020 20f2          	jra	L55
 331                     ; 77 void sendData(struct mem_data *memptr, uint8_t size)
 331                     ; 78 {
 332                     	switch	.text
 333  0022               _sendData:
 335  0022 89            	pushw	x
 336  0023 5213          	subw	sp,#19
 337       00000013      OFST:	set	19
 340                     ; 85 		SOF = 0xA5;
 342  0025 a6a5          	ld	a,#165
 343  0027 6b13          	ld	(OFST+0,sp),a
 345                     ; 87 	  ptr = &data1;
 347                     ; 88 		ptr2 = (uint8_t *)&data1;
 349  0029 96            	ldw	x,sp
 350  002a 1c0003        	addw	x,#OFST-16
 351  002d 1f11          	ldw	(OFST-2,sp),x
 353                     ; 90     getData(ptr, memptr); //fill data struct with motor data
 355  002f 1e14          	ldw	x,(OFST+1,sp)
 356  0031 89            	pushw	x
 357  0032 96            	ldw	x,sp
 358  0033 1c0005        	addw	x,#OFST-14
 359  0036 ad1e          	call	_getData
 361  0038 85            	popw	x
 362                     ; 92     UARTsend(SOF); //start of frame message
 364  0039 7b13          	ld	a,(OFST+0,sp)
 365  003b ad4d          	call	_UARTsend
 367                     ; 94     for(i=0; i < size; i++)
 369  003d 0f13          	clr	(OFST+0,sp)
 372  003f 200c          	jra	L161
 373  0041               L551:
 374                     ; 96 		    UARTsend((*ptr2));
 376  0041 1e11          	ldw	x,(OFST-2,sp)
 377  0043 f6            	ld	a,(x)
 378  0044 ad44          	call	_UARTsend
 380                     ; 97 		    ptr2++;
 382  0046 1e11          	ldw	x,(OFST-2,sp)
 383  0048 5c            	incw	x
 384  0049 1f11          	ldw	(OFST-2,sp),x
 386                     ; 94     for(i=0; i < size; i++)
 388  004b 0c13          	inc	(OFST+0,sp)
 390  004d               L161:
 393  004d 7b13          	ld	a,(OFST+0,sp)
 394  004f 1118          	cp	a,(OFST+5,sp)
 395  0051 25ee          	jrult	L551
 396                     ; 100 }
 399  0053 5b15          	addw	sp,#21
 400  0055 81            	ret	
 449                     ; 102 void getData(struct data *ptr, struct mem_data *memptr)
 449                     ; 103 {
 450                     	switch	.text
 451  0056               _getData:
 453  0056 89            	pushw	x
 454       00000000      OFST:	set	0
 457                     ; 104 		ptr -> Commutation_Period = memptr -> Commutation_Period;
 459  0057 1e05          	ldw	x,(OFST+5,sp)
 460  0059 1601          	ldw	y,(OFST+1,sp)
 461  005b fe            	ldw	x,(x)
 462  005c 90ff          	ldw	(y),x
 463                     ; 105 		ptr -> Duty_Cycle = memptr -> Duty_Cycle;
 465  005e 1e05          	ldw	x,(OFST+5,sp)
 466  0060 ee02          	ldw	x,(2,x)
 467  0062 90ef02        	ldw	(2,y),x
 468                     ; 106 		ptr -> Vsystem = memptr -> Vsystem;
 470  0065 1e05          	ldw	x,(OFST+5,sp)
 471  0067 ee04          	ldw	x,(4,x)
 472  0069 90ef04        	ldw	(4,y),x
 473                     ; 107 		ptr -> Back_EMF_Rising = memptr -> Back_EMF_Rising;
 475  006c 1e05          	ldw	x,(OFST+5,sp)
 476  006e ee06          	ldw	x,(6,x)
 477  0070 90ef06        	ldw	(6,y),x
 478                     ; 108 		ptr -> Back_EMF_Falling = memptr -> Back_EMF_Falling;
 480  0073 1e05          	ldw	x,(OFST+5,sp)
 481  0075 ee08          	ldw	x,(8,x)
 482  0077 90ef08        	ldw	(8,y),x
 483                     ; 109 		ptr -> UI_Speed = memptr -> UI_Speed;
 485  007a 1e05          	ldw	x,(OFST+5,sp)
 486  007c ee0a          	ldw	x,(10,x)
 487  007e 90ef0a        	ldw	(10,y),x
 488                     ; 110 		ptr -> Analog_Slider = memptr -> Analog_Slider;
 490  0081 1e05          	ldw	x,(OFST+5,sp)
 491  0083 ee0c          	ldw	x,(12,x)
 492  0085 90ef0c        	ldw	(12,y),x
 493                     ; 111 }
 496  0088 85            	popw	x
 497  0089 81            	ret	
 532                     ; 113 void UARTsend(uint8_t value)
 532                     ; 114 {
 533                     	switch	.text
 534  008a               _UARTsend:
 538                     ; 115     UART2_SendData8(value);
 540  008a cd0000        	call	_UART2_SendData8
 543  008d               L332:
 544                     ; 116     while ( 0 == (UART2->SR & UART2_SR_TXE) );
 546  008d 720f5240fb    	btjf	21056,#7,L332
 547                     ; 117 }
 550  0092 81            	ret	
 587                     ; 119 void innit_data(struct mem_data *memptr)
 587                     ; 120 {
 588                     	switch	.text
 589  0093               _innit_data:
 593                     ; 121 		memptr -> Commutation_Period = 0x01;
 595  0093 90ae0001      	ldw	y,#1
 596  0097 ff            	ldw	(x),y
 597                     ; 122 		memptr -> Duty_Cycle = 0x02;
 599  0098 905c          	incw	y
 600  009a ef02          	ldw	(2,x),y
 601                     ; 123 		memptr -> Vsystem = 0x03;
 603  009c 905c          	incw	y
 604  009e ef04          	ldw	(4,x),y
 605                     ; 124 		memptr -> Back_EMF_Rising = 0x04;
 607  00a0 905c          	incw	y
 608  00a2 ef06          	ldw	(6,x),y
 609                     ; 125 		memptr -> Back_EMF_Falling = 0x05;
 611  00a4 905c          	incw	y
 612  00a6 ef08          	ldw	(8,x),y
 613                     ; 126 		memptr -> UI_Speed = 0x06;
 615  00a8 905c          	incw	y
 616  00aa ef0a          	ldw	(10,x),y
 617                     ; 127 		memptr -> Analog_Slider = 0x07;
 619  00ac 905c          	incw	y
 620  00ae ef0c          	ldw	(12,x),y
 621                     ; 129 }
 624  00b0 81            	ret	
 657                     ; 131 void clock_setup(void)
 657                     ; 132 {
 658                     	switch	.text
 659  00b1               _clock_setup:
 663                     ; 133      CLK_DeInit();
 665  00b1 cd0000        	call	_CLK_DeInit
 667                     ; 135      CLK_HSECmd(DISABLE);
 669  00b4 4f            	clr	a
 670  00b5 cd0000        	call	_CLK_HSECmd
 672                     ; 136      CLK_LSICmd(DISABLE);
 674  00b8 4f            	clr	a
 675  00b9 cd0000        	call	_CLK_LSICmd
 677                     ; 137      CLK_HSICmd(ENABLE);
 679  00bc a601          	ld	a,#1
 680  00be cd0000        	call	_CLK_HSICmd
 683  00c1               L172:
 684                     ; 138      while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
 686  00c1 ae0102        	ldw	x,#258
 687  00c4 cd0000        	call	_CLK_GetFlagStatus
 689  00c7 4d            	tnz	a
 690  00c8 27f7          	jreq	L172
 691                     ; 140      CLK_ClockSwitchCmd(ENABLE);
 693  00ca a601          	ld	a,#1
 694  00cc cd0000        	call	_CLK_ClockSwitchCmd
 696                     ; 141      CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV2);
 698  00cf a608          	ld	a,#8
 699  00d1 cd0000        	call	_CLK_HSIPrescalerConfig
 701                     ; 142      CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
 703  00d4 a680          	ld	a,#128
 704  00d6 cd0000        	call	_CLK_SYSCLKConfig
 706                     ; 144      CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, 
 706                     ; 145      DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
 708  00d9 4b01          	push	#1
 709  00db 4b00          	push	#0
 710  00dd ae01e1        	ldw	x,#481
 711  00e0 cd0000        	call	_CLK_ClockSwitchConfig
 713  00e3 85            	popw	x
 714                     ; 147      CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, DISABLE);
 716  00e4 ae0100        	ldw	x,#256
 717  00e7 cd0000        	call	_CLK_PeripheralClockConfig
 719                     ; 148      CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
 721  00ea 5f            	clrw	x
 722  00eb cd0000        	call	_CLK_PeripheralClockConfig
 724                     ; 149      CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, DISABLE);
 726  00ee ae1300        	ldw	x,#4864
 727  00f1 cd0000        	call	_CLK_PeripheralClockConfig
 729                     ; 150      CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
 731  00f4 ae1200        	ldw	x,#4608
 732  00f7 cd0000        	call	_CLK_PeripheralClockConfig
 734                     ; 151      CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART2, ENABLE);
 736  00fa ae0301        	ldw	x,#769
 737  00fd cd0000        	call	_CLK_PeripheralClockConfig
 739                     ; 152      CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
 741  0100 ae0700        	ldw	x,#1792
 742  0103 cd0000        	call	_CLK_PeripheralClockConfig
 744                     ; 153      CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, DISABLE);
 746  0106 ae0500        	ldw	x,#1280
 747  0109 cd0000        	call	_CLK_PeripheralClockConfig
 749                     ; 154      CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, DISABLE);
 751  010c ae0400        	ldw	x,#1024
 753                     ; 155 }
 756  010f cc0000        	jp	_CLK_PeripheralClockConfig
 782                     ; 158 void GPIO_setup(void)
 782                     ; 159 {
 783                     	switch	.text
 784  0112               _GPIO_setup:
 788                     ; 170 		 GPIO_DeInit(GPIOD); 
 790  0112 ae500f        	ldw	x,#20495
 791  0115 cd0000        	call	_GPIO_DeInit
 793                     ; 177 		 GPIO_Init(Light_port, Light_pin, GPIO_MODE_OUT_PP_HIGH_FAST);
 795  0118 4bf0          	push	#240
 796  011a 4b01          	push	#1
 797  011c ae500f        	ldw	x,#20495
 798  011f cd0000        	call	_GPIO_Init
 800  0122 85            	popw	x
 801                     ; 179 		 GPIO_WriteLow(Light_port, Light_pin);
 803  0123 4b01          	push	#1
 804  0125 ae500f        	ldw	x,#20495
 805  0128 cd0000        	call	_GPIO_WriteLow
 807  012b 84            	pop	a
 808                     ; 181 }
 811  012c 81            	ret	
 839                     ; 183 void UART2_setup(void) 
 839                     ; 184 { 
 840                     	switch	.text
 841  012d               _UART2_setup:
 845                     ; 185     UART2_DeInit();
 847  012d cd0000        	call	_UART2_DeInit
 849                     ; 186 		UART2_Init(38400, 
 849                     ; 187 		           UART2_WORDLENGTH_8D, 
 849                     ; 188 							 UART2_STOPBITS_1, 
 849                     ; 189 							 UART2_PARITY_NO, 
 849                     ; 190 							 UART2_SYNCMODE_CLOCK_DISABLE, 
 849                     ; 191 							 UART2_MODE_TXRX_ENABLE); 
 851  0130 4b0c          	push	#12
 852  0132 4b80          	push	#128
 853  0134 4b00          	push	#0
 854  0136 4b00          	push	#0
 855  0138 4b00          	push	#0
 856  013a ae9600        	ldw	x,#38400
 857  013d 89            	pushw	x
 858  013e 5f            	clrw	x
 859  013f 89            	pushw	x
 860  0140 cd0000        	call	_UART2_Init
 862  0143 5b09          	addw	sp,#9
 863                     ; 193 		UART2_ITConfig(UART2_IT_RXNE, ENABLE); 
 865  0145 4b01          	push	#1
 866  0147 ae0255        	ldw	x,#597
 867  014a cd0000        	call	_UART2_ITConfig
 869  014d 9a            	rim	
 870  014e 84            	pop	a
 871                     ; 194 		enableInterrupts();
 875                     ; 196 		UART2_Cmd(ENABLE); 
 878  014f a601          	ld	a,#1
 880                     ; 197 }
 883  0151 cc0000        	jp	_UART2_Cmd
 908                     	xdef	_main
 909                     	xdef	_sendData
 910                     	xdef	_UARTsend
 911                     	xdef	_getData
 912                     	xdef	_innit_data
 913                     	xdef	_UART2_setup
 914                     	xdef	_GPIO_setup
 915                     	xdef	_clock_setup
 916                     	xref	_UART2_SendData8
 917                     	xref	_UART2_ITConfig
 918                     	xref	_UART2_Cmd
 919                     	xref	_UART2_Init
 920                     	xref	_UART2_DeInit
 921                     	xref	_GPIO_WriteLow
 922                     	xref	_GPIO_Init
 923                     	xref	_GPIO_DeInit
 924                     	xref	_CLK_GetFlagStatus
 925                     	xref	_CLK_SYSCLKConfig
 926                     	xref	_CLK_HSIPrescalerConfig
 927                     	xref	_CLK_ClockSwitchConfig
 928                     	xref	_CLK_PeripheralClockConfig
 929                     	xref	_CLK_ClockSwitchCmd
 930                     	xref	_CLK_LSICmd
 931                     	xref	_CLK_HSICmd
 932                     	xref	_CLK_HSECmd
 933                     	xref	_CLK_DeInit
 952                     	end
