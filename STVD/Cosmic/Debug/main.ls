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
 148  0006 cd00ae        	call	_clock_setup
 150                     ; 65 	GPIO_setup();
 152  0009 cd010f        	call	_GPIO_setup
 154                     ; 66 	UART2_setup();
 156  000c cd012a        	call	_UART2_setup
 158                     ; 67 	innit_data(memptr);
 160  000f 1e01          	ldw	x,(OFST-1,sp)
 161  0011 ad7d          	call	_innit_data
 163  0013               L55:
 164                     ; 72 			sendData(memptr, 14);
 166  0013 4b0e          	push	#14
 167  0015 1e02          	ldw	x,(OFST+0,sp)
 168  0017 ad08          	call	_sendData
 170  0019 be00          	ldw	x,L3_memData1
 171  001b 5c            	incw	x
 172  001c bf00          	ldw	L3_memData1,x
 173  001e 84            	pop	a
 174                     ; 73 			memData1.Commutation_Period++;
 177  001f 20f2          	jra	L55
 331                     ; 77 void sendData(struct mem_data *memptr, uint8_t size)
 331                     ; 78 {
 332                     	switch	.text
 333  0021               _sendData:
 335  0021 89            	pushw	x
 336  0022 5213          	subw	sp,#19
 337       00000013      OFST:	set	19
 340                     ; 85 		SOF = 0xA5;
 342  0024 a6a5          	ld	a,#165
 343  0026 6b13          	ld	(OFST+0,sp),a
 345                     ; 87 	  ptr = &data1;
 347                     ; 88 		ptr2 = (uint8_t *)&data1;
 349  0028 96            	ldw	x,sp
 350  0029 1c0003        	addw	x,#OFST-16
 351  002c 1f11          	ldw	(OFST-2,sp),x
 353                     ; 90     getData(ptr, memptr); //fill data struct with motor data
 355  002e 1e14          	ldw	x,(OFST+1,sp)
 356  0030 89            	pushw	x
 357  0031 96            	ldw	x,sp
 358  0032 1c0005        	addw	x,#OFST-14
 359  0035 ad1c          	call	_getData
 361  0037 85            	popw	x
 362                     ; 92     UARTsend(SOF); //start of frame message
 364  0038 7b13          	ld	a,(OFST+0,sp)
 365  003a ad4b          	call	_UARTsend
 367                     ; 94     for(i=0; i < size; i++)
 369  003c 0f13          	clr	(OFST+0,sp)
 372  003e 200a          	jra	L161
 373  0040               L551:
 374                     ; 96 		    UARTsend(*(ptr2 + i));
 376  0040 5f            	clrw	x
 377  0041 97            	ld	xl,a
 378  0042 72fb11        	addw	x,(OFST-2,sp)
 379  0045 f6            	ld	a,(x)
 380  0046 ad3f          	call	_UARTsend
 382                     ; 94     for(i=0; i < size; i++)
 384  0048 0c13          	inc	(OFST+0,sp)
 386  004a               L161:
 389  004a 7b13          	ld	a,(OFST+0,sp)
 390  004c 1118          	cp	a,(OFST+5,sp)
 391  004e 25f0          	jrult	L551
 392                     ; 99 }
 395  0050 5b15          	addw	sp,#21
 396  0052 81            	ret	
 445                     ; 101 void getData(struct data *ptr, struct mem_data *memptr)
 445                     ; 102 {
 446                     	switch	.text
 447  0053               _getData:
 449  0053 89            	pushw	x
 450       00000000      OFST:	set	0
 453                     ; 103 		ptr -> Commutation_Period = memptr -> Commutation_Period;
 455  0054 1e05          	ldw	x,(OFST+5,sp)
 456  0056 1601          	ldw	y,(OFST+1,sp)
 457  0058 fe            	ldw	x,(x)
 458  0059 90ff          	ldw	(y),x
 459                     ; 104 		ptr -> Duty_Cycle = memptr -> Duty_Cycle;
 461  005b 1e05          	ldw	x,(OFST+5,sp)
 462  005d ee02          	ldw	x,(2,x)
 463  005f 90ef02        	ldw	(2,y),x
 464                     ; 105 		ptr -> Vsystem = memptr -> Vsystem;
 466  0062 1e05          	ldw	x,(OFST+5,sp)
 467  0064 ee04          	ldw	x,(4,x)
 468  0066 90ef04        	ldw	(4,y),x
 469                     ; 106 		ptr -> Back_EMF_Rising = memptr -> Back_EMF_Rising;
 471  0069 1e05          	ldw	x,(OFST+5,sp)
 472  006b ee06          	ldw	x,(6,x)
 473  006d 90ef06        	ldw	(6,y),x
 474                     ; 107 		ptr -> Back_EMF_Falling = memptr -> Back_EMF_Falling;
 476  0070 1e05          	ldw	x,(OFST+5,sp)
 477  0072 ee08          	ldw	x,(8,x)
 478  0074 90ef08        	ldw	(8,y),x
 479                     ; 108 		ptr -> UI_Speed = memptr -> UI_Speed;
 481  0077 1e05          	ldw	x,(OFST+5,sp)
 482  0079 ee0a          	ldw	x,(10,x)
 483  007b 90ef0a        	ldw	(10,y),x
 484                     ; 109 		ptr -> Analog_Slider = memptr -> Analog_Slider;
 486  007e 1e05          	ldw	x,(OFST+5,sp)
 487  0080 ee0c          	ldw	x,(12,x)
 488  0082 90ef0c        	ldw	(12,y),x
 489                     ; 110 }
 492  0085 85            	popw	x
 493  0086 81            	ret	
 528                     ; 112 void UARTsend(uint8_t value)
 528                     ; 113 {
 529                     	switch	.text
 530  0087               _UARTsend:
 534                     ; 114     UART2_SendData8(value);
 536  0087 cd0000        	call	_UART2_SendData8
 539  008a               L332:
 540                     ; 115     while ( 0 == (UART2->SR & UART2_SR_TXE) );
 542  008a 720f5240fb    	btjf	21056,#7,L332
 543                     ; 116 }
 546  008f 81            	ret	
 583                     ; 118 void innit_data(struct mem_data *memptr)
 583                     ; 119 {
 584                     	switch	.text
 585  0090               _innit_data:
 589                     ; 120 		memptr -> Commutation_Period = 0x01;
 591  0090 90ae0001      	ldw	y,#1
 592  0094 ff            	ldw	(x),y
 593                     ; 121 		memptr -> Duty_Cycle = 0x02;
 595  0095 905c          	incw	y
 596  0097 ef02          	ldw	(2,x),y
 597                     ; 122 		memptr -> Vsystem = 0x03;
 599  0099 905c          	incw	y
 600  009b ef04          	ldw	(4,x),y
 601                     ; 123 		memptr -> Back_EMF_Rising = 0x04;
 603  009d 905c          	incw	y
 604  009f ef06          	ldw	(6,x),y
 605                     ; 124 		memptr -> Back_EMF_Falling = 0x05;
 607  00a1 905c          	incw	y
 608  00a3 ef08          	ldw	(8,x),y
 609                     ; 125 		memptr -> UI_Speed = 0x06;
 611  00a5 905c          	incw	y
 612  00a7 ef0a          	ldw	(10,x),y
 613                     ; 126 		memptr -> Analog_Slider = 0x07;
 615  00a9 905c          	incw	y
 616  00ab ef0c          	ldw	(12,x),y
 617                     ; 128 }
 620  00ad 81            	ret	
 653                     ; 130 void clock_setup(void)
 653                     ; 131 {
 654                     	switch	.text
 655  00ae               _clock_setup:
 659                     ; 132      CLK_DeInit();
 661  00ae cd0000        	call	_CLK_DeInit
 663                     ; 134      CLK_HSECmd(DISABLE);
 665  00b1 4f            	clr	a
 666  00b2 cd0000        	call	_CLK_HSECmd
 668                     ; 135      CLK_LSICmd(DISABLE);
 670  00b5 4f            	clr	a
 671  00b6 cd0000        	call	_CLK_LSICmd
 673                     ; 136      CLK_HSICmd(ENABLE);
 675  00b9 a601          	ld	a,#1
 676  00bb cd0000        	call	_CLK_HSICmd
 679  00be               L172:
 680                     ; 137      while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
 682  00be ae0102        	ldw	x,#258
 683  00c1 cd0000        	call	_CLK_GetFlagStatus
 685  00c4 4d            	tnz	a
 686  00c5 27f7          	jreq	L172
 687                     ; 139      CLK_ClockSwitchCmd(ENABLE);
 689  00c7 a601          	ld	a,#1
 690  00c9 cd0000        	call	_CLK_ClockSwitchCmd
 692                     ; 140      CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV2);
 694  00cc a608          	ld	a,#8
 695  00ce cd0000        	call	_CLK_HSIPrescalerConfig
 697                     ; 141      CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
 699  00d1 a680          	ld	a,#128
 700  00d3 cd0000        	call	_CLK_SYSCLKConfig
 702                     ; 143      CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, 
 702                     ; 144      DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
 704  00d6 4b01          	push	#1
 705  00d8 4b00          	push	#0
 706  00da ae01e1        	ldw	x,#481
 707  00dd cd0000        	call	_CLK_ClockSwitchConfig
 709  00e0 85            	popw	x
 710                     ; 146      CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, DISABLE);
 712  00e1 ae0100        	ldw	x,#256
 713  00e4 cd0000        	call	_CLK_PeripheralClockConfig
 715                     ; 147      CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
 717  00e7 5f            	clrw	x
 718  00e8 cd0000        	call	_CLK_PeripheralClockConfig
 720                     ; 148      CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, DISABLE);
 722  00eb ae1300        	ldw	x,#4864
 723  00ee cd0000        	call	_CLK_PeripheralClockConfig
 725                     ; 149      CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
 727  00f1 ae1200        	ldw	x,#4608
 728  00f4 cd0000        	call	_CLK_PeripheralClockConfig
 730                     ; 150      CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART2, ENABLE);
 732  00f7 ae0301        	ldw	x,#769
 733  00fa cd0000        	call	_CLK_PeripheralClockConfig
 735                     ; 151      CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
 737  00fd ae0700        	ldw	x,#1792
 738  0100 cd0000        	call	_CLK_PeripheralClockConfig
 740                     ; 152      CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, DISABLE);
 742  0103 ae0500        	ldw	x,#1280
 743  0106 cd0000        	call	_CLK_PeripheralClockConfig
 745                     ; 153      CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, DISABLE);
 747  0109 ae0400        	ldw	x,#1024
 749                     ; 154 }
 752  010c cc0000        	jp	_CLK_PeripheralClockConfig
 778                     ; 157 void GPIO_setup(void)
 778                     ; 158 {
 779                     	switch	.text
 780  010f               _GPIO_setup:
 784                     ; 169 		 GPIO_DeInit(GPIOD); 
 786  010f ae500f        	ldw	x,#20495
 787  0112 cd0000        	call	_GPIO_DeInit
 789                     ; 176 		 GPIO_Init(Light_port, Light_pin, GPIO_MODE_OUT_PP_HIGH_FAST);
 791  0115 4bf0          	push	#240
 792  0117 4b01          	push	#1
 793  0119 ae500f        	ldw	x,#20495
 794  011c cd0000        	call	_GPIO_Init
 796  011f 85            	popw	x
 797                     ; 178 		 GPIO_WriteLow(Light_port, Light_pin);
 799  0120 4b01          	push	#1
 800  0122 ae500f        	ldw	x,#20495
 801  0125 cd0000        	call	_GPIO_WriteLow
 803  0128 84            	pop	a
 804                     ; 180 }
 807  0129 81            	ret	
 835                     ; 182 void UART2_setup(void) 
 835                     ; 183 { 
 836                     	switch	.text
 837  012a               _UART2_setup:
 841                     ; 184     UART2_DeInit();
 843  012a cd0000        	call	_UART2_DeInit
 845                     ; 185 		UART2_Init(38400, 
 845                     ; 186 		           UART2_WORDLENGTH_8D, 
 845                     ; 187 							 UART2_STOPBITS_1, 
 845                     ; 188 							 UART2_PARITY_NO, 
 845                     ; 189 							 UART2_SYNCMODE_CLOCK_DISABLE, 
 845                     ; 190 							 UART2_MODE_TXRX_ENABLE); 
 847  012d 4b0c          	push	#12
 848  012f 4b80          	push	#128
 849  0131 4b00          	push	#0
 850  0133 4b00          	push	#0
 851  0135 4b00          	push	#0
 852  0137 ae9600        	ldw	x,#38400
 853  013a 89            	pushw	x
 854  013b 5f            	clrw	x
 855  013c 89            	pushw	x
 856  013d cd0000        	call	_UART2_Init
 858  0140 5b09          	addw	sp,#9
 859                     ; 192 		UART2_ITConfig(UART2_IT_RXNE, ENABLE); 
 861  0142 4b01          	push	#1
 862  0144 ae0255        	ldw	x,#597
 863  0147 cd0000        	call	_UART2_ITConfig
 865  014a 9a            	rim	
 866  014b 84            	pop	a
 867                     ; 193 		enableInterrupts();
 871                     ; 195 		UART2_Cmd(ENABLE); 
 874  014c a601          	ld	a,#1
 876                     ; 196 }
 879  014e cc0000        	jp	_UART2_Cmd
 904                     	xdef	_main
 905                     	xdef	_sendData
 906                     	xdef	_UARTsend
 907                     	xdef	_getData
 908                     	xdef	_innit_data
 909                     	xdef	_UART2_setup
 910                     	xdef	_GPIO_setup
 911                     	xdef	_clock_setup
 912                     	xref	_UART2_SendData8
 913                     	xref	_UART2_ITConfig
 914                     	xref	_UART2_Cmd
 915                     	xref	_UART2_Init
 916                     	xref	_UART2_DeInit
 917                     	xref	_GPIO_WriteLow
 918                     	xref	_GPIO_Init
 919                     	xref	_GPIO_DeInit
 920                     	xref	_CLK_GetFlagStatus
 921                     	xref	_CLK_SYSCLKConfig
 922                     	xref	_CLK_HSIPrescalerConfig
 923                     	xref	_CLK_ClockSwitchConfig
 924                     	xref	_CLK_PeripheralClockConfig
 925                     	xref	_CLK_ClockSwitchCmd
 926                     	xref	_CLK_LSICmd
 927                     	xref	_CLK_HSICmd
 928                     	xref	_CLK_HSECmd
 929                     	xref	_CLK_DeInit
 948                     	end
