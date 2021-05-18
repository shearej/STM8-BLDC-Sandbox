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
 148  0006 cd00d0        	call	_clock_setup
 150                     ; 65 	GPIO_setup();
 152  0009 cd0131        	call	_GPIO_setup
 154                     ; 66 	UART2_setup();
 156  000c cd014c        	call	_UART2_setup
 158                     ; 67 	innit_data(memptr);
 160  000f 1e01          	ldw	x,(OFST-1,sp)
 161  0011 cd00b2        	call	_innit_data
 163  0014               L55:
 164                     ; 72 			sendData(memptr);
 166  0014 1e01          	ldw	x,(OFST-1,sp)
 167  0016 ad07          	call	_sendData
 169                     ; 74 			memData1.Commutation_Period++;
 171  0018 be00          	ldw	x,L3_memData1
 172  001a 5c            	incw	x
 173  001b bf00          	ldw	L3_memData1,x
 175  001d 20f5          	jra	L55
 338                     ; 78 void sendData(struct mem_data *memptr1)
 338                     ; 79 {
 339                     	switch	.text
 340  001f               _sendData:
 342  001f 5216          	subw	sp,#22
 343       00000016      OFST:	set	22
 346                     ; 88 		SOF = 0xA5;
 348  0021 a6a5          	ld	a,#165
 349  0023 6b11          	ld	(OFST-5,sp),a
 351                     ; 90 	  ptr = &data1;
 353                     ; 92     getData(ptr, memptr1); //fill data struct with motor data
 355  0025 89            	pushw	x
 356  0026 96            	ldw	x,sp
 357  0027 1c0005        	addw	x,#OFST-17
 358  002a ad49          	call	_getData
 360  002c 85            	popw	x
 361                     ; 94 		ptr2 = &data1.Commutation_Period; //pointer to the first index of data struct
 363  002d 96            	ldw	x,sp
 364  002e 1c0003        	addw	x,#OFST-19
 365  0031 1f12          	ldw	(OFST-4,sp),x
 367                     ; 96     UARTsend(SOF); //start of frame message. only works for 1 byte
 369  0033 7b11          	ld	a,(OFST-5,sp)
 370  0035 ad72          	call	_UARTsend
 372                     ; 98     for(i = 0; i < sizeof(data1); i++) //index through struct
 374  0037 0f11          	clr	(OFST-5,sp)
 376  0039               L161:
 377                     ; 100 			for(k = 0; k < sizeof(*ptr2); k++) // multi-byte message sending
 379  0039 0f14          	clr	(OFST-2,sp)
 381  003b               L761:
 382                     ; 102 				value = (*ptr2);
 384  003b 1e12          	ldw	x,(OFST-4,sp)
 385  003d fe            	ldw	x,(x)
 386  003e 1f15          	ldw	(OFST-1,sp),x
 388                     ; 103 				value >>= (8 *k);
 390  0040 905f          	clrw	y
 391  0042 7b14          	ld	a,(OFST-2,sp)
 392  0044 9097          	ld	yl,a
 393  0046 9058          	sllw	y
 394  0048 9058          	sllw	y
 395  004a 9058          	sllw	y
 396  004c 2705          	jreq	L62
 397  004e               L03:
 398  004e 54            	srlw	x
 399  004f 905a          	decw	y
 400  0051 26fb          	jrne	L03
 401  0053               L62:
 402  0053 1f15          	ldw	(OFST-1,sp),x
 404                     ; 104 				value &= 0xFF;
 406  0055 0f15          	clr	(OFST-1,sp)
 408                     ; 105 				UARTsend(value); 
 410  0057 7b16          	ld	a,(OFST+0,sp)
 411  0059 ad4e          	call	_UARTsend
 413                     ; 100 			for(k = 0; k < sizeof(*ptr2); k++) // multi-byte message sending
 415  005b 0c14          	inc	(OFST-2,sp)
 419  005d 7b14          	ld	a,(OFST-2,sp)
 420  005f a102          	cp	a,#2
 421  0061 25d8          	jrult	L761
 422                     ; 107 			ptr2++;
 424  0063 1e12          	ldw	x,(OFST-4,sp)
 425  0065 1c0002        	addw	x,#2
 426  0068 1f12          	ldw	(OFST-4,sp),x
 428                     ; 98     for(i = 0; i < sizeof(data1); i++) //index through struct
 430  006a 0c11          	inc	(OFST-5,sp)
 434  006c 7b11          	ld	a,(OFST-5,sp)
 435  006e a10e          	cp	a,#14
 436  0070 25c7          	jrult	L161
 437                     ; 110 }
 440  0072 5b16          	addw	sp,#22
 441  0074 81            	ret	
 490                     ; 112 void getData(struct data *ptr, struct mem_data *memptr)
 490                     ; 113 {
 491                     	switch	.text
 492  0075               _getData:
 494  0075 89            	pushw	x
 495       00000000      OFST:	set	0
 498                     ; 114 		ptr -> Commutation_Period = memptr -> Commutation_Period;
 500  0076 1e05          	ldw	x,(OFST+5,sp)
 501  0078 1601          	ldw	y,(OFST+1,sp)
 502  007a fe            	ldw	x,(x)
 503  007b 90ff          	ldw	(y),x
 504                     ; 115 		ptr -> Duty_Cycle = memptr -> Duty_Cycle;
 506  007d 1e05          	ldw	x,(OFST+5,sp)
 507  007f ee02          	ldw	x,(2,x)
 508  0081 90ef02        	ldw	(2,y),x
 509                     ; 116 		ptr -> Vsystem = memptr -> Vsystem;
 511  0084 1e05          	ldw	x,(OFST+5,sp)
 512  0086 ee04          	ldw	x,(4,x)
 513  0088 90ef04        	ldw	(4,y),x
 514                     ; 117 		ptr -> Back_EMF_Rising = memptr -> Back_EMF_Rising;
 516  008b 1e05          	ldw	x,(OFST+5,sp)
 517  008d ee06          	ldw	x,(6,x)
 518  008f 90ef06        	ldw	(6,y),x
 519                     ; 118 		ptr -> Back_EMF_Falling = memptr -> Back_EMF_Falling;
 521  0092 1e05          	ldw	x,(OFST+5,sp)
 522  0094 ee08          	ldw	x,(8,x)
 523  0096 90ef08        	ldw	(8,y),x
 524                     ; 119 		ptr -> UI_Speed = memptr -> UI_Speed;
 526  0099 1e05          	ldw	x,(OFST+5,sp)
 527  009b ee0a          	ldw	x,(10,x)
 528  009d 90ef0a        	ldw	(10,y),x
 529                     ; 120 		ptr -> Analog_Slider = memptr -> Analog_Slider;
 531  00a0 1e05          	ldw	x,(OFST+5,sp)
 532  00a2 ee0c          	ldw	x,(12,x)
 533  00a4 90ef0c        	ldw	(12,y),x
 534                     ; 121 }
 537  00a7 85            	popw	x
 538  00a8 81            	ret	
 573                     ; 123 void UARTsend(uint8_t value)
 573                     ; 124 {
 574                     	switch	.text
 575  00a9               _UARTsend:
 579                     ; 125     UART2_SendData8(value);
 581  00a9 cd0000        	call	_UART2_SendData8
 584  00ac               L342:
 585                     ; 126     while ( 0 == (UART2->SR & UART2_SR_TXE) );
 587  00ac 720f5240fb    	btjf	21056,#7,L342
 588                     ; 127 }
 591  00b1 81            	ret	
 628                     ; 129 void innit_data(struct mem_data *memptr)
 628                     ; 130 {
 629                     	switch	.text
 630  00b2               _innit_data:
 634                     ; 131 		memptr -> Commutation_Period = 0x01;
 636  00b2 90ae0001      	ldw	y,#1
 637  00b6 ff            	ldw	(x),y
 638                     ; 132 		memptr -> Duty_Cycle = 0x02;
 640  00b7 905c          	incw	y
 641  00b9 ef02          	ldw	(2,x),y
 642                     ; 133 		memptr -> Vsystem = 0x03;
 644  00bb 905c          	incw	y
 645  00bd ef04          	ldw	(4,x),y
 646                     ; 134 		memptr -> Back_EMF_Rising = 0x04;
 648  00bf 905c          	incw	y
 649  00c1 ef06          	ldw	(6,x),y
 650                     ; 135 		memptr -> Back_EMF_Falling = 0x05;
 652  00c3 905c          	incw	y
 653  00c5 ef08          	ldw	(8,x),y
 654                     ; 136 		memptr -> UI_Speed = 0x06;
 656  00c7 905c          	incw	y
 657  00c9 ef0a          	ldw	(10,x),y
 658                     ; 137 		memptr -> Analog_Slider = 0x07;
 660  00cb 905c          	incw	y
 661  00cd ef0c          	ldw	(12,x),y
 662                     ; 139 }
 665  00cf 81            	ret	
 698                     ; 141 void clock_setup(void)
 698                     ; 142 {
 699                     	switch	.text
 700  00d0               _clock_setup:
 704                     ; 143      CLK_DeInit();
 706  00d0 cd0000        	call	_CLK_DeInit
 708                     ; 145      CLK_HSECmd(DISABLE);
 710  00d3 4f            	clr	a
 711  00d4 cd0000        	call	_CLK_HSECmd
 713                     ; 146      CLK_LSICmd(DISABLE);
 715  00d7 4f            	clr	a
 716  00d8 cd0000        	call	_CLK_LSICmd
 718                     ; 147      CLK_HSICmd(ENABLE);
 720  00db a601          	ld	a,#1
 721  00dd cd0000        	call	_CLK_HSICmd
 724  00e0               L103:
 725                     ; 148      while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
 727  00e0 ae0102        	ldw	x,#258
 728  00e3 cd0000        	call	_CLK_GetFlagStatus
 730  00e6 4d            	tnz	a
 731  00e7 27f7          	jreq	L103
 732                     ; 150      CLK_ClockSwitchCmd(ENABLE);
 734  00e9 a601          	ld	a,#1
 735  00eb cd0000        	call	_CLK_ClockSwitchCmd
 737                     ; 151      CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV2);
 739  00ee a608          	ld	a,#8
 740  00f0 cd0000        	call	_CLK_HSIPrescalerConfig
 742                     ; 152      CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
 744  00f3 a680          	ld	a,#128
 745  00f5 cd0000        	call	_CLK_SYSCLKConfig
 747                     ; 154      CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, 
 747                     ; 155      DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
 749  00f8 4b01          	push	#1
 750  00fa 4b00          	push	#0
 751  00fc ae01e1        	ldw	x,#481
 752  00ff cd0000        	call	_CLK_ClockSwitchConfig
 754  0102 85            	popw	x
 755                     ; 157      CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, DISABLE);
 757  0103 ae0100        	ldw	x,#256
 758  0106 cd0000        	call	_CLK_PeripheralClockConfig
 760                     ; 158      CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
 762  0109 5f            	clrw	x
 763  010a cd0000        	call	_CLK_PeripheralClockConfig
 765                     ; 159      CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, DISABLE);
 767  010d ae1300        	ldw	x,#4864
 768  0110 cd0000        	call	_CLK_PeripheralClockConfig
 770                     ; 160      CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
 772  0113 ae1200        	ldw	x,#4608
 773  0116 cd0000        	call	_CLK_PeripheralClockConfig
 775                     ; 161      CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART2, ENABLE);
 777  0119 ae0301        	ldw	x,#769
 778  011c cd0000        	call	_CLK_PeripheralClockConfig
 780                     ; 162      CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
 782  011f ae0700        	ldw	x,#1792
 783  0122 cd0000        	call	_CLK_PeripheralClockConfig
 785                     ; 163      CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, DISABLE);
 787  0125 ae0500        	ldw	x,#1280
 788  0128 cd0000        	call	_CLK_PeripheralClockConfig
 790                     ; 164      CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, DISABLE);
 792  012b ae0400        	ldw	x,#1024
 794                     ; 165 }
 797  012e cc0000        	jp	_CLK_PeripheralClockConfig
 823                     ; 168 void GPIO_setup(void)
 823                     ; 169 {
 824                     	switch	.text
 825  0131               _GPIO_setup:
 829                     ; 180 		 GPIO_DeInit(GPIOD); 
 831  0131 ae500f        	ldw	x,#20495
 832  0134 cd0000        	call	_GPIO_DeInit
 834                     ; 187 		 GPIO_Init(Light_port, Light_pin, GPIO_MODE_OUT_PP_HIGH_FAST);
 836  0137 4bf0          	push	#240
 837  0139 4b01          	push	#1
 838  013b ae500f        	ldw	x,#20495
 839  013e cd0000        	call	_GPIO_Init
 841  0141 85            	popw	x
 842                     ; 189 		 GPIO_WriteLow(Light_port, Light_pin);
 844  0142 4b01          	push	#1
 845  0144 ae500f        	ldw	x,#20495
 846  0147 cd0000        	call	_GPIO_WriteLow
 848  014a 84            	pop	a
 849                     ; 191 }
 852  014b 81            	ret	
 880                     ; 193 void UART2_setup(void) 
 880                     ; 194 { 
 881                     	switch	.text
 882  014c               _UART2_setup:
 886                     ; 195     UART2_DeInit();
 888  014c cd0000        	call	_UART2_DeInit
 890                     ; 196 		UART2_Init(38400, 
 890                     ; 197 		           UART2_WORDLENGTH_8D, 
 890                     ; 198 							 UART2_STOPBITS_1, 
 890                     ; 199 							 UART2_PARITY_NO, 
 890                     ; 200 							 UART2_SYNCMODE_CLOCK_DISABLE, 
 890                     ; 201 							 UART2_MODE_TXRX_ENABLE); 
 892  014f 4b0c          	push	#12
 893  0151 4b80          	push	#128
 894  0153 4b00          	push	#0
 895  0155 4b00          	push	#0
 896  0157 4b00          	push	#0
 897  0159 ae9600        	ldw	x,#38400
 898  015c 89            	pushw	x
 899  015d 5f            	clrw	x
 900  015e 89            	pushw	x
 901  015f cd0000        	call	_UART2_Init
 903  0162 5b09          	addw	sp,#9
 904                     ; 203 		UART2_ITConfig(UART2_IT_RXNE, ENABLE); 
 906  0164 4b01          	push	#1
 907  0166 ae0255        	ldw	x,#597
 908  0169 cd0000        	call	_UART2_ITConfig
 910  016c 9a            	rim	
 911  016d 84            	pop	a
 912                     ; 204 		enableInterrupts();
 916                     ; 206 		UART2_Cmd(ENABLE); 
 919  016e a601          	ld	a,#1
 921                     ; 207 }
 924  0170 cc0000        	jp	_UART2_Cmd
 949                     	xdef	_main
 950                     	xdef	_sendData
 951                     	xdef	_UARTsend
 952                     	xdef	_getData
 953                     	xdef	_innit_data
 954                     	xdef	_UART2_setup
 955                     	xdef	_GPIO_setup
 956                     	xdef	_clock_setup
 957                     	xref	_UART2_SendData8
 958                     	xref	_UART2_ITConfig
 959                     	xref	_UART2_Cmd
 960                     	xref	_UART2_Init
 961                     	xref	_UART2_DeInit
 962                     	xref	_GPIO_WriteLow
 963                     	xref	_GPIO_Init
 964                     	xref	_GPIO_DeInit
 965                     	xref	_CLK_GetFlagStatus
 966                     	xref	_CLK_SYSCLKConfig
 967                     	xref	_CLK_HSIPrescalerConfig
 968                     	xref	_CLK_ClockSwitchConfig
 969                     	xref	_CLK_PeripheralClockConfig
 970                     	xref	_CLK_ClockSwitchCmd
 971                     	xref	_CLK_LSICmd
 972                     	xref	_CLK_HSICmd
 973                     	xref	_CLK_HSECmd
 974                     	xref	_CLK_DeInit
 993                     	end
