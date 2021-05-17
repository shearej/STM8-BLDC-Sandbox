   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.1 - 30 Jun 2020
   3                     ; Generator (Limited) V4.4.12 - 02 Jul 2020
   4                     ; Optimizer V4.4.12 - 02 Jul 2020
  19                     .const:	section	.text
  20  0000               _HSIDivFactor:
  21  0000 01            	dc.b	1
  22  0001 02            	dc.b	2
  23  0002 04            	dc.b	4
  24  0003 08            	dc.b	8
  25  0004               _CLKPrescTable:
  26  0004 01            	dc.b	1
  27  0005 02            	dc.b	2
  28  0006 04            	dc.b	4
  29  0007 08            	dc.b	8
  30  0008 0a            	dc.b	10
  31  0009 10            	dc.b	16
  32  000a 14            	dc.b	20
  33  000b 28            	dc.b	40
  62                     ; 66 void CLK_DeInit(void)
  62                     ; 67 {
  64                     	switch	.text
  65  0000               _CLK_DeInit:
  69                     ; 69     CLK->ICKR = CLK_ICKR_RESET_VALUE;
  71  0000 350150c0      	mov	20672,#1
  72                     ; 70     CLK->ECKR = CLK_ECKR_RESET_VALUE;
  74  0004 725f50c1      	clr	20673
  75                     ; 71     CLK->SWR  = CLK_SWR_RESET_VALUE;
  77  0008 35e150c4      	mov	20676,#225
  78                     ; 72     CLK->SWCR = CLK_SWCR_RESET_VALUE;
  80  000c 725f50c5      	clr	20677
  81                     ; 73     CLK->CKDIVR = CLK_CKDIVR_RESET_VALUE;
  83  0010 351850c6      	mov	20678,#24
  84                     ; 74     CLK->PCKENR1 = CLK_PCKENR1_RESET_VALUE;
  86  0014 35ff50c7      	mov	20679,#255
  87                     ; 75     CLK->PCKENR2 = CLK_PCKENR2_RESET_VALUE;
  89  0018 35ff50ca      	mov	20682,#255
  90                     ; 76     CLK->CSSR = CLK_CSSR_RESET_VALUE;
  92  001c 725f50c8      	clr	20680
  93                     ; 77     CLK->CCOR = CLK_CCOR_RESET_VALUE;
  95  0020 725f50c9      	clr	20681
  97  0024               L52:
  98                     ; 78     while ((CLK->CCOR & CLK_CCOR_CCOEN)!= 0)
 100  0024 720050c9fb    	btjt	20681,#0,L52
 101                     ; 80     CLK->CCOR = CLK_CCOR_RESET_VALUE;
 103  0029 725f50c9      	clr	20681
 104                     ; 81     CLK->HSITRIMR = CLK_HSITRIMR_RESET_VALUE;
 106  002d 725f50cc      	clr	20684
 107                     ; 82     CLK->SWIMCCR = CLK_SWIMCCR_RESET_VALUE;
 109  0031 725f50cd      	clr	20685
 110                     ; 84 }
 113  0035 81            	ret	
 169                     ; 95 void CLK_FastHaltWakeUpCmd(FunctionalState NewState)
 169                     ; 96 {
 170                     	switch	.text
 171  0036               _CLK_FastHaltWakeUpCmd:
 175                     ; 99     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 177                     ; 101     if (NewState != DISABLE)
 179  0036 4d            	tnz	a
 180  0037 2705          	jreq	L75
 181                     ; 104         CLK->ICKR |= CLK_ICKR_FHWU;
 183  0039 721450c0      	bset	20672,#2
 186  003d 81            	ret	
 187  003e               L75:
 188                     ; 109         CLK->ICKR &= (uint8_t)(~CLK_ICKR_FHWU);
 190  003e 721550c0      	bres	20672,#2
 191                     ; 112 }
 194  0042 81            	ret	
 229                     ; 119 void CLK_HSECmd(FunctionalState NewState)
 229                     ; 120 {
 230                     	switch	.text
 231  0043               _CLK_HSECmd:
 235                     ; 123     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 237                     ; 125     if (NewState != DISABLE)
 239  0043 4d            	tnz	a
 240  0044 2705          	jreq	L101
 241                     ; 128         CLK->ECKR |= CLK_ECKR_HSEEN;
 243  0046 721050c1      	bset	20673,#0
 246  004a 81            	ret	
 247  004b               L101:
 248                     ; 133         CLK->ECKR &= (uint8_t)(~CLK_ECKR_HSEEN);
 250  004b 721150c1      	bres	20673,#0
 251                     ; 136 }
 254  004f 81            	ret	
 289                     ; 143 void CLK_HSICmd(FunctionalState NewState)
 289                     ; 144 {
 290                     	switch	.text
 291  0050               _CLK_HSICmd:
 295                     ; 147     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 297                     ; 149     if (NewState != DISABLE)
 299  0050 4d            	tnz	a
 300  0051 2705          	jreq	L321
 301                     ; 152         CLK->ICKR |= CLK_ICKR_HSIEN;
 303  0053 721050c0      	bset	20672,#0
 306  0057 81            	ret	
 307  0058               L321:
 308                     ; 157         CLK->ICKR &= (uint8_t)(~CLK_ICKR_HSIEN);
 310  0058 721150c0      	bres	20672,#0
 311                     ; 160 }
 314  005c 81            	ret	
 349                     ; 167 void CLK_LSICmd(FunctionalState NewState)
 349                     ; 168 {
 350                     	switch	.text
 351  005d               _CLK_LSICmd:
 355                     ; 171     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 357                     ; 173     if (NewState != DISABLE)
 359  005d 4d            	tnz	a
 360  005e 2705          	jreq	L541
 361                     ; 176         CLK->ICKR |= CLK_ICKR_LSIEN;
 363  0060 721650c0      	bset	20672,#3
 366  0064 81            	ret	
 367  0065               L541:
 368                     ; 181         CLK->ICKR &= (uint8_t)(~CLK_ICKR_LSIEN);
 370  0065 721750c0      	bres	20672,#3
 371                     ; 184 }
 374  0069 81            	ret	
 409                     ; 192 void CLK_CCOCmd(FunctionalState NewState)
 409                     ; 193 {
 410                     	switch	.text
 411  006a               _CLK_CCOCmd:
 415                     ; 196     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 417                     ; 198     if (NewState != DISABLE)
 419  006a 4d            	tnz	a
 420  006b 2705          	jreq	L761
 421                     ; 201         CLK->CCOR |= CLK_CCOR_CCOEN;
 423  006d 721050c9      	bset	20681,#0
 426  0071 81            	ret	
 427  0072               L761:
 428                     ; 206         CLK->CCOR &= (uint8_t)(~CLK_CCOR_CCOEN);
 430  0072 721150c9      	bres	20681,#0
 431                     ; 209 }
 434  0076 81            	ret	
 469                     ; 218 void CLK_ClockSwitchCmd(FunctionalState NewState)
 469                     ; 219 {
 470                     	switch	.text
 471  0077               _CLK_ClockSwitchCmd:
 475                     ; 222     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 477                     ; 224     if (NewState != DISABLE )
 479  0077 4d            	tnz	a
 480  0078 2705          	jreq	L112
 481                     ; 227         CLK->SWCR |= CLK_SWCR_SWEN;
 483  007a 721250c5      	bset	20677,#1
 486  007e 81            	ret	
 487  007f               L112:
 488                     ; 232         CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWEN);
 490  007f 721350c5      	bres	20677,#1
 491                     ; 235 }
 494  0083 81            	ret	
 530                     ; 245 void CLK_SlowActiveHaltWakeUpCmd(FunctionalState NewState)
 530                     ; 246 {
 531                     	switch	.text
 532  0084               _CLK_SlowActiveHaltWakeUpCmd:
 536                     ; 249     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 538                     ; 251     if (NewState != DISABLE)
 540  0084 4d            	tnz	a
 541  0085 2705          	jreq	L332
 542                     ; 254         CLK->ICKR |= CLK_ICKR_SWUAH;
 544  0087 721a50c0      	bset	20672,#5
 547  008b 81            	ret	
 548  008c               L332:
 549                     ; 259         CLK->ICKR &= (uint8_t)(~CLK_ICKR_SWUAH);
 551  008c 721b50c0      	bres	20672,#5
 552                     ; 262 }
 555  0090 81            	ret	
 714                     ; 272 void CLK_PeripheralClockConfig(CLK_Peripheral_TypeDef CLK_Peripheral, FunctionalState NewState)
 714                     ; 273 {
 715                     	switch	.text
 716  0091               _CLK_PeripheralClockConfig:
 718  0091 89            	pushw	x
 719       00000000      OFST:	set	0
 722                     ; 276     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 724                     ; 277     assert_param(IS_CLK_PERIPHERAL_OK(CLK_Peripheral));
 726                     ; 279     if (((uint8_t)CLK_Peripheral & (uint8_t)0x10) == 0x00)
 728  0092 9e            	ld	a,xh
 729  0093 a510          	bcp	a,#16
 730  0095 2626          	jrne	L123
 731                     ; 281         if (NewState != DISABLE)
 733  0097 7b02          	ld	a,(OFST+2,sp)
 734  0099 270f          	jreq	L323
 735                     ; 284             CLK->PCKENR1 |= (uint8_t)((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F));
 737  009b 7b01          	ld	a,(OFST+1,sp)
 738  009d ad44          	call	LC003
 739  009f 2704          	jreq	L62
 740  00a1               L03:
 741  00a1 48            	sll	a
 742  00a2 5a            	decw	x
 743  00a3 26fc          	jrne	L03
 744  00a5               L62:
 745  00a5 ca50c7        	or	a,20679
 747  00a8 200e          	jp	LC002
 748  00aa               L323:
 749                     ; 289             CLK->PCKENR1 &= (uint8_t)(~(uint8_t)(((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F))));
 751  00aa 7b01          	ld	a,(OFST+1,sp)
 752  00ac ad35          	call	LC003
 753  00ae 2704          	jreq	L23
 754  00b0               L43:
 755  00b0 48            	sll	a
 756  00b1 5a            	decw	x
 757  00b2 26fc          	jrne	L43
 758  00b4               L23:
 759  00b4 43            	cpl	a
 760  00b5 c450c7        	and	a,20679
 761  00b8               LC002:
 762  00b8 c750c7        	ld	20679,a
 763  00bb 2024          	jra	L723
 764  00bd               L123:
 765                     ; 294         if (NewState != DISABLE)
 767  00bd 7b02          	ld	a,(OFST+2,sp)
 768  00bf 270f          	jreq	L133
 769                     ; 297             CLK->PCKENR2 |= (uint8_t)((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F));
 771  00c1 7b01          	ld	a,(OFST+1,sp)
 772  00c3 ad1e          	call	LC003
 773  00c5 2704          	jreq	L63
 774  00c7               L04:
 775  00c7 48            	sll	a
 776  00c8 5a            	decw	x
 777  00c9 26fc          	jrne	L04
 778  00cb               L63:
 779  00cb ca50ca        	or	a,20682
 781  00ce 200e          	jp	LC001
 782  00d0               L133:
 783                     ; 302             CLK->PCKENR2 &= (uint8_t)(~(uint8_t)(((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F))));
 785  00d0 7b01          	ld	a,(OFST+1,sp)
 786  00d2 ad0f          	call	LC003
 787  00d4 2704          	jreq	L24
 788  00d6               L44:
 789  00d6 48            	sll	a
 790  00d7 5a            	decw	x
 791  00d8 26fc          	jrne	L44
 792  00da               L24:
 793  00da 43            	cpl	a
 794  00db c450ca        	and	a,20682
 795  00de               LC001:
 796  00de c750ca        	ld	20682,a
 797  00e1               L723:
 798                     ; 306 }
 801  00e1 85            	popw	x
 802  00e2 81            	ret	
 803  00e3               LC003:
 804  00e3 a40f          	and	a,#15
 805  00e5 5f            	clrw	x
 806  00e6 97            	ld	xl,a
 807  00e7 a601          	ld	a,#1
 808  00e9 5d            	tnzw	x
 809  00ea 81            	ret	
 997                     ; 319 ErrorStatus CLK_ClockSwitchConfig(CLK_SwitchMode_TypeDef CLK_SwitchMode, CLK_Source_TypeDef CLK_NewClock, FunctionalState ITState, CLK_CurrentClockState_TypeDef CLK_CurrentClockState)
 997                     ; 320 {
 998                     	switch	.text
 999  00eb               _CLK_ClockSwitchConfig:
1001  00eb 89            	pushw	x
1002  00ec 5204          	subw	sp,#4
1003       00000004      OFST:	set	4
1006                     ; 323     uint16_t DownCounter = CLK_TIMEOUT;
1008  00ee ae0491        	ldw	x,#1169
1009  00f1 1f03          	ldw	(OFST-1,sp),x
1011                     ; 324     ErrorStatus Swif = ERROR;
1013                     ; 327     assert_param(IS_CLK_SOURCE_OK(CLK_NewClock));
1015                     ; 328     assert_param(IS_CLK_SWITCHMODE_OK(CLK_SwitchMode));
1017                     ; 329     assert_param(IS_FUNCTIONALSTATE_OK(ITState));
1019                     ; 330     assert_param(IS_CLK_CURRENTCLOCKSTATE_OK(CLK_CurrentClockState));
1021                     ; 333     clock_master = (CLK_Source_TypeDef)CLK->CMSR;
1023  00f3 c650c3        	ld	a,20675
1024  00f6 6b01          	ld	(OFST-3,sp),a
1026                     ; 336     if (CLK_SwitchMode == CLK_SWITCHMODE_AUTO)
1028  00f8 7b05          	ld	a,(OFST+1,sp)
1029  00fa 4a            	dec	a
1030  00fb 262d          	jrne	L544
1031                     ; 340         CLK->SWCR |= CLK_SWCR_SWEN;
1033  00fd 721250c5      	bset	20677,#1
1034                     ; 343         if (ITState != DISABLE)
1036  0101 7b09          	ld	a,(OFST+5,sp)
1037  0103 2706          	jreq	L744
1038                     ; 345             CLK->SWCR |= CLK_SWCR_SWIEN;
1040  0105 721450c5      	bset	20677,#2
1042  0109 2004          	jra	L154
1043  010b               L744:
1044                     ; 349             CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWIEN);
1046  010b 721550c5      	bres	20677,#2
1047  010f               L154:
1048                     ; 353         CLK->SWR = (uint8_t)CLK_NewClock;
1050  010f 7b06          	ld	a,(OFST+2,sp)
1051  0111 c750c4        	ld	20676,a
1053  0114 2003          	jra	L754
1054  0116               L354:
1055                     ; 357             DownCounter--;
1057  0116 5a            	decw	x
1058  0117 1f03          	ldw	(OFST-1,sp),x
1060  0119               L754:
1061                     ; 355         while ((((CLK->SWCR & CLK_SWCR_SWBSY) != 0 )&& (DownCounter != 0)))
1063  0119 720150c504    	btjf	20677,#0,L364
1065  011e 1e03          	ldw	x,(OFST-1,sp)
1066  0120 26f4          	jrne	L354
1067  0122               L364:
1068                     ; 360         if (DownCounter != 0)
1070  0122 1e03          	ldw	x,(OFST-1,sp)
1071                     ; 362             Swif = SUCCESS;
1073  0124 2617          	jrne	LC004
1074                     ; 366             Swif = ERROR;
1076  0126 0f02          	clr	(OFST-2,sp)
1078  0128 2017          	jra	L174
1079  012a               L544:
1080                     ; 374         if (ITState != DISABLE)
1082  012a 7b09          	ld	a,(OFST+5,sp)
1083  012c 2706          	jreq	L374
1084                     ; 376             CLK->SWCR |= CLK_SWCR_SWIEN;
1086  012e 721450c5      	bset	20677,#2
1088  0132 2004          	jra	L574
1089  0134               L374:
1090                     ; 380             CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWIEN);
1092  0134 721550c5      	bres	20677,#2
1093  0138               L574:
1094                     ; 384         CLK->SWR = (uint8_t)CLK_NewClock;
1096  0138 7b06          	ld	a,(OFST+2,sp)
1097  013a c750c4        	ld	20676,a
1098                     ; 388         Swif = SUCCESS;
1100  013d               LC004:
1102  013d a601          	ld	a,#1
1103  013f 6b02          	ld	(OFST-2,sp),a
1105  0141               L174:
1106                     ; 393     if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_HSI))
1108  0141 7b0a          	ld	a,(OFST+6,sp)
1109  0143 260c          	jrne	L774
1111  0145 7b01          	ld	a,(OFST-3,sp)
1112  0147 a1e1          	cp	a,#225
1113  0149 2606          	jrne	L774
1114                     ; 395         CLK->ICKR &= (uint8_t)(~CLK_ICKR_HSIEN);
1116  014b 721150c0      	bres	20672,#0
1118  014f 201e          	jra	L105
1119  0151               L774:
1120                     ; 397     else if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_LSI))
1122  0151 7b0a          	ld	a,(OFST+6,sp)
1123  0153 260c          	jrne	L305
1125  0155 7b01          	ld	a,(OFST-3,sp)
1126  0157 a1d2          	cp	a,#210
1127  0159 2606          	jrne	L305
1128                     ; 399         CLK->ICKR &= (uint8_t)(~CLK_ICKR_LSIEN);
1130  015b 721750c0      	bres	20672,#3
1132  015f 200e          	jra	L105
1133  0161               L305:
1134                     ; 401     else if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_HSE))
1136  0161 7b0a          	ld	a,(OFST+6,sp)
1137  0163 260a          	jrne	L105
1139  0165 7b01          	ld	a,(OFST-3,sp)
1140  0167 a1b4          	cp	a,#180
1141  0169 2604          	jrne	L105
1142                     ; 403         CLK->ECKR &= (uint8_t)(~CLK_ECKR_HSEEN);
1144  016b 721150c1      	bres	20673,#0
1145  016f               L105:
1146                     ; 406     return(Swif);
1148  016f 7b02          	ld	a,(OFST-2,sp)
1151  0171 5b06          	addw	sp,#6
1152  0173 81            	ret	
1290                     ; 416 void CLK_HSIPrescalerConfig(CLK_Prescaler_TypeDef HSIPrescaler)
1290                     ; 417 {
1291                     	switch	.text
1292  0174               _CLK_HSIPrescalerConfig:
1294  0174 88            	push	a
1295       00000000      OFST:	set	0
1298                     ; 420     assert_param(IS_CLK_HSIPRESCALER_OK(HSIPrescaler));
1300                     ; 423     CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_HSIDIV);
1302  0175 c650c6        	ld	a,20678
1303  0178 a4e7          	and	a,#231
1304  017a c750c6        	ld	20678,a
1305                     ; 426     CLK->CKDIVR |= (uint8_t)HSIPrescaler;
1307  017d c650c6        	ld	a,20678
1308  0180 1a01          	or	a,(OFST+1,sp)
1309  0182 c750c6        	ld	20678,a
1310                     ; 428 }
1313  0185 84            	pop	a
1314  0186 81            	ret	
1449                     ; 439 void CLK_CCOConfig(CLK_Output_TypeDef CLK_CCO)
1449                     ; 440 {
1450                     	switch	.text
1451  0187               _CLK_CCOConfig:
1453  0187 88            	push	a
1454       00000000      OFST:	set	0
1457                     ; 443     assert_param(IS_CLK_OUTPUT_OK(CLK_CCO));
1459                     ; 446     CLK->CCOR &= (uint8_t)(~CLK_CCOR_CCOSEL);
1461  0188 c650c9        	ld	a,20681
1462  018b a4e1          	and	a,#225
1463  018d c750c9        	ld	20681,a
1464                     ; 449     CLK->CCOR |= (uint8_t)CLK_CCO;
1466  0190 c650c9        	ld	a,20681
1467  0193 1a01          	or	a,(OFST+1,sp)
1468  0195 c750c9        	ld	20681,a
1469                     ; 452     CLK->CCOR |= CLK_CCOR_CCOEN;
1471  0198 721050c9      	bset	20681,#0
1472                     ; 454 }
1475  019c 84            	pop	a
1476  019d 81            	ret	
1541                     ; 464 void CLK_ITConfig(CLK_IT_TypeDef CLK_IT, FunctionalState NewState)
1541                     ; 465 {
1542                     	switch	.text
1543  019e               _CLK_ITConfig:
1545  019e 89            	pushw	x
1546       00000000      OFST:	set	0
1549                     ; 468     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1551                     ; 469     assert_param(IS_CLK_IT_OK(CLK_IT));
1553                     ; 471     if (NewState != DISABLE)
1555  019f 9f            	ld	a,xl
1556  01a0 4d            	tnz	a
1557  01a1 2715          	jreq	L507
1558                     ; 473         switch (CLK_IT)
1560  01a3 9e            	ld	a,xh
1562                     ; 481         default:
1562                     ; 482             break;
1563  01a4 a00c          	sub	a,#12
1564  01a6 270a          	jreq	L146
1565  01a8 a010          	sub	a,#16
1566  01aa 2620          	jrne	L317
1567                     ; 475         case CLK_IT_SWIF: /* Enable the clock switch interrupt */
1567                     ; 476             CLK->SWCR |= CLK_SWCR_SWIEN;
1569  01ac 721450c5      	bset	20677,#2
1570                     ; 477             break;
1572  01b0 201a          	jra	L317
1573  01b2               L146:
1574                     ; 478         case CLK_IT_CSSD: /* Enable the clock security system detection interrupt */
1574                     ; 479             CLK->CSSR |= CLK_CSSR_CSSDIE;
1576  01b2 721450c8      	bset	20680,#2
1577                     ; 480             break;
1579  01b6 2014          	jra	L317
1580                     ; 481         default:
1580                     ; 482             break;
1583  01b8               L507:
1584                     ; 487         switch (CLK_IT)
1586  01b8 7b01          	ld	a,(OFST+1,sp)
1588                     ; 495         default:
1588                     ; 496             break;
1589  01ba a00c          	sub	a,#12
1590  01bc 270a          	jreq	L746
1591  01be a010          	sub	a,#16
1592  01c0 260a          	jrne	L317
1593                     ; 489         case CLK_IT_SWIF: /* Disable the clock switch interrupt */
1593                     ; 490             CLK->SWCR  &= (uint8_t)(~CLK_SWCR_SWIEN);
1595  01c2 721550c5      	bres	20677,#2
1596                     ; 491             break;
1598  01c6 2004          	jra	L317
1599  01c8               L746:
1600                     ; 492         case CLK_IT_CSSD: /* Disable the clock security system detection interrupt */
1600                     ; 493             CLK->CSSR &= (uint8_t)(~CLK_CSSR_CSSDIE);
1602  01c8 721550c8      	bres	20680,#2
1603                     ; 494             break;
1604  01cc               L317:
1605                     ; 500 }
1608  01cc 85            	popw	x
1609  01cd 81            	ret	
1610                     ; 495         default:
1610                     ; 496             break;
1646                     ; 507 void CLK_SYSCLKConfig(CLK_Prescaler_TypeDef CLK_Prescaler)
1646                     ; 508 {
1647                     	switch	.text
1648  01ce               _CLK_SYSCLKConfig:
1650  01ce 88            	push	a
1651       00000000      OFST:	set	0
1654                     ; 511     assert_param(IS_CLK_PRESCALER_OK(CLK_Prescaler));
1656                     ; 513     if (((uint8_t)CLK_Prescaler & (uint8_t)0x80) == 0x00) /* Bit7 = 0 means HSI divider */
1658  01cf a580          	bcp	a,#128
1659  01d1 260e          	jrne	L737
1660                     ; 515         CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_HSIDIV);
1662  01d3 c650c6        	ld	a,20678
1663  01d6 a4e7          	and	a,#231
1664  01d8 c750c6        	ld	20678,a
1665                     ; 516         CLK->CKDIVR |= (uint8_t)((uint8_t)CLK_Prescaler & (uint8_t)CLK_CKDIVR_HSIDIV);
1667  01db 7b01          	ld	a,(OFST+1,sp)
1668  01dd a418          	and	a,#24
1670  01df 200c          	jra	L147
1671  01e1               L737:
1672                     ; 520         CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_CPUDIV);
1674  01e1 c650c6        	ld	a,20678
1675  01e4 a4f8          	and	a,#248
1676  01e6 c750c6        	ld	20678,a
1677                     ; 521         CLK->CKDIVR |= (uint8_t)((uint8_t)CLK_Prescaler & (uint8_t)CLK_CKDIVR_CPUDIV);
1679  01e9 7b01          	ld	a,(OFST+1,sp)
1680  01eb a407          	and	a,#7
1681  01ed               L147:
1682  01ed ca50c6        	or	a,20678
1683  01f0 c750c6        	ld	20678,a
1684                     ; 524 }
1687  01f3 84            	pop	a
1688  01f4 81            	ret	
1744                     ; 531 void CLK_SWIMConfig(CLK_SWIMDivider_TypeDef CLK_SWIMDivider)
1744                     ; 532 {
1745                     	switch	.text
1746  01f5               _CLK_SWIMConfig:
1750                     ; 535     assert_param(IS_CLK_SWIMDIVIDER_OK(CLK_SWIMDivider));
1752                     ; 537     if (CLK_SWIMDivider != CLK_SWIMDIVIDER_2)
1754  01f5 4d            	tnz	a
1755  01f6 2705          	jreq	L177
1756                     ; 540         CLK->SWIMCCR |= CLK_SWIMCCR_SWIMDIV;
1758  01f8 721050cd      	bset	20685,#0
1761  01fc 81            	ret	
1762  01fd               L177:
1763                     ; 545         CLK->SWIMCCR &= (uint8_t)(~CLK_SWIMCCR_SWIMDIV);
1765  01fd 721150cd      	bres	20685,#0
1766                     ; 548 }
1769  0201 81            	ret	
1793                     ; 557 void CLK_ClockSecuritySystemEnable(void)
1793                     ; 558 {
1794                     	switch	.text
1795  0202               _CLK_ClockSecuritySystemEnable:
1799                     ; 560     CLK->CSSR |= CLK_CSSR_CSSEN;
1801  0202 721050c8      	bset	20680,#0
1802                     ; 561 }
1805  0206 81            	ret	
1830                     ; 569 CLK_Source_TypeDef CLK_GetSYSCLKSource(void)
1830                     ; 570 {
1831                     	switch	.text
1832  0207               _CLK_GetSYSCLKSource:
1836                     ; 571     return((CLK_Source_TypeDef)CLK->CMSR);
1838  0207 c650c3        	ld	a,20675
1841  020a 81            	ret	
1904                     ; 579 uint32_t CLK_GetClockFreq(void)
1904                     ; 580 {
1905                     	switch	.text
1906  020b               _CLK_GetClockFreq:
1908  020b 5209          	subw	sp,#9
1909       00000009      OFST:	set	9
1912                     ; 582     uint32_t clockfrequency = 0;
1914                     ; 583     CLK_Source_TypeDef clocksource = CLK_SOURCE_HSI;
1916                     ; 584     uint8_t tmp = 0, presc = 0;
1920                     ; 587     clocksource = (CLK_Source_TypeDef)CLK->CMSR;
1922  020d c650c3        	ld	a,20675
1923  0210 6b09          	ld	(OFST+0,sp),a
1925                     ; 589     if (clocksource == CLK_SOURCE_HSI)
1927  0212 a1e1          	cp	a,#225
1928  0214 2634          	jrne	L7401
1929                     ; 591         tmp = (uint8_t)(CLK->CKDIVR & CLK_CKDIVR_HSIDIV);
1931  0216 c650c6        	ld	a,20678
1932  0219 a418          	and	a,#24
1933  021b 44            	srl	a
1934  021c 44            	srl	a
1935  021d 44            	srl	a
1937                     ; 592         tmp = (uint8_t)(tmp >> 3);
1940                     ; 593         presc = HSIDivFactor[tmp];
1942  021e 5f            	clrw	x
1943  021f 97            	ld	xl,a
1944  0220 d60000        	ld	a,(_HSIDivFactor,x)
1945  0223 6b09          	ld	(OFST+0,sp),a
1947                     ; 594         clockfrequency = HSI_VALUE / presc;
1949  0225 b703          	ld	c_lreg+3,a
1950  0227 3f02          	clr	c_lreg+2
1951  0229 3f01          	clr	c_lreg+1
1952  022b 3f00          	clr	c_lreg
1953  022d 96            	ldw	x,sp
1954  022e 5c            	incw	x
1955  022f cd0000        	call	c_rtol
1958  0232 ae2400        	ldw	x,#9216
1959  0235 bf02          	ldw	c_lreg+2,x
1960  0237 ae00f4        	ldw	x,#244
1961  023a bf00          	ldw	c_lreg,x
1962  023c 96            	ldw	x,sp
1963  023d 5c            	incw	x
1964  023e cd0000        	call	c_ludv
1966  0241 96            	ldw	x,sp
1967  0242 1c0005        	addw	x,#OFST-4
1968  0245 cd0000        	call	c_rtol
1972  0248 2018          	jra	L1501
1973  024a               L7401:
1974                     ; 596     else if ( clocksource == CLK_SOURCE_LSI)
1976  024a a1d2          	cp	a,#210
1977  024c 260a          	jrne	L3501
1978                     ; 598         clockfrequency = LSI_VALUE;
1980  024e aef400        	ldw	x,#62464
1981  0251 1f07          	ldw	(OFST-2,sp),x
1982  0253 ae0001        	ldw	x,#1
1984  0256 2008          	jp	LC005
1985  0258               L3501:
1986                     ; 602         clockfrequency = HSE_VALUE;
1988  0258 ae2400        	ldw	x,#9216
1989  025b 1f07          	ldw	(OFST-2,sp),x
1990  025d ae00f4        	ldw	x,#244
1991  0260               LC005:
1992  0260 1f05          	ldw	(OFST-4,sp),x
1994  0262               L1501:
1995                     ; 605     return((uint32_t)clockfrequency);
1997  0262 96            	ldw	x,sp
1998  0263 1c0005        	addw	x,#OFST-4
1999  0266 cd0000        	call	c_ltor
2003  0269 5b09          	addw	sp,#9
2004  026b 81            	ret	
2103                     ; 616 void CLK_AdjustHSICalibrationValue(CLK_HSITrimValue_TypeDef CLK_HSICalibrationValue)
2103                     ; 617 {
2104                     	switch	.text
2105  026c               _CLK_AdjustHSICalibrationValue:
2107  026c 88            	push	a
2108       00000000      OFST:	set	0
2111                     ; 620     assert_param(IS_CLK_HSITRIMVALUE_OK(CLK_HSICalibrationValue));
2113                     ; 623     CLK->HSITRIMR = (uint8_t)( (uint8_t)(CLK->HSITRIMR & (uint8_t)(~CLK_HSITRIMR_HSITRIM))|((uint8_t)CLK_HSICalibrationValue));
2115  026d c650cc        	ld	a,20684
2116  0270 a4f8          	and	a,#248
2117  0272 1a01          	or	a,(OFST+1,sp)
2118  0274 c750cc        	ld	20684,a
2119                     ; 625 }
2122  0277 84            	pop	a
2123  0278 81            	ret	
2147                     ; 636 void CLK_SYSCLKEmergencyClear(void)
2147                     ; 637 {
2148                     	switch	.text
2149  0279               _CLK_SYSCLKEmergencyClear:
2153                     ; 638     CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWBSY);
2155  0279 721150c5      	bres	20677,#0
2156                     ; 639 }
2159  027d 81            	ret	
2312                     ; 648 FlagStatus CLK_GetFlagStatus(CLK_Flag_TypeDef CLK_FLAG)
2312                     ; 649 {
2313                     	switch	.text
2314  027e               _CLK_GetFlagStatus:
2316  027e 89            	pushw	x
2317  027f 5203          	subw	sp,#3
2318       00000003      OFST:	set	3
2321                     ; 651     uint16_t statusreg = 0;
2323                     ; 652     uint8_t tmpreg = 0;
2325                     ; 653     FlagStatus bitstatus = RESET;
2327                     ; 656     assert_param(IS_CLK_FLAG_OK(CLK_FLAG));
2329                     ; 659     statusreg = (uint16_t)((uint16_t)CLK_FLAG & (uint16_t)0xFF00);
2331  0281 01            	rrwa	x,a
2332  0282 4f            	clr	a
2333  0283 02            	rlwa	x,a
2334  0284 1f01          	ldw	(OFST-2,sp),x
2336                     ; 662     if (statusreg == 0x0100) /* The flag to check is in ICKRregister */
2338  0286 a30100        	cpw	x,#256
2339  0289 2605          	jrne	L1221
2340                     ; 664         tmpreg = CLK->ICKR;
2342  028b c650c0        	ld	a,20672
2344  028e 2021          	jra	L3221
2345  0290               L1221:
2346                     ; 666     else if (statusreg == 0x0200) /* The flag to check is in ECKRregister */
2348  0290 a30200        	cpw	x,#512
2349  0293 2605          	jrne	L5221
2350                     ; 668         tmpreg = CLK->ECKR;
2352  0295 c650c1        	ld	a,20673
2354  0298 2017          	jra	L3221
2355  029a               L5221:
2356                     ; 670     else if (statusreg == 0x0300) /* The flag to check is in SWIC register */
2358  029a a30300        	cpw	x,#768
2359  029d 2605          	jrne	L1321
2360                     ; 672         tmpreg = CLK->SWCR;
2362  029f c650c5        	ld	a,20677
2364  02a2 200d          	jra	L3221
2365  02a4               L1321:
2366                     ; 674     else if (statusreg == 0x0400) /* The flag to check is in CSS register */
2368  02a4 a30400        	cpw	x,#1024
2369  02a7 2605          	jrne	L5321
2370                     ; 676         tmpreg = CLK->CSSR;
2372  02a9 c650c8        	ld	a,20680
2374  02ac 2003          	jra	L3221
2375  02ae               L5321:
2376                     ; 680         tmpreg = CLK->CCOR;
2378  02ae c650c9        	ld	a,20681
2379  02b1               L3221:
2380  02b1 6b03          	ld	(OFST+0,sp),a
2382                     ; 683     if ((tmpreg & (uint8_t)CLK_FLAG) != (uint8_t)RESET)
2384  02b3 7b05          	ld	a,(OFST+2,sp)
2385  02b5 1503          	bcp	a,(OFST+0,sp)
2386  02b7 2704          	jreq	L1421
2387                     ; 685         bitstatus = SET;
2389  02b9 a601          	ld	a,#1
2392  02bb 2001          	jra	L3421
2393  02bd               L1421:
2394                     ; 689         bitstatus = RESET;
2396  02bd 4f            	clr	a
2398  02be               L3421:
2399                     ; 693     return((FlagStatus)bitstatus);
2403  02be 5b05          	addw	sp,#5
2404  02c0 81            	ret	
2450                     ; 703 ITStatus CLK_GetITStatus(CLK_IT_TypeDef CLK_IT)
2450                     ; 704 {
2451                     	switch	.text
2452  02c1               _CLK_GetITStatus:
2454  02c1 88            	push	a
2455  02c2 88            	push	a
2456       00000001      OFST:	set	1
2459                     ; 706     ITStatus bitstatus = RESET;
2461                     ; 709     assert_param(IS_CLK_IT_OK(CLK_IT));
2463                     ; 711     if (CLK_IT == CLK_IT_SWIF)
2465  02c3 a11c          	cp	a,#28
2466  02c5 2609          	jrne	L7621
2467                     ; 714         if ((CLK->SWCR & (uint8_t)CLK_IT) == (uint8_t)0x0C)
2469  02c7 c450c5        	and	a,20677
2470  02ca a10c          	cp	a,#12
2471  02cc 260f          	jrne	L7721
2472                     ; 716             bitstatus = SET;
2474  02ce 2009          	jp	LC007
2475                     ; 720             bitstatus = RESET;
2476  02d0               L7621:
2477                     ; 726         if ((CLK->CSSR & (uint8_t)CLK_IT) == (uint8_t)0x0C)
2479  02d0 c650c8        	ld	a,20680
2480  02d3 1402          	and	a,(OFST+1,sp)
2481  02d5 a10c          	cp	a,#12
2482  02d7 2604          	jrne	L7721
2483                     ; 728             bitstatus = SET;
2485  02d9               LC007:
2487  02d9 a601          	ld	a,#1
2490  02db 2001          	jra	L5721
2491  02dd               L7721:
2492                     ; 732             bitstatus = RESET;
2495  02dd 4f            	clr	a
2497  02de               L5721:
2498                     ; 737     return bitstatus;
2502  02de 85            	popw	x
2503  02df 81            	ret	
2539                     ; 747 void CLK_ClearITPendingBit(CLK_IT_TypeDef CLK_IT)
2539                     ; 748 {
2540                     	switch	.text
2541  02e0               _CLK_ClearITPendingBit:
2545                     ; 751     assert_param(IS_CLK_IT_OK(CLK_IT));
2547                     ; 753     if (CLK_IT == (uint8_t)CLK_IT_CSSD)
2549  02e0 a10c          	cp	a,#12
2550  02e2 2605          	jrne	L1231
2551                     ; 756         CLK->CSSR &= (uint8_t)(~CLK_CSSR_CSSD);
2553  02e4 721750c8      	bres	20680,#3
2556  02e8 81            	ret	
2557  02e9               L1231:
2558                     ; 761         CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWIF);
2560  02e9 721750c5      	bres	20677,#3
2561                     ; 764 }
2564  02ed 81            	ret	
2599                     	xdef	_CLKPrescTable
2600                     	xdef	_HSIDivFactor
2601                     	xdef	_CLK_ClearITPendingBit
2602                     	xdef	_CLK_GetITStatus
2603                     	xdef	_CLK_GetFlagStatus
2604                     	xdef	_CLK_GetSYSCLKSource
2605                     	xdef	_CLK_GetClockFreq
2606                     	xdef	_CLK_AdjustHSICalibrationValue
2607                     	xdef	_CLK_SYSCLKEmergencyClear
2608                     	xdef	_CLK_ClockSecuritySystemEnable
2609                     	xdef	_CLK_SWIMConfig
2610                     	xdef	_CLK_SYSCLKConfig
2611                     	xdef	_CLK_ITConfig
2612                     	xdef	_CLK_CCOConfig
2613                     	xdef	_CLK_HSIPrescalerConfig
2614                     	xdef	_CLK_ClockSwitchConfig
2615                     	xdef	_CLK_PeripheralClockConfig
2616                     	xdef	_CLK_SlowActiveHaltWakeUpCmd
2617                     	xdef	_CLK_FastHaltWakeUpCmd
2618                     	xdef	_CLK_ClockSwitchCmd
2619                     	xdef	_CLK_CCOCmd
2620                     	xdef	_CLK_LSICmd
2621                     	xdef	_CLK_HSICmd
2622                     	xdef	_CLK_HSECmd
2623                     	xdef	_CLK_DeInit
2624                     	xref.b	c_lreg
2625                     	xref.b	c_x
2644                     	xref	c_ltor
2645                     	xref	c_ludv
2646                     	xref	c_rtol
2647                     	end
