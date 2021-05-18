   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.1 - 30 Jun 2020
   3                     ; Generator (Limited) V4.4.12 - 02 Jul 2020
   4                     ; Optimizer V4.4.12 - 02 Jul 2020
  47                     ; 47 void UART2_DeInit(void)
  47                     ; 48 {
  49                     	switch	.text
  50  0000               _UART2_DeInit:
  54                     ; 51     (void) UART2->SR;
  56  0000 c65240        	ld	a,21056
  57                     ; 52     (void)UART2->DR;
  59  0003 c65241        	ld	a,21057
  60                     ; 54     UART2->BRR2 = UART2_BRR2_RESET_VALUE;  /*  Set UART2_BRR2 to reset value 0x00 */
  62  0006 725f5243      	clr	21059
  63                     ; 55     UART2->BRR1 = UART2_BRR1_RESET_VALUE;  /*  Set UART2_BRR1 to reset value 0x00 */
  65  000a 725f5242      	clr	21058
  66                     ; 57     UART2->CR1 = UART2_CR1_RESET_VALUE; /*  Set UART2_CR1 to reset value 0x00  */
  68  000e 725f5244      	clr	21060
  69                     ; 58     UART2->CR2 = UART2_CR2_RESET_VALUE; /*  Set UART2_CR2 to reset value 0x00  */
  71  0012 725f5245      	clr	21061
  72                     ; 59     UART2->CR3 = UART2_CR3_RESET_VALUE; /*  Set UART2_CR3 to reset value 0x00  */
  74  0016 725f5246      	clr	21062
  75                     ; 60     UART2->CR4 = UART2_CR4_RESET_VALUE; /*  Set UART2_CR4 to reset value 0x00  */
  77  001a 725f5247      	clr	21063
  78                     ; 61     UART2->CR5 = UART2_CR5_RESET_VALUE; /*  Set UART2_CR5 to reset value 0x00  */
  80  001e 725f5248      	clr	21064
  81                     ; 62     UART2->CR6 = UART2_CR6_RESET_VALUE; /*  Set UART2_CR6 to reset value 0x00  */
  83  0022 725f5249      	clr	21065
  84                     ; 64 }
  87  0026 81            	ret	
 408                     .const:	section	.text
 409  0000               L41:
 410  0000 00000064      	dc.l	100
 411                     ; 80 void UART2_Init(uint32_t BaudRate, UART2_WordLength_TypeDef WordLength, UART2_StopBits_TypeDef StopBits, UART2_Parity_TypeDef Parity, UART2_SyncMode_TypeDef SyncMode, UART2_Mode_TypeDef Mode)
 411                     ; 81 {
 412                     	switch	.text
 413  0027               _UART2_Init:
 415  0027 520e          	subw	sp,#14
 416       0000000e      OFST:	set	14
 419                     ; 82     uint8_t BRR2_1 = 0, BRR2_2 = 0;
 423                     ; 83     uint32_t BaudRate_Mantissa = 0, BaudRate_Mantissa100 = 0;
 427                     ; 86     assert_param(IS_UART2_BAUDRATE_OK(BaudRate));
 429                     ; 87     assert_param(IS_UART2_WORDLENGTH_OK(WordLength));
 431                     ; 88     assert_param(IS_UART2_STOPBITS_OK(StopBits));
 433                     ; 89     assert_param(IS_UART2_PARITY_OK(Parity));
 435                     ; 90     assert_param(IS_UART2_MODE_OK((uint8_t)Mode));
 437                     ; 91     assert_param(IS_UART2_SYNCMODE_OK((uint8_t)SyncMode));
 439                     ; 94     UART2->CR1 &= (uint8_t)(~UART2_CR1_M);
 441  0029 72195244      	bres	21060,#4
 442                     ; 96     UART2->CR1 |= (uint8_t)WordLength; 
 444  002d c65244        	ld	a,21060
 445  0030 1a15          	or	a,(OFST+7,sp)
 446  0032 c75244        	ld	21060,a
 447                     ; 99     UART2->CR3 &= (uint8_t)(~UART2_CR3_STOP);
 449  0035 c65246        	ld	a,21062
 450  0038 a4cf          	and	a,#207
 451  003a c75246        	ld	21062,a
 452                     ; 101     UART2->CR3 |= (uint8_t)StopBits; 
 454  003d c65246        	ld	a,21062
 455  0040 1a16          	or	a,(OFST+8,sp)
 456  0042 c75246        	ld	21062,a
 457                     ; 104     UART2->CR1 &= (uint8_t)(~(UART2_CR1_PCEN | UART2_CR1_PS  ));
 459  0045 c65244        	ld	a,21060
 460  0048 a4f9          	and	a,#249
 461  004a c75244        	ld	21060,a
 462                     ; 106     UART2->CR1 |= (uint8_t)Parity;
 464  004d c65244        	ld	a,21060
 465  0050 1a17          	or	a,(OFST+9,sp)
 466  0052 c75244        	ld	21060,a
 467                     ; 109     UART2->BRR1 &= (uint8_t)(~UART2_BRR1_DIVM);
 469  0055 725f5242      	clr	21058
 470                     ; 111     UART2->BRR2 &= (uint8_t)(~UART2_BRR2_DIVM);
 472  0059 c65243        	ld	a,21059
 473  005c a40f          	and	a,#15
 474  005e c75243        	ld	21059,a
 475                     ; 113     UART2->BRR2 &= (uint8_t)(~UART2_BRR2_DIVF);
 477  0061 c65243        	ld	a,21059
 478  0064 a4f0          	and	a,#240
 479  0066 c75243        	ld	21059,a
 480                     ; 116     BaudRate_Mantissa    = ((uint32_t)CLK_GetClockFreq() / (BaudRate << 4));
 482  0069 96            	ldw	x,sp
 483  006a cd013d        	call	LC001
 485  006d 96            	ldw	x,sp
 486  006e 5c            	incw	x
 487  006f cd0000        	call	c_rtol
 490  0072 cd0000        	call	_CLK_GetClockFreq
 492  0075 96            	ldw	x,sp
 493  0076 5c            	incw	x
 494  0077 cd0000        	call	c_ludv
 496  007a 96            	ldw	x,sp
 497  007b 1c000b        	addw	x,#OFST-3
 498  007e cd0000        	call	c_rtol
 501                     ; 117     BaudRate_Mantissa100 = (((uint32_t)CLK_GetClockFreq() * 100) / (BaudRate << 4));
 503  0081 96            	ldw	x,sp
 504  0082 cd013d        	call	LC001
 506  0085 96            	ldw	x,sp
 507  0086 5c            	incw	x
 508  0087 cd0000        	call	c_rtol
 511  008a cd0000        	call	_CLK_GetClockFreq
 513  008d a664          	ld	a,#100
 514  008f cd0000        	call	c_smul
 516  0092 96            	ldw	x,sp
 517  0093 5c            	incw	x
 518  0094 cd0000        	call	c_ludv
 520  0097 96            	ldw	x,sp
 521  0098 1c0007        	addw	x,#OFST-7
 522  009b cd0000        	call	c_rtol
 525                     ; 121     BRR2_1 = (uint8_t)((uint8_t)(((BaudRate_Mantissa100 - (BaudRate_Mantissa * 100))
 525                     ; 122                         << 4) / 100) & (uint8_t)0x0F); 
 527  009e 96            	ldw	x,sp
 528  009f 1c000b        	addw	x,#OFST-3
 529  00a2 cd0000        	call	c_ltor
 531  00a5 a664          	ld	a,#100
 532  00a7 cd0000        	call	c_smul
 534  00aa 96            	ldw	x,sp
 535  00ab 5c            	incw	x
 536  00ac cd0000        	call	c_rtol
 539  00af 96            	ldw	x,sp
 540  00b0 1c0007        	addw	x,#OFST-7
 541  00b3 cd0000        	call	c_ltor
 543  00b6 96            	ldw	x,sp
 544  00b7 5c            	incw	x
 545  00b8 cd0000        	call	c_lsub
 547  00bb a604          	ld	a,#4
 548  00bd cd0000        	call	c_llsh
 550  00c0 ae0000        	ldw	x,#L41
 551  00c3 cd0000        	call	c_ludv
 553  00c6 b603          	ld	a,c_lreg+3
 554  00c8 a40f          	and	a,#15
 555  00ca 6b05          	ld	(OFST-9,sp),a
 557                     ; 123     BRR2_2 = (uint8_t)((BaudRate_Mantissa >> 4) & (uint8_t)0xF0);
 559  00cc 96            	ldw	x,sp
 560  00cd 1c000b        	addw	x,#OFST-3
 561  00d0 cd0000        	call	c_ltor
 563  00d3 a604          	ld	a,#4
 564  00d5 cd0000        	call	c_lursh
 566  00d8 b603          	ld	a,c_lreg+3
 567  00da a4f0          	and	a,#240
 568  00dc b703          	ld	c_lreg+3,a
 569  00de 3f02          	clr	c_lreg+2
 570  00e0 3f01          	clr	c_lreg+1
 571  00e2 3f00          	clr	c_lreg
 572  00e4 6b06          	ld	(OFST-8,sp),a
 574                     ; 125     UART2->BRR2 = (uint8_t)(BRR2_1 | BRR2_2);
 576  00e6 1a05          	or	a,(OFST-9,sp)
 577  00e8 c75243        	ld	21059,a
 578                     ; 127     UART2->BRR1 = (uint8_t)BaudRate_Mantissa;           
 580  00eb 7b0e          	ld	a,(OFST+0,sp)
 581  00ed c75242        	ld	21058,a
 582                     ; 130     UART2->CR2 &= (uint8_t)~(UART2_CR2_TEN | UART2_CR2_REN);
 584  00f0 c65245        	ld	a,21061
 585  00f3 a4f3          	and	a,#243
 586  00f5 c75245        	ld	21061,a
 587                     ; 132     UART2->CR3 &= (uint8_t)~(UART2_CR3_CPOL | UART2_CR3_CPHA | UART2_CR3_LBCL);
 589  00f8 c65246        	ld	a,21062
 590  00fb a4f8          	and	a,#248
 591  00fd c75246        	ld	21062,a
 592                     ; 134     UART2->CR3 |= (uint8_t)((uint8_t)SyncMode & (uint8_t)(UART2_CR3_CPOL | \
 592                     ; 135                                               UART2_CR3_CPHA | UART2_CR3_LBCL));
 594  0100 7b18          	ld	a,(OFST+10,sp)
 595  0102 a407          	and	a,#7
 596  0104 ca5246        	or	a,21062
 597  0107 c75246        	ld	21062,a
 598                     ; 137     if ((uint8_t)(Mode & UART2_MODE_TX_ENABLE))
 600  010a 7b19          	ld	a,(OFST+11,sp)
 601  010c a504          	bcp	a,#4
 602  010e 2706          	jreq	L302
 603                     ; 140         UART2->CR2 |= (uint8_t)UART2_CR2_TEN;
 605  0110 72165245      	bset	21061,#3
 607  0114 2004          	jra	L502
 608  0116               L302:
 609                     ; 145         UART2->CR2 &= (uint8_t)(~UART2_CR2_TEN);
 611  0116 72175245      	bres	21061,#3
 612  011a               L502:
 613                     ; 147     if ((uint8_t)(Mode & UART2_MODE_RX_ENABLE))
 615  011a a508          	bcp	a,#8
 616  011c 2706          	jreq	L702
 617                     ; 150         UART2->CR2 |= (uint8_t)UART2_CR2_REN;
 619  011e 72145245      	bset	21061,#2
 621  0122 2004          	jra	L112
 622  0124               L702:
 623                     ; 155         UART2->CR2 &= (uint8_t)(~UART2_CR2_REN);
 625  0124 72155245      	bres	21061,#2
 626  0128               L112:
 627                     ; 159     if ((uint8_t)(SyncMode & UART2_SYNCMODE_CLOCK_DISABLE))
 629  0128 7b18          	ld	a,(OFST+10,sp)
 630  012a 2a06          	jrpl	L312
 631                     ; 162         UART2->CR3 &= (uint8_t)(~UART2_CR3_CKEN); 
 633  012c 72175246      	bres	21062,#3
 635  0130 2008          	jra	L512
 636  0132               L312:
 637                     ; 166         UART2->CR3 |= (uint8_t)((uint8_t)SyncMode & UART2_CR3_CKEN);
 639  0132 a408          	and	a,#8
 640  0134 ca5246        	or	a,21062
 641  0137 c75246        	ld	21062,a
 642  013a               L512:
 643                     ; 168 }
 646  013a 5b0e          	addw	sp,#14
 647  013c 81            	ret	
 648  013d               LC001:
 649  013d 1c0011        	addw	x,#OFST+3
 650  0140 cd0000        	call	c_ltor
 652  0143 a604          	ld	a,#4
 653  0145 cc0000        	jp	c_llsh
 708                     ; 176 void UART2_Cmd(FunctionalState NewState)
 708                     ; 177 {
 709                     	switch	.text
 710  0148               _UART2_Cmd:
 714                     ; 179     if (NewState != DISABLE)
 716  0148 4d            	tnz	a
 717  0149 2705          	jreq	L542
 718                     ; 182         UART2->CR1 &= (uint8_t)(~UART2_CR1_UARTD);
 720  014b 721b5244      	bres	21060,#5
 723  014f 81            	ret	
 724  0150               L542:
 725                     ; 187         UART2->CR1 |= UART2_CR1_UARTD; 
 727  0150 721a5244      	bset	21060,#5
 728                     ; 189 }
 731  0154 81            	ret	
 863                     ; 206 void UART2_ITConfig(UART2_IT_TypeDef UART2_IT, FunctionalState NewState)
 863                     ; 207 {
 864                     	switch	.text
 865  0155               _UART2_ITConfig:
 867  0155 89            	pushw	x
 868  0156 89            	pushw	x
 869       00000002      OFST:	set	2
 872                     ; 208     uint8_t uartreg = 0, itpos = 0x00;
 876                     ; 211     assert_param(IS_UART2_CONFIG_IT_OK(UART2_IT));
 878                     ; 212     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 880                     ; 215     uartreg = (uint8_t)((uint16_t)UART2_IT >> 0x08);
 882  0157 9e            	ld	a,xh
 883  0158 6b01          	ld	(OFST-1,sp),a
 885                     ; 218     itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)UART2_IT & (uint8_t)0x0F));
 887  015a 9f            	ld	a,xl
 888  015b a40f          	and	a,#15
 889  015d 5f            	clrw	x
 890  015e 97            	ld	xl,a
 891  015f a601          	ld	a,#1
 892  0161 5d            	tnzw	x
 893  0162 2704          	jreq	L22
 894  0164               L42:
 895  0164 48            	sll	a
 896  0165 5a            	decw	x
 897  0166 26fc          	jrne	L42
 898  0168               L22:
 899  0168 6b02          	ld	(OFST+0,sp),a
 901                     ; 220     if (NewState != DISABLE)
 903  016a 7b07          	ld	a,(OFST+5,sp)
 904  016c 272a          	jreq	L133
 905                     ; 223         if (uartreg == 0x01)
 907  016e 7b01          	ld	a,(OFST-1,sp)
 908  0170 a101          	cp	a,#1
 909  0172 2607          	jrne	L333
 910                     ; 225             UART2->CR1 |= itpos;
 912  0174 c65244        	ld	a,21060
 913  0177 1a02          	or	a,(OFST+0,sp)
 915  0179 2029          	jp	LC004
 916  017b               L333:
 917                     ; 227         else if (uartreg == 0x02)
 919  017b a102          	cp	a,#2
 920  017d 2607          	jrne	L733
 921                     ; 229             UART2->CR2 |= itpos;
 923  017f c65245        	ld	a,21061
 924  0182 1a02          	or	a,(OFST+0,sp)
 926  0184 202d          	jp	LC003
 927  0186               L733:
 928                     ; 231         else if (uartreg == 0x03)
 930  0186 a103          	cp	a,#3
 931  0188 2607          	jrne	L343
 932                     ; 233             UART2->CR4 |= itpos;
 934  018a c65247        	ld	a,21063
 935  018d 1a02          	or	a,(OFST+0,sp)
 937  018f 2031          	jp	LC005
 938  0191               L343:
 939                     ; 237             UART2->CR6 |= itpos;
 941  0191 c65249        	ld	a,21065
 942  0194 1a02          	or	a,(OFST+0,sp)
 943  0196 2035          	jp	LC002
 944  0198               L133:
 945                     ; 243         if (uartreg == 0x01)
 947  0198 7b01          	ld	a,(OFST-1,sp)
 948  019a a101          	cp	a,#1
 949  019c 260b          	jrne	L153
 950                     ; 245             UART2->CR1 &= (uint8_t)(~itpos);
 952  019e 7b02          	ld	a,(OFST+0,sp)
 953  01a0 43            	cpl	a
 954  01a1 c45244        	and	a,21060
 955  01a4               LC004:
 956  01a4 c75244        	ld	21060,a
 958  01a7 2027          	jra	L743
 959  01a9               L153:
 960                     ; 247         else if (uartreg == 0x02)
 962  01a9 a102          	cp	a,#2
 963  01ab 260b          	jrne	L553
 964                     ; 249             UART2->CR2 &= (uint8_t)(~itpos);
 966  01ad 7b02          	ld	a,(OFST+0,sp)
 967  01af 43            	cpl	a
 968  01b0 c45245        	and	a,21061
 969  01b3               LC003:
 970  01b3 c75245        	ld	21061,a
 972  01b6 2018          	jra	L743
 973  01b8               L553:
 974                     ; 251         else if (uartreg == 0x03)
 976  01b8 a103          	cp	a,#3
 977  01ba 260b          	jrne	L163
 978                     ; 253             UART2->CR4 &= (uint8_t)(~itpos);
 980  01bc 7b02          	ld	a,(OFST+0,sp)
 981  01be 43            	cpl	a
 982  01bf c45247        	and	a,21063
 983  01c2               LC005:
 984  01c2 c75247        	ld	21063,a
 986  01c5 2009          	jra	L743
 987  01c7               L163:
 988                     ; 257             UART2->CR6 &= (uint8_t)(~itpos);
 990  01c7 7b02          	ld	a,(OFST+0,sp)
 991  01c9 43            	cpl	a
 992  01ca c45249        	and	a,21065
 993  01cd               LC002:
 994  01cd c75249        	ld	21065,a
 995  01d0               L743:
 996                     ; 260 }
 999  01d0 5b04          	addw	sp,#4
