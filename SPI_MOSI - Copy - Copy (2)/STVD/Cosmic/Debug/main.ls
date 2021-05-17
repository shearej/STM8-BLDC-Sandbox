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
 132                     ; 61 void main(void)
 132                     ; 62 {
 134                     	switch	.text
 135  0000               _main:
 137  0000 89            	pushw	x
 138       00000002      OFST:	set	2
 141                     ; 63 	struct mem_data *memptr = &memData1;
 143  0001 ae0000        	ldw	x,#L3_memData1
 144  0004 1f01          	ldw	(OFST-1,sp),x
 146                     ; 65 	clock_setup();
 148  0006 cd00d3        	call	_clock_setup
 150                     ; 66 	GPIO_setup();
 152  0009 cd0134        	call	_GPIO_setup
 154                     ; 67 	UART2_setup();
 156  000c cd014f        	call	_UART2_setup
 158                     ; 68 	innit_data(memptr);
 160  000f 1e01          	ldw	x,(OFST-1,sp)
 161  0011 cd00b5        	call	_innit_data
 163  0014               L55:
 164                     ; 73 			sendData(memptr);
 166  0014 1e01          	ldw	x,(OFST-1,sp)
 167  0016 ad0a          	call	_sendData
 169                     ; 74 			memptr -> Commutation_Period++;
 171  0018 1e01          	ldw	x,(OFST-1,sp)
 172  001a 9093          	ldw	y,x
 173  001c fe            	ldw	x,(x)
 174  001d 5c            	incw	x
 175  001e 90ff          	ldw	(y),x
 177  0020 20f2          	jra	L55
 338                     ; 78 void sendData(struct mem_data *memptr1)
 338                     ; 79 {
 339                     	switch	.text
 340  0022               _sendData:
 342  0022 5217          	subw	sp,#23
 343       00000017      OFST:	set	23
 346                     ; 87 	  ptr = &data1;
 348                     ; 89     getData(ptr, memptr1); //fill data struct with motor data
 350  0024 89            	pushw	x
 351  0025 96            	ldw	x,sp
 352  0026 1c0005        	addw	x,#OFST-18
 353  0029 ad49          	call	_getData
 355  002b 85            	popw	x
 356                     ; 91 		ptr2 = &data1.Commutation_Period; //pointer to the first index of data struct
 358  002c 96            	ldw	x,sp
 359  002d 1c0004        	addw	x,#OFST-19
 360  0030 1f13          	ldw	(OFST-4,sp),x
 362                     ; 93     UARTsend(data1.SOF); //start of frame message. only works for 1 byte
 364  0032 7b03          	ld	a,(OFST-20,sp)
 365  0034 ad76          	call	_UARTsend
 367                     ; 95     for(i = 0; i < sizeof(data1); i++) //index through struct
 369  0036 0f12          	clr	(OFST-5,sp)
 371  0038               L751:
 372                     ; 97 			for(k = 0; k < sizeof(*ptr2); k++) // multi-byte message sending
 374  0038 0f15          	clr	(OFST-2,sp)
 376  003a               L561:
 377                     ; 99 				value = (*ptr2);
 379  003a 1e13          	ldw	x,(OFST-4,sp)
 380  003c fe            	ldw	x,(x)
 381  003d 1f16          	ldw	(OFST-1,sp),x
 383                     ; 100 				value >>= (8 *k);
 385  003f 905f          	clrw	y
 386  0041 7b15          	ld	a,(OFST-2,sp)
 387  0043 9097          	ld	yl,a
 388  0045 9058          	sllw	y
 389  0047 9058          	sllw	y
 390  0049 9058          	sllw	y
 391  004b 2705          	jreq	L62
 392  004d               L03:
 393  004d 54            	srlw	x
 394  004e 905a          	decw	y
 395  0050 26fb          	jrne	L03
 396  0052               L62:
 397  0052 1f16          	ldw	(OFST-1,sp),x
 399                     ; 101 				value &= 0xFF;
 401  0054 0f16          	clr	(OFST-1,sp)
 403                     ; 102 				UARTsend(value); 
 405  0056 7b17          	ld	a,(OFST+0,sp)
 406  0058 ad52          	call	_UARTsend
 408                     ; 97 			for(k = 0; k < sizeof(*ptr2); k++) // multi-byte message sending
 410  005a 0c15          	inc	(OFST-2,sp)
 414  005c 7b15          	ld	a,(OFST-2,sp)
 415  005e a102          	cp	a,#2
 416  0060 25d8          	jrult	L561
 417                     ; 104 			ptr2++;
 419  0062 1e13          	ldw	x,(OFST-4,sp)
 420  0064 1c0002        	addw	x,#2
 421  0067 1f13          	ldw	(OFST-4,sp),x
 423                     ; 95     for(i = 0; i < sizeof(data1); i++) //index through struct
 425  0069 0c12          	inc	(OFST-5,sp)
 429  006b 7b12          	ld	a,(OFST-5,sp)
 430  006d a10f          	cp	a,#15
 431  006f 25c7          	jrult	L751
 432                     ; 107 }
 435  0071 5b17          	addw	sp,#23
 436  0073 81            	ret	
 485                     ; 109 void getData(struct data *ptr, struct mem_data *memptr)
 485                     ; 110 {
 486                     	switch	.text
 487  0074               _getData:
 489  0074 89            	pushw	x
 490       00000000      OFST:	set	0
 493                     ; 111     ptr -> SOF = 0xA5;
 495  0075 a6a5          	ld	a,#165
 496  0077 f7            	ld	(x),a
 497                     ; 112 		ptr -> Commutation_Period = memptr -> Commutation_Period;
 499  0078 1e05          	ldw	x,(OFST+5,sp)
 500  007a 1601          	ldw	y,(OFST+1,sp)
 501  007c fe            	ldw	x,(x)
 502  007d 90ef01        	ldw	(1,y),x
 503                     ; 113 		ptr -> Duty_Cycle = memptr -> Duty_Cycle;
 505  0080 1e05          	ldw	x,(OFST+5,sp)
 506  0082 ee02          	ldw	x,(2,x)
 507  0084 90ef03        	ldw	(3,y),x
 508                     ; 114 		ptr -> Vsystem = memptr -> Vsystem;
 510  0087 1e05          	ldw	x,(OFST+5,sp)
 511  0089 ee04          	ldw	x,(4,x)
 512  008b 90ef05        	ldw	(5,y),x
 513                     ; 115 		ptr -> Back_EMF_Rising = memptr -> Back_EMF_Rising;
 515  008e 1e05          	ldw	x,(OFST+5,sp)
 516  0090 ee06          	ldw	x,(6,x)
 517  0092 90ef07        	ldw	(7,y),x
 518                     ; 116 		ptr -> Back_EMF_Falling = memptr -> Back_EMF_Falling;
 520  0095 1e05          	ldw	x,(OFST+5,sp)
 521  0097 ee08          	ldw	x,(8,x)
 522  0099 90ef09        	ldw	(9,y),x
 523                     ; 117 		ptr -> UI_Speed = memptr -> UI_Speed;
 525  009c 1e05          	ldw	x,(OFST+5,sp)
 526  009e ee0a          	ldw	x,(10,x)
 527  00a0 90ef0b        	ldw	(11,y),x
 528                     ; 118 		ptr -> Analog_Slider = memptr -> Analog_Slider;
 530  00a3 1e05          	ldw	x,(OFST+5,sp)
 531  00a5 ee0c          	ldw	x,(12,x)
 532  00a7 90ef0d        	ldw	(13,y),x
 533                     ; 119 }
 536  00aa 85            	popw	x
 537  00ab 81            	ret	
 572                     ; 121 void UARTsend(uint8_t value)
 572                     ; 122 {
 573                     	switch	.text
 574  00ac               _UARTsend:
 578                     ; 123     UART2_SendData8(value);
 580  00ac cd0000        	call	_UART2_SendData8
 583  00af               L142:
 584                     ; 124     while ( 0 == (UART2->SR & UART2_SR_TXE) );
 586  00af 720f5240fb    	btjf	21056,#7,L142
 587                     ; 125 }
 590  00b4 81            	ret	
 627                     ; 127 void innit_data(struct mem_data *memptr)
 627                     ; 128 {
 628                     	switch	.text
 629  00b5               _innit_data:
 633                     ; 129 		memptr -> Commutation_Period = 0x01;
 635  00b5 90ae0001      	ldw	y,#1
 636  00b9 ff            	ldw	(x),y
 637                     ; 130 		memptr -> Duty_Cycle = 0x02;
 639  00ba 905c          	incw	y
 640  00bc ef02          	ldw	(2,x),y
 641                     ; 131 		memptr -> Vsystem = 0x03;
 643  00be 905c          	incw	y
 644  00c0 ef04          	ldw	(4,x),y
 645                     ; 132 		memptr -> Back_EMF_Rising = 0x04;
 647  00c2 905c          	incw	y
 648  00c4 ef06          	ldw	(6,x),y
 649                     ; 133 		memptr -> Back_EMF_Falling = 0x05;
 651  00c6 905c          	incw	y
 652  00c8 ef08          	ldw	(8,x),y
 653                     ; 134 		memptr -> UI_Speed = 0x06;
 655  00ca 905c          	incw	y
 656  00cc ef0a          	ldw	(10,x),y
 657                     ; 135 		memptr -> Analog_Slider = 0x07;
 659  00ce 905c          	incw	y
 660  00d0 ef0c          	ldw	(12,x),y
 661                     ; 137 }
 664  00d2 81            	ret	
 697                     ; 139 void clock_setup(void)
 697                     ; 140 {
 698                     	switch	.text
 699  00d3               _clock_setup:
 703                     ; 141      CLK_DeInit();
 705  00d3 cd0000        	call	_CLK_DeInit
 707                     ; 143      CLK_HSECmd(DISABLE);
 709  00d6 4f            	clr	a
 710  00d7 cd0000        	call	_CLK_HSECmd
 712                     ; 144      CLK_LSICmd(DISABLE);
 714  00da 4f            	clr	a
 715  00db cd0000        	call	_CLK_LSICmd
 717                     ; 145      CLK_HSICmd(ENABLE);
 719  00de a601          	ld	a,#1
 720  00e0 cd0000        	call	_CLK_HSICmd
 723  00e3               L772:
 724                     ; 146      while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
 726  00e3 ae0102        	ldw	x,#258
 727  00e6 cd0000        	call	_CLK_GetFlagStatus
 729  00e9 4d            	tnz	a
 730  00ea 27f7          	jreq	L772
 731                     ; 148      CLK_ClockSwitchCmd(ENABLE);
 733  00ec a601          	ld	a,#1
 734  00ee cd0000        	call	_CLK_ClockSwitchCmd
 736                     ; 149      CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV2);
 738  00f1 a608          	ld	a,#8
 739  00f3 cd0000        	call	_CLK_HSIPrescalerConfig
 741                     ; 150      CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
 743  00f6 a680          	ld	a,#128
 744  00f8 cd0000        	call	_CLK_SYSCLKConfig
 746                     ; 152      CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, 
 746                     ; 153      DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
 748  00fb 4b01          	push	#1
 749  00fd 4b00          	push	#0
 750  00ff ae01e1        	ldw	x,#481
 751  0102 cd0000        	call	_CLK_ClockSwitchConfig
 753  0105 85            	popw	x
 754                     ; 155      CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, DISABLE);
 756  0106 ae0100        	ldw	x,#256
 757  0109 cd0000        	call	_CLK_PeripheralClockConfig
 759                     ; 156      CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
 761  010c 5f            	clrw	x
 762  010d cd0000        	call	_CLK_PeripheralClockConfig
 764                     ; 157      CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, DISABLE);
 766  0110 ae1300        	ldw	x,#4864
 767  0113 cd0000        	call	_CLK_PeripheralClockConfig
 769                     ; 158      CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
 771  0116 ae1200        	ldw	x,#4608
 772  0119 cd0000        	call	_CLK_PeripheralClockConfig
 774                     ; 159      CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART2, ENABLE);
 776  011c ae0301        	ldw	x,#769
 777  011f cd0000        	call	_CLK_PeripheralClockConfig
 779                     ; 160      CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
 781  0122 ae0700        	ldw	x,#1792
 782  0125 cd0000        	call	_CLK_PeripheralClockConfig
 784                     ; 161      CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, DISABLE);
 786  0128 ae0500        	ldw	x,#1280
 787  012b cd0000        	call	_CLK_PeripheralClockConfig
 789                     ; 162      CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, DISABLE);
 791  012e ae0400        	ldw	x,#1024
 793                     ; 163 }
 796  0131 cc0000        	jp	_CLK_PeripheralClockConfig
 822                     ; 166 void GPIO_setup(void)
 822                     ; 167 {
 823                     	switch	.text
 824  0134               _GPIO_setup:
 828                     ; 178 		 GPIO_DeInit(GPIOD); 
 830  0134 ae500f        	ldw	x,#20495
 831  0137 cd0000        	call	_GPIO_DeInit
 833                     ; 185 		 GPIO_Init(Light_port, Light_pin, GPIO_MODE_OUT_PP_HIGH_FAST);
 835  013a 4bf0          	push	#240
 836  013c 4b01          	push	#1
 837  013e ae500f        	ldw	x,#20495
 838  0141 cd0000        	call	_GPIO_Init
 840  0144 85            	popw	x
 841                     ; 187 		 GPIO_WriteLow(Light_port, Light_pin);
 843  0145 4b01          	push	#1
 844  0147 ae500f        	ldw	x,#20495
 845  014a cd0000        	call	_GPIO_WriteLow
 847  014d 84            	pop	a
 848                     ; 189 }
 851  014e 81            	ret	
 879                     ; 191 void UART2_setup(void) 
 879                     ; 192 { 
 880                     	switch	.text
 881  014f               _UART2_setup:
 885                     ; 193     UART2_DeInit();
 887  014f cd0000        	call	_UART2_DeInit
 889                     ; 194 		UART2_Init(38400, 
 889                     ; 195 		           UART2_WORDLENGTH_8D, 
 889                     ; 196 							 UART2_STOPBITS_1, 
 889                     ; 197 							 UART2_PARITY_NO, 
 889                     ; 198 							 UART2_SYNCMODE_CLOCK_DISABLE, 
 889                     ; 199 							 UART2_MODE_TXRX_ENABLE); 
 891  0152 4b0c          	push	#12
 892  0154 4b80          	push	#128
 893  0156 4b00          	push	#0
 894  0158 4b00          	push	#0
 895  015a 4b00          	push	#0
 896  015c ae9600        	ldw	x,#38400
 897  015f 89            	pushw	x
 898  0160 5f            	clrw	x
 899  0161 89            	pushw	x
 900  0162 cd0000        	call	_UART2_Init
 902  0165 5b09          	addw	sp,#9
 903                     ; 201 		UART2_ITConfig(UART2_IT_RXNE, ENABLE); 
 905  0167 4b01          	push	#1
 906  0169 ae0255        	ldw	x,#597
 907  016c cd0000        	call	_UART2_ITConfig
 909  016f 9a            	rim	
 910  0170 84            	pop	a
 911                     ; 202 		enableInterrupts();
 915                     ; 204 		UART2_Cmd(ENABLE); 
 918  0171 a601          	ld	a,#1
 920                     ; 205 }
 923  0173 cc0000        	jp	_UART2_Cmd
 948                     	xdef	_main
 949                     	xdef	_sendData
 950                     	xdef	_UARTsend
 951                     	xdef	_getData
 952                     	xdef	_innit_data
 953                     	xdef	_UART2_setup
 954                     	xdef	_GPIO_setup
 955                     	xdef	_clock_setup
 956                     	xref	_UART2_SendData8
 957                     	xref	_UART2_ITConfig
 958                     	xref	_UART2_Cmd
 959                     	xref	_UART2_Init
 960                     	xref	_UART2_DeInit
 961                     	xref	_GPIO_WriteLow
 962                     	xref	_GPIO_Init
 963                     	xref	_GPIO_DeInit
 964                     	xref	_CLK_GetFlagStatus
 965                     	xref	_CLK_SYSCLKConfig
 966                     	xref	_CLK_HSIPrescalerConfig
 967                     	xref	_CLK_ClockSwitchConfig
 968                     	xref	_CLK_PeripheralClockConfig
 969                     	xref	_CLK_ClockSwitchCmd
 970                     	xref	_CLK_LSICmd
 971                     	xref	_CLK_HSICmd
 972                     	xref	_CLK_HSECmd
 973                     	xref	_CLK_DeInit
 992                     	end