1000  01d2 81            	ret	
1057                     ; 267 void UART2_IrDAConfig(UART2_IrDAMode_TypeDef UART2_IrDAMode)
1057                     ; 268 {
1058                     	switch	.text
1059  01d3               _UART2_IrDAConfig:
1063                     ; 269     assert_param(IS_UART2_IRDAMODE_OK(UART2_IrDAMode));
1065                     ; 271     if (UART2_IrDAMode != UART2_IRDAMODE_NORMAL)
1067  01d3 4d            	tnz	a
1068  01d4 2705          	jreq	L314
1069                     ; 273         UART2->CR5 |= UART2_CR5_IRLP;
1071  01d6 72145248      	bset	21064,#2
1074  01da 81            	ret	
1075  01db               L314:
1076                     ; 277         UART2->CR5 &= ((uint8_t)~UART2_CR5_IRLP);
1078  01db 72155248      	bres	21064,#2
1079                     ; 279 }
1082  01df 81            	ret	
1117                     ; 287 void UART2_IrDACmd(FunctionalState NewState)
1117                     ; 288 {
1118                     	switch	.text
1119  01e0               _UART2_IrDACmd:
1123                     ; 290     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1125                     ; 292     if (NewState != DISABLE)
1127  01e0 4d            	tnz	a
1128  01e1 2705          	jreq	L534
1129                     ; 295         UART2->CR5 |= UART2_CR5_IREN;
1131  01e3 72125248      	bset	21064,#1
1134  01e7 81            	ret	
1135  01e8               L534:
1136                     ; 300         UART2->CR5 &= ((uint8_t)~UART2_CR5_IREN);
1138  01e8 72135248      	bres	21064,#1
1139                     ; 302 }
1142  01ec 81            	ret	
1201                     ; 311 void UART2_LINBreakDetectionConfig(UART2_LINBreakDetectionLength_TypeDef UART2_LINBreakDetectionLength)
1201                     ; 312 {
1202                     	switch	.text
1203  01ed               _UART2_LINBreakDetectionConfig:
1207                     ; 314     assert_param(IS_UART2_LINBREAKDETECTIONLENGTH_OK(UART2_LINBreakDetectionLength));
1209                     ; 316     if (UART2_LINBreakDetectionLength != UART2_LINBREAKDETECTIONLENGTH_10BITS)
1211  01ed 4d            	tnz	a
1212  01ee 2705          	jreq	L764
1213                     ; 318         UART2->CR4 |= UART2_CR4_LBDL;
1215  01f0 721a5247      	bset	21063,#5
1218  01f4 81            	ret	
1219  01f5               L764:
1220                     ; 322         UART2->CR4 &= ((uint8_t)~UART2_CR4_LBDL);
1222  01f5 721b5247      	bres	21063,#5
1223                     ; 324 }
1226  01f9 81            	ret	
1347                     ; 336 void UART2_LINConfig(UART2_LinMode_TypeDef UART2_Mode, 
1347                     ; 337                      UART2_LinAutosync_TypeDef UART2_Autosync, 
1347                     ; 338                      UART2_LinDivUp_TypeDef UART2_DivUp)
1347                     ; 339 {
1348                     	switch	.text
1349  01fa               _UART2_LINConfig:
1351  01fa 89            	pushw	x
1352       00000000      OFST:	set	0
1355                     ; 341     assert_param(IS_UART2_SLAVE_OK(UART2_Mode));
1357                     ; 342     assert_param(IS_UART2_AUTOSYNC_OK(UART2_Autosync));
1359                     ; 343     assert_param(IS_UART2_DIVUP_OK(UART2_DivUp));
1361                     ; 345     if (UART2_Mode != UART2_LIN_MODE_MASTER)
1363  01fb 9e            	ld	a,xh
1364  01fc 4d            	tnz	a
1365  01fd 2706          	jreq	L155
1366                     ; 347         UART2->CR6 |=  UART2_CR6_LSLV;
1368  01ff 721a5249      	bset	21065,#5
1370  0203 2004          	jra	L355
1371  0205               L155:
1372                     ; 351         UART2->CR6 &= ((uint8_t)~UART2_CR6_LSLV);
1374  0205 721b5249      	bres	21065,#5
1375  0209               L355:
1376                     ; 354     if (UART2_Autosync != UART2_LIN_AUTOSYNC_DISABLE)
1378  0209 7b02          	ld	a,(OFST+2,sp)
1379  020b 2706          	jreq	L555
1380                     ; 356         UART2->CR6 |=  UART2_CR6_LASE ;
1382  020d 72185249      	bset	21065,#4
1384  0211 2004          	jra	L755
1385  0213               L555:
1386                     ; 360         UART2->CR6 &= ((uint8_t)~ UART2_CR6_LASE );
1388  0213 72195249      	bres	21065,#4
1389  0217               L755:
1390                     ; 363     if (UART2_DivUp != UART2_LIN_DIVUP_LBRR1)
1392  0217 7b05          	ld	a,(OFST+5,sp)
1393  0219 2706          	jreq	L165
1394                     ; 365         UART2->CR6 |=  UART2_CR6_LDUM;
1396  021b 721e5249      	bset	21065,#7
1398  021f 2004          	jra	L365
1399  0221               L165:
1400                     ; 369         UART2->CR6 &= ((uint8_t)~ UART2_CR6_LDUM);
1402  0221 721f5249      	bres	21065,#7
1403  0225               L365:
1404                     ; 371 }
1407  0225 85            	popw	x
1408  0226 81            	ret	
1443                     ; 379 void UART2_LINCmd(FunctionalState NewState)
1443                     ; 380 {
1444                     	switch	.text
1445  0227               _UART2_LINCmd:
1449                     ; 381     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1451                     ; 383     if (NewState != DISABLE)
1453  0227 4d            	tnz	a
1454  0228 2705          	jreq	L306
1455                     ; 386         UART2->CR3 |= UART2_CR3_LINEN;
1457  022a 721c5246      	bset	21062,#6
1460  022e 81            	ret	
1461  022f               L306:
1462                     ; 391         UART2->CR3 &= ((uint8_t)~UART2_CR3_LINEN);
1464  022f 721d5246      	bres	21062,#6
1465                     ; 393 }
1468  0233 81            	ret	
1503                     ; 400 void UART2_SmartCardCmd(FunctionalState NewState)
1503                     ; 401 {
1504                     	switch	.text
1505  0234               _UART2_SmartCardCmd:
1509                     ; 403     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1511                     ; 405     if (NewState != DISABLE)
1513  0234 4d            	tnz	a
1514  0235 2705          	jreq	L526
1515                     ; 408         UART2->CR5 |= UART2_CR5_SCEN;
1517  0237 721a5248      	bset	21064,#5
1520  023b 81            	ret	
1521  023c               L526:
1522                     ; 413         UART2->CR5 &= ((uint8_t)(~UART2_CR5_SCEN));
1524  023c 721b5248      	bres	21064,#5
1525                     ; 415 }
1528  0240 81            	ret	
1564                     ; 423 void UART2_SmartCardNACKCmd(FunctionalState NewState)
1564                     ; 424 {
1565                     	switch	.text
1566  0241               _UART2_SmartCardNACKCmd:
1570                     ; 426     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1572                     ; 428     if (NewState != DISABLE)
1574  0241 4d            	tnz	a
1575  0242 2705          	jreq	L746
1576                     ; 431         UART2->CR5 |= UART2_CR5_NACK;
1578  0244 72185248      	bset	21064,#4
1581  0248 81            	ret	
1582  0249               L746:
1583                     ; 436         UART2->CR5 &= ((uint8_t)~(UART2_CR5_NACK));
1585  0249 72195248      	bres	21064,#4
1586                     ; 438 }
1589  024d 81            	ret	
1646                     ; 446 void UART2_WakeUpConfig(UART2_WakeUp_TypeDef UART2_WakeUp)
1646                     ; 447 {
1647                     	switch	.text
1648  024e               _UART2_WakeUpConfig:
1652                     ; 448     assert_param(IS_UART2_WAKEUP_OK(UART2_WakeUp));
1654                     ; 450     UART2->CR1 &= ((uint8_t)~UART2_CR1_WAKE);
1656  024e 72175244      	bres	21060,#3
1657                     ; 451     UART2->CR1 |= (uint8_t)UART2_WakeUp;
1659  0252 ca5244        	or	a,21060
1660  0255 c75244        	ld	21060,a
1661                     ; 452 }
1664  0258 81            	ret	
1700                     ; 460 void UART2_ReceiverWakeUpCmd(FunctionalState NewState)
1700                     ; 461 {
1701                     	switch	.text
1702  0259               _UART2_ReceiverWakeUpCmd:
1706                     ; 462     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1708                     ; 464     if (NewState != DISABLE)
1710  0259 4d            	tnz	a
1711  025a 2705          	jreq	L717
1712                     ; 467         UART2->CR2 |= UART2_CR2_RWU;
1714  025c 72125245      	bset	21061,#1
1717  0260 81            	ret	
1718  0261               L717:
1719                     ; 472         UART2->CR2 &= ((uint8_t)~UART2_CR2_RWU);
1721  0261 72135245      	bres	21061,#1
1722                     ; 474 }
1725  0265 81            	ret	
1748                     ; 481 uint8_t UART2_ReceiveData8(void)
1748                     ; 482 {
1749                     	switch	.text
1750  0266               _UART2_ReceiveData8:
1754                     ; 483     return ((uint8_t)UART2->DR);
1756  0266 c65241        	ld	a,21057
1759  0269 81            	ret	
1793                     ; 491 uint16_t UART2_ReceiveData9(void)
1793                     ; 492 {
1794                     	switch	.text
1795  026a               _UART2_ReceiveData9:
1797  026a 89            	pushw	x
1798       00000002      OFST:	set	2
1801                     ; 493   uint16_t temp = 0;
1803                     ; 495   temp = ((uint16_t)(((uint16_t)((uint16_t)UART2->CR1 & (uint16_t)UART2_CR1_R8)) << 1));
1805  026b c65244        	ld	a,21060
1806  026e a480          	and	a,#128
1807  0270 5f            	clrw	x
1808  0271 02            	rlwa	x,a
1809  0272 58            	sllw	x
1810  0273 1f01          	ldw	(OFST-1,sp),x
1812                     ; 497   return (uint16_t)((((uint16_t)UART2->DR) | temp) & ((uint16_t)0x01FF));
1814  0275 c65241        	ld	a,21057
1815  0278 5f            	clrw	x
1816  0279 97            	ld	xl,a
1817  027a 01            	rrwa	x,a
1818  027b 1a02          	or	a,(OFST+0,sp)
1819  027d 01            	rrwa	x,a
1820  027e 1a01          	or	a,(OFST-1,sp)
1821  0280 a401          	and	a,#1
1822  0282 01            	rrwa	x,a
1825  0283 5b02          	addw	sp,#2
1826  0285 81            	ret	
1860                     ; 505 void UART2_SendData8(uint8_t Data)
1860                     ; 506 {
1861                     	switch	.text
1862  0286               _UART2_SendData8:
1866                     ; 508     UART2->DR = Data;
1868  0286 c75241        	ld	21057,a
1869                     ; 509 }
1872  0289 81            	ret	
1906                     ; 516 void UART2_SendData9(uint16_t Data)
1906                     ; 517 {
1907                     	switch	.text
1908  028a               _UART2_SendData9:
1910  028a 89            	pushw	x
1911       00000000      OFST:	set	0
1914                     ; 519     UART2->CR1 &= ((uint8_t)~UART2_CR1_T8);                  
1916  028b 721d5244      	bres	21060,#6
1917                     ; 522     UART2->CR1 |= (uint8_t)(((uint8_t)(Data >> 2)) & UART2_CR1_T8); 
1919  028f 54            	srlw	x
1920  0290 54            	srlw	x
1921  0291 9f            	ld	a,xl
1922  0292 a440          	and	a,#64
1923  0294 ca5244        	or	a,21060
1924  0297 c75244        	ld	21060,a
1925                     ; 525     UART2->DR   = (uint8_t)(Data);                    
1927  029a 7b02          	ld	a,(OFST+2,sp)
1928  029c c75241        	ld	21057,a
1929                     ; 527 }
1932  029f 85            	popw	x
1933  02a0 81            	ret	
1956                     ; 534 void UART2_SendBreak(void)
1956                     ; 535 {
1957                     	switch	.text
1958  02a1               _UART2_SendBreak:
1962                     ; 536     UART2->CR2 |= UART2_CR2_SBK;
1964  02a1 72105245      	bset	21061,#0
1965                     ; 537 }
1968  02a5 81            	ret	
2002                     ; 544 void UART2_SetAddress(uint8_t UART2_Address)
2002                     ; 545 {
2003                     	switch	.text
2004  02a6               _UART2_SetAddress:
2006  02a6 88            	push	a
2007       00000000      OFST:	set	0
2010                     ; 547     assert_param(IS_UART2_ADDRESS_OK(UART2_Address));
2012                     ; 550     UART2->CR4 &= ((uint8_t)~UART2_CR4_ADD);
2014  02a7 c65247        	ld	a,21063
2015  02aa a4f0          	and	a,#240
2016  02ac c75247        	ld	21063,a
2017                     ; 552     UART2->CR4 |= UART2_Address;
2019  02af c65247        	ld	a,21063
2020  02b2 1a01          	or	a,(OFST+1,sp)
2021  02b4 c75247        	ld	21063,a
2022                     ; 553 }
2025  02b7 84            	pop	a
2026  02b8 81            	ret	
2060                     ; 561 void UART2_SetGuardTime(uint8_t UART2_GuardTime)
2060                     ; 562 {
2061                     	switch	.text
2062  02b9               _UART2_SetGuardTime:
2066                     ; 564     UART2->GTR = UART2_GuardTime;
2068  02b9 c7524a        	ld	21066,a
2069                     ; 565 }
2072  02bc 81            	ret	
2106                     ; 589 void UART2_SetPrescaler(uint8_t UART2_Prescaler)
2106                     ; 590 {
2107                     	switch	.text
2108  02bd               _UART2_SetPrescaler:
2112                     ; 592     UART2->PSCR = UART2_Prescaler;
2114  02bd c7524b        	ld	21067,a
2115                     ; 593 }
2118  02c0 81            	ret	
2275                     ; 601 FlagStatus UART2_GetFlagStatus(UART2_Flag_TypeDef UART2_FLAG)
2275                     ; 602 {
2276                     	switch	.text
2277  02c1               _UART2_GetFlagStatus:
2279  02c1 89            	pushw	x
2280  02c2 88            	push	a
2281       00000001      OFST:	set	1
2284                     ; 603     FlagStatus status = RESET;
2286                     ; 606     assert_param(IS_UART2_FLAG_OK(UART2_FLAG));
2288                     ; 609     if (UART2_FLAG == UART2_FLAG_LBDF)
2290  02c3 a30210        	cpw	x,#528
2291  02c6 2608          	jrne	L5511
2292                     ; 611         if ((UART2->CR4 & (uint8_t)UART2_FLAG) != (uint8_t)0x00)
2294  02c8 9f            	ld	a,xl
2295  02c9 c45247        	and	a,21063
2296  02cc 2726          	jreq	L3611
2297                     ; 614             status = SET;
2299  02ce 201f          	jp	LC008
2300                     ; 619             status = RESET;
2301  02d0               L5511:
2302                     ; 622     else if (UART2_FLAG == UART2_FLAG_SBK)
2304  02d0 a30101        	cpw	x,#257
2305  02d3 2609          	jrne	L5611
2306                     ; 624         if ((UART2->CR2 & (uint8_t)UART2_FLAG) != (uint8_t)0x00)
2308  02d5 c65245        	ld	a,21061
2309  02d8 1503          	bcp	a,(OFST+2,sp)
2310  02da 2717          	jreq	L1021
2311                     ; 627             status = SET;
2313  02dc 2011          	jp	LC008
2314                     ; 632             status = RESET;
2315  02de               L5611:
2316                     ; 635     else if ((UART2_FLAG == UART2_FLAG_LHDF) || (UART2_FLAG == UART2_FLAG_LSF))
2318  02de a30302        	cpw	x,#770
2319  02e1 2705          	jreq	L7711
2321  02e3 a30301        	cpw	x,#769
2322  02e6 260f          	jrne	L5711
2323  02e8               L7711:
2324                     ; 637         if ((UART2->CR6 & (uint8_t)UART2_FLAG) != (uint8_t)0x00)
2326  02e8 c65249        	ld	a,21065
2327  02eb 1503          	bcp	a,(OFST+2,sp)
2328  02ed 2704          	jreq	L1021
2329                     ; 640             status = SET;
2331  02ef               LC008:
2335  02ef a601          	ld	a,#1
2339  02f1 2001          	jra	L3611
2340  02f3               L1021:
2341                     ; 645             status = RESET;
2345  02f3 4f            	clr	a
2347  02f4               L3611:
2348                     ; 663     return  status;
2352  02f4 5b03          	addw	sp,#3
2353  02f6 81            	ret	
2354  02f7               L5711:
2355                     ; 650         if ((UART2->SR & (uint8_t)UART2_FLAG) != (uint8_t)0x00)
2357  02f7 c65240        	ld	a,21056
2358  02fa 1503          	bcp	a,(OFST+2,sp)
2359  02fc 27f5          	jreq	L1021
2360                     ; 653             status = SET;
2362  02fe 20ef          	jp	LC008
2363                     ; 658             status = RESET;
2398                     ; 693 void UART2_ClearFlag(UART2_Flag_TypeDef UART2_FLAG)
2398                     ; 694 {
2399                     	switch	.text
2400  0300               _UART2_ClearFlag:
2402       00000000      OFST:	set	0
2405                     ; 695     assert_param(IS_UART2_CLEAR_FLAG_OK(UART2_FLAG));
2407                     ; 698     if (UART2_FLAG == UART2_FLAG_RXNE)
2409  0300 a30020        	cpw	x,#32
2410  0303 2605          	jrne	L1321
2411                     ; 700         UART2->SR = (uint8_t)~(UART2_SR_RXNE);
2413  0305 35df5240      	mov	21056,#223
2416  0309 81            	ret	
2417  030a               L1321:
2418                     ; 703     else if (UART2_FLAG == UART2_FLAG_LBDF)
2420  030a a30210        	cpw	x,#528
2421  030d 2605          	jrne	L5321
2422                     ; 705         UART2->CR4 &= (uint8_t)(~UART2_CR4_LBDF);
2424  030f 72195247      	bres	21063,#4
2427  0313 81            	ret	
2428  0314               L5321:
2429                     ; 708     else if (UART2_FLAG == UART2_FLAG_LHDF)
2431  0314 a30302        	cpw	x,#770
2432  0317 2605          	jrne	L1421
2433                     ; 710         UART2->CR6 &= (uint8_t)(~UART2_CR6_LHDF);
2435  0319 72135249      	bres	21065,#1
2438  031d 81            	ret	
2439  031e               L1421:
2440                     ; 715         UART2->CR6 &= (uint8_t)(~UART2_CR6_LSF);
2442  031e 72115249      	bres	21065,#0
2443                     ; 717 }
2446  0322 81            	ret	
2528                     ; 732 ITStatus UART2_GetITStatus(UART2_IT_TypeDef UART2_IT)
2528                     ; 733 {
2529                     	switch	.text
2530  0323               _UART2_GetITStatus:
2532  0323 89            	pushw	x
2533  0324 89            	pushw	x
2534       00000002      OFST:	set	2
2537                     ; 734     ITStatus pendingbitstatus = RESET;
2539                     ; 735     uint8_t itpos = 0;
2541                     ; 736     uint8_t itmask1 = 0;
2543                     ; 737     uint8_t itmask2 = 0;
2545                     ; 738     uint8_t enablestatus = 0;
2547                     ; 741     assert_param(IS_UART2_GET_IT_OK(UART2_IT));
2549                     ; 744     itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)UART2_IT & (uint8_t)0x0F));
2551  0325 9f            	ld	a,xl
2552  0326 a40f          	and	a,#15
2553  0328 5f            	clrw	x
2554  0329 97            	ld	xl,a
2555  032a a601          	ld	a,#1
2556  032c 5d            	tnzw	x
2557  032d 2704          	jreq	L67
2558  032f               L001:
2559  032f 48            	sll	a
2560  0330 5a            	decw	x
2561  0331 26fc          	jrne	L001
2562  0333               L67:
2563  0333 6b01          	ld	(OFST-1,sp),a
2565                     ; 746     itmask1 = (uint8_t)((uint8_t)UART2_IT >> (uint8_t)4);
2567  0335 7b04          	ld	a,(OFST+2,sp)
2568  0337 4e            	swap	a
2569  0338 a40f          	and	a,#15
2570  033a 6b02          	ld	(OFST+0,sp),a
2572                     ; 748     itmask2 = (uint8_t)((uint8_t)1 << itmask1);
2574  033c 5f            	clrw	x
2575  033d 97            	ld	xl,a
2576  033e a601          	ld	a,#1
2577  0340 5d            	tnzw	x
2578  0341 2704          	jreq	L201
2579  0343               L401:
2580  0343 48            	sll	a
2581  0344 5a            	decw	x
2582  0345 26fc          	jrne	L401
2583  0347               L201:
2584  0347 6b02          	ld	(OFST+0,sp),a
2586                     ; 751     if (UART2_IT == UART2_IT_PE)
2588  0349 1e03          	ldw	x,(OFST+1,sp)
2589  034b a30100        	cpw	x,#256
2590  034e 260c          	jrne	L7031
2591                     ; 754         enablestatus = (uint8_t)((uint8_t)UART2->CR1 & itmask2);
2593  0350 c65244        	ld	a,21060
2594  0353 1402          	and	a,(OFST+0,sp)
2595  0355 6b02          	ld	(OFST+0,sp),a
2597                     ; 757         if (((UART2->SR & itpos) != (uint8_t)0x00) && enablestatus)
2599  0357 c65240        	ld	a,21056
2601                     ; 760             pendingbitstatus = SET;
2603  035a 2020          	jp	LC011
2604                     ; 765             pendingbitstatus = RESET;
2605  035c               L7031:
2606                     ; 768     else if (UART2_IT == UART2_IT_LBDF)
2608  035c a30346        	cpw	x,#838
2609  035f 260c          	jrne	L7131
2610                     ; 771         enablestatus = (uint8_t)((uint8_t)UART2->CR4 & itmask2);
2612  0361 c65247        	ld	a,21063
2613  0364 1402          	and	a,(OFST+0,sp)
2614  0366 6b02          	ld	(OFST+0,sp),a
2616                     ; 773         if (((UART2->CR4 & itpos) != (uint8_t)0x00) && enablestatus)
2618  0368 c65247        	ld	a,21063
2620                     ; 776             pendingbitstatus = SET;
2622  036b 200f          	jp	LC011
2623                     ; 781             pendingbitstatus = RESET;
2624  036d               L7131:
2625                     ; 784     else if (UART2_IT == UART2_IT_LHDF)
2627  036d a30412        	cpw	x,#1042
2628  0370 2616          	jrne	L7231
2629                     ; 787         enablestatus = (uint8_t)((uint8_t)UART2->CR6 & itmask2);
2631  0372 c65249        	ld	a,21065
2632  0375 1402          	and	a,(OFST+0,sp)
2633  0377 6b02          	ld	(OFST+0,sp),a
2635                     ; 789         if (((UART2->CR6 & itpos) != (uint8_t)0x00) && enablestatus)
2637  0379 c65249        	ld	a,21065
2639  037c               LC011:
2640  037c 1501          	bcp	a,(OFST-1,sp)
2641  037e 271a          	jreq	L7331
2642  0380 7b02          	ld	a,(OFST+0,sp)
2643  0382 2716          	jreq	L7331
2644                     ; 792             pendingbitstatus = SET;
2646  0384               LC010:
2650  0384 a601          	ld	a,#1
2653  0386 2013          	jra	L5131
2654                     ; 797             pendingbitstatus = RESET;
2655  0388               L7231:
2656                     ; 803         enablestatus = (uint8_t)((uint8_t)UART2->CR2 & itmask2);
2658  0388 c65245        	ld	a,21061
2659  038b 1402          	and	a,(OFST+0,sp)
2660  038d 6b02          	ld	(OFST+0,sp),a
2662                     ; 805         if (((UART2->SR & itpos) != (uint8_t)0x00) && enablestatus)
2664  038f c65240        	ld	a,21056
2665  0392 1501          	bcp	a,(OFST-1,sp)
2666  0394 2704          	jreq	L7331
2668  0396 7b02          	ld	a,(OFST+0,sp)
2669                     ; 808             pendingbitstatus = SET;
2671  0398 26ea          	jrne	LC010
2672  039a               L7331:
2673                     ; 813             pendingbitstatus = RESET;
2678  039a 4f            	clr	a
2680  039b               L5131:
2681                     ; 817     return  pendingbitstatus;
2685  039b 5b04          	addw	sp,#4
2686  039d 81            	ret	
2722                     ; 846 void UART2_ClearITPendingBit(UART2_IT_TypeDef UART2_IT)
2722                     ; 847 {
2723                     	switch	.text
2724  039e               _UART2_ClearITPendingBit:
2726       00000000      OFST:	set	0
2729                     ; 848     assert_param(IS_UART2_CLEAR_IT_OK(UART2_IT));
2731                     ; 851     if (UART2_IT == UART2_IT_RXNE)
2733  039e a30255        	cpw	x,#597
2734  03a1 2605          	jrne	L1631
2735                     ; 853         UART2->SR = (uint8_t)~(UART2_SR_RXNE);
2737  03a3 35df5240      	mov	21056,#223
2740  03a7 81            	ret	
2741  03a8               L1631:
2742                     ; 856     else if (UART2_IT == UART2_IT_LBDF)
2744  03a8 a30346        	cpw	x,#838
2745  03ab 2605          	jrne	L5631
2746                     ; 858         UART2->CR4 &= (uint8_t)~(UART2_CR4_LBDF);
2748  03ad 72195247      	bres	21063,#4
2751  03b1 81            	ret	
2752  03b2               L5631:
2753                     ; 863         UART2->CR6 &= (uint8_t)(~UART2_CR6_LHDF);
2755  03b2 72135249      	bres	21065,#1
2756                     ; 865 }
2759  03b6 81            	ret	
2772                     	xdef	_UART2_ClearITPendingBit
2773                     	xdef	_UART2_GetITStatus
2774                     	xdef	_UART2_ClearFlag
2775                     	xdef	_UART2_GetFlagStatus
2776                     	xdef	_UART2_SetPrescaler
2777                     	xdef	_UART2_SetGuardTime
2778                     	xdef	_UART2_SetAddress
2779                     	xdef	_UART2_SendBreak
2780                     	xdef	_UART2_SendData9
2781                     	xdef	_UART2_SendData8
2782                     	xdef	_UART2_ReceiveData9
2783                     	xdef	_UART2_ReceiveData8
2784                     	xdef	_UART2_ReceiverWakeUpCmd
2785                     	xdef	_UART2_WakeUpConfig
2786                     	xdef	_UART2_SmartCardNACKCmd
2787                     	xdef	_UART2_SmartCardCmd
2788                     	xdef	_UART2_LINCmd
2789                     	xdef	_UART2_LINConfig
2790                     	xdef	_UART2_LINBreakDetectionConfig
2791                     	xdef	_UART2_IrDACmd
2792                     	xdef	_UART2_IrDAConfig
2793                     	xdef	_UART2_ITConfig
2794                     	xdef	_UART2_Cmd
2795                     	xdef	_UART2_Init
2796                     	xdef	_UART2_DeInit
2797                     	xref	_CLK_GetClockFreq
2798                     	xref.b	c_lreg
2799                     	xref.b	c_x
2818                     	xref	c_lursh
2819                     	xref	c_lsub
2820                     	xref	c_smul
2821                     	xref	c_ludv
2822                     	xref	c_rtol
2823                     	xref	c_llsh
2824                     	xref	c_ltor
2825                     	end
