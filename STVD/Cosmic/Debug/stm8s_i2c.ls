   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.1 - 30 Jun 2020
   3                     ; Generator (Limited) V4.4.12 - 02 Jul 2020
   4                     ; Optimizer V4.4.12 - 02 Jul 2020
  47                     ; 61 void I2C_DeInit(void)
  47                     ; 62 {
  49                     	switch	.text
  50  0000               _I2C_DeInit:
  54                     ; 63   I2C->CR1 = I2C_CR1_RESET_VALUE;
  56  0000 725f5210      	clr	21008
  57                     ; 64   I2C->CR2 = I2C_CR2_RESET_VALUE;
  59  0004 725f5211      	clr	21009
  60                     ; 65   I2C->FREQR = I2C_FREQR_RESET_VALUE;
  62  0008 725f5212      	clr	21010
  63                     ; 66   I2C->OARL = I2C_OARL_RESET_VALUE;
  65  000c 725f5213      	clr	21011
  66                     ; 67   I2C->OARH = I2C_OARH_RESET_VALUE;
  68  0010 725f5214      	clr	21012
  69                     ; 68   I2C->ITR = I2C_ITR_RESET_VALUE;
  71  0014 725f521a      	clr	21018
  72                     ; 69   I2C->CCRL = I2C_CCRL_RESET_VALUE;
  74  0018 725f521b      	clr	21019
  75                     ; 70   I2C->CCRH = I2C_CCRH_RESET_VALUE;
  77  001c 725f521c      	clr	21020
  78                     ; 71   I2C->TRISER = I2C_TRISER_RESET_VALUE;
  80  0020 3502521d      	mov	21021,#2
  81                     ; 72 }
  84  0024 81            	ret	
 263                     .const:	section	.text
 264  0000               L01:
 265  0000 000186a1      	dc.l	100001
 266  0004               L21:
 267  0004 000f4240      	dc.l	1000000
 268                     ; 90 void I2C_Init(uint32_t OutputClockFrequencyHz, uint16_t OwnAddress, 
 268                     ; 91               I2C_DutyCycle_TypeDef I2C_DutyCycle, I2C_Ack_TypeDef Ack, 
 268                     ; 92               I2C_AddMode_TypeDef AddMode, uint8_t InputClockFrequencyMHz )
 268                     ; 93 {
 269                     	switch	.text
 270  0025               _I2C_Init:
 272  0025 5209          	subw	sp,#9
 273       00000009      OFST:	set	9
 276                     ; 94   uint16_t result = 0x0004;
 278                     ; 95   uint16_t tmpval = 0;
 280                     ; 96   uint8_t tmpccrh = 0;
 282  0027 0f07          	clr	(OFST-2,sp)
 284                     ; 99   assert_param(IS_I2C_ACK_OK(Ack));
 286                     ; 100   assert_param(IS_I2C_ADDMODE_OK(AddMode));
 288                     ; 101   assert_param(IS_I2C_OWN_ADDRESS_OK(OwnAddress));
 290                     ; 102   assert_param(IS_I2C_DUTYCYCLE_OK(I2C_DutyCycle));  
 292                     ; 103   assert_param(IS_I2C_INPUT_CLOCK_FREQ_OK(InputClockFrequencyMHz));
 294                     ; 104   assert_param(IS_I2C_OUTPUT_CLOCK_FREQ_OK(OutputClockFrequencyHz));
 296                     ; 109   I2C->FREQR &= (uint8_t)(~I2C_FREQR_FREQ);
 298  0029 c65212        	ld	a,21010
 299  002c a4c0          	and	a,#192
 300  002e c75212        	ld	21010,a
 301                     ; 111   I2C->FREQR |= InputClockFrequencyMHz;
 303  0031 c65212        	ld	a,21010
 304  0034 1a15          	or	a,(OFST+12,sp)
 305  0036 c75212        	ld	21010,a
 306                     ; 115   I2C->CR1 &= (uint8_t)(~I2C_CR1_PE);
 308  0039 72115210      	bres	21008,#0
 309                     ; 118   I2C->CCRH &= (uint8_t)(~(I2C_CCRH_FS | I2C_CCRH_DUTY | I2C_CCRH_CCR));
 311  003d c6521c        	ld	a,21020
 312  0040 a430          	and	a,#48
 313  0042 c7521c        	ld	21020,a
 314                     ; 119   I2C->CCRL &= (uint8_t)(~I2C_CCRL_CCR);
 316  0045 725f521b      	clr	21019
 317                     ; 122   if (OutputClockFrequencyHz > I2C_MAX_STANDARD_FREQ) /* FAST MODE */
 319  0049 96            	ldw	x,sp
 320  004a 1c000c        	addw	x,#OFST+3
 321  004d cd0000        	call	c_ltor
 323  0050 ae0000        	ldw	x,#L01
 324  0053 cd0000        	call	c_lcmp
 326  0056 2560          	jrult	L131
 327                     ; 125     tmpccrh = I2C_CCRH_FS;
 329  0058 a680          	ld	a,#128
 330  005a 6b07          	ld	(OFST-2,sp),a
 332                     ; 127     if (I2C_DutyCycle == I2C_DUTYCYCLE_2)
 334  005c 96            	ldw	x,sp
 335  005d 0d12          	tnz	(OFST+9,sp)
 336  005f 261d          	jrne	L331
 337                     ; 130       result = (uint16_t) ((InputClockFrequencyMHz * 1000000) / (OutputClockFrequencyHz * 3));
 339  0061 1c000c        	addw	x,#OFST+3
 340  0064 cd0000        	call	c_ltor
 342  0067 a603          	ld	a,#3
 343  0069 cd0000        	call	c_smul
 345  006c 96            	ldw	x,sp
 346  006d 5c            	incw	x
 347  006e cd0000        	call	c_rtol
 350  0071 7b15          	ld	a,(OFST+12,sp)
 351  0073 cd0116        	call	LC001
 353  0076 96            	ldw	x,sp
 354  0077 cd0124        	call	LC002
 355  007a 1f08          	ldw	(OFST-1,sp),x
 358  007c 2021          	jra	L531
 359  007e               L331:
 360                     ; 135       result = (uint16_t) ((InputClockFrequencyMHz * 1000000) / (OutputClockFrequencyHz * 25));
 362  007e 1c000c        	addw	x,#OFST+3
 363  0081 cd0000        	call	c_ltor
 365  0084 a619          	ld	a,#25
 366  0086 cd0000        	call	c_smul
 368  0089 96            	ldw	x,sp
 369  008a 5c            	incw	x
 370  008b cd0000        	call	c_rtol
 373  008e 7b15          	ld	a,(OFST+12,sp)
 374  0090 cd0116        	call	LC001
 376  0093 96            	ldw	x,sp
 377  0094 cd0124        	call	LC002
 378  0097 1f08          	ldw	(OFST-1,sp),x
 380                     ; 137       tmpccrh |= I2C_CCRH_DUTY;
 382  0099 7b07          	ld	a,(OFST-2,sp)
 383  009b aa40          	or	a,#64
 384  009d 6b07          	ld	(OFST-2,sp),a
 386  009f               L531:
 387                     ; 141     if (result < (uint16_t)0x01)
 389  009f 1e08          	ldw	x,(OFST-1,sp)
 390  00a1 2603          	jrne	L731
 391                     ; 144       result = (uint16_t)0x0001;
 393  00a3 5c            	incw	x
 394  00a4 1f08          	ldw	(OFST-1,sp),x
 396  00a6               L731:
 397                     ; 150     tmpval = ((InputClockFrequencyMHz * 3) / 10) + 1;
 399  00a6 7b15          	ld	a,(OFST+12,sp)
 400  00a8 97            	ld	xl,a
 401  00a9 a603          	ld	a,#3
 402  00ab 42            	mul	x,a
 403  00ac a60a          	ld	a,#10
 404  00ae cd0000        	call	c_sdivx
 406  00b1 5c            	incw	x
 407  00b2 1f05          	ldw	(OFST-4,sp),x
 409                     ; 151     I2C->TRISER = (uint8_t)tmpval;
 411  00b4 7b06          	ld	a,(OFST-3,sp)
 413  00b6 2028          	jra	L141
 414  00b8               L131:
 415                     ; 158     result = (uint16_t)((InputClockFrequencyMHz * 1000000) / (OutputClockFrequencyHz << (uint8_t)1));
 417  00b8 96            	ldw	x,sp
 418  00b9 1c000c        	addw	x,#OFST+3
 419  00bc cd0000        	call	c_ltor
 421  00bf 3803          	sll	c_lreg+3
 422  00c1 3902          	rlc	c_lreg+2
 423  00c3 3901          	rlc	c_lreg+1
 424  00c5 96            	ldw	x,sp
 425  00c6 3900          	rlc	c_lreg
 426  00c8 5c            	incw	x
 427  00c9 cd0000        	call	c_rtol
 430  00cc 7b15          	ld	a,(OFST+12,sp)
 431  00ce ad46          	call	LC001
 433  00d0 96            	ldw	x,sp
 434  00d1 ad51          	call	LC002
 436                     ; 161     if (result < (uint16_t)0x0004)
 438  00d3 a30004        	cpw	x,#4
 439  00d6 2403          	jruge	L341
 440                     ; 164       result = (uint16_t)0x0004;
 442  00d8 ae0004        	ldw	x,#4
 444  00db               L341:
 445  00db 1f08          	ldw	(OFST-1,sp),x
 446                     ; 170     I2C->TRISER = (uint8_t)(InputClockFrequencyMHz + (uint8_t)1);
 448  00dd 7b15          	ld	a,(OFST+12,sp)
 449  00df 4c            	inc	a
 450  00e0               L141:
 451  00e0 c7521d        	ld	21021,a
 452                     ; 175   I2C->CCRL = (uint8_t)result;
 454  00e3 7b09          	ld	a,(OFST+0,sp)
 455  00e5 c7521b        	ld	21019,a
 456                     ; 176   I2C->CCRH = (uint8_t)((uint8_t)((uint8_t)(result >> 8) & I2C_CCRH_CCR) | tmpccrh);
 458  00e8 7b08          	ld	a,(OFST-1,sp)
 459  00ea a40f          	and	a,#15
 460  00ec 1a07          	or	a,(OFST-2,sp)
 461  00ee c7521c        	ld	21020,a
 462                     ; 179   I2C->CR1 |= I2C_CR1_PE;
 464  00f1 72105210      	bset	21008,#0
 465                     ; 182   I2C_AcknowledgeConfig(Ack);
 467  00f5 7b13          	ld	a,(OFST+10,sp)
 468  00f7 cd0179        	call	_I2C_AcknowledgeConfig
 470                     ; 185   I2C->OARL = (uint8_t)(OwnAddress);
 472  00fa 7b11          	ld	a,(OFST+8,sp)
 473  00fc c75213        	ld	21011,a
 474                     ; 186   I2C->OARH = (uint8_t)((uint8_t)(AddMode | I2C_OARH_ADDCONF) |
 474                     ; 187                    (uint8_t)((OwnAddress & (uint16_t)0x0300) >> (uint8_t)7));
 476  00ff 1e10          	ldw	x,(OFST+7,sp)
 477  0101 4f            	clr	a
 478  0102 01            	rrwa	x,a
 479  0103 48            	sll	a
 480  0104 01            	rrwa	x,a
 481  0105 49            	rlc	a
 482  0106 a406          	and	a,#6
 483  0108 6b04          	ld	(OFST-5,sp),a
 485  010a 7b14          	ld	a,(OFST+11,sp)
 486  010c aa40          	or	a,#64
 487  010e 1a04          	or	a,(OFST-5,sp)
 488  0110 c75214        	ld	21012,a
 489                     ; 188 }
 492  0113 5b09          	addw	sp,#9
 493  0115 81            	ret	
 494  0116               LC001:
 495  0116 b703          	ld	c_lreg+3,a
 496  0118 3f02          	clr	c_lreg+2
 497  011a 3f01          	clr	c_lreg+1
 498  011c 3f00          	clr	c_lreg
 499  011e ae0004        	ldw	x,#L21
 500  0121 cc0000        	jp	c_lmul
 501  0124               LC002:
 502  0124 5c            	incw	x
 503  0125 cd0000        	call	c_ludv
 505  0128 be02          	ldw	x,c_lreg+2
 506  012a 81            	ret	
 561                     ; 196 void I2C_Cmd(FunctionalState NewState)
 561                     ; 197 {
 562                     	switch	.text
 563  012b               _I2C_Cmd:
 567                     ; 200   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 569                     ; 202   if (NewState != DISABLE)
 571  012b 4d            	tnz	a
 572  012c 2705          	jreq	L371
 573                     ; 205     I2C->CR1 |= I2C_CR1_PE;
 575  012e 72105210      	bset	21008,#0
 578  0132 81            	ret	
 579  0133               L371:
 580                     ; 210     I2C->CR1 &= (uint8_t)(~I2C_CR1_PE);
 582  0133 72115210      	bres	21008,#0
 583                     ; 212 }
 586  0137 81            	ret	
 621                     ; 220 void I2C_GeneralCallCmd(FunctionalState NewState)
 621                     ; 221 {
 622                     	switch	.text
 623  0138               _I2C_GeneralCallCmd:
 627                     ; 224   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 629                     ; 226   if (NewState != DISABLE)
 631  0138 4d            	tnz	a
 632  0139 2705          	jreq	L512
 633                     ; 229     I2C->CR1 |= I2C_CR1_ENGC;
 635  013b 721c5210      	bset	21008,#6
 638  013f 81            	ret	
 639  0140               L512:
 640                     ; 234     I2C->CR1 &= (uint8_t)(~I2C_CR1_ENGC);
 642  0140 721d5210      	bres	21008,#6
 643                     ; 236 }
 646  0144 81            	ret	
 681                     ; 246 void I2C_GenerateSTART(FunctionalState NewState)
 681                     ; 247 {
 682                     	switch	.text
 683  0145               _I2C_GenerateSTART:
 687                     ; 250   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 689                     ; 252   if (NewState != DISABLE)
 691  0145 4d            	tnz	a
 692  0146 2705          	jreq	L732
 693                     ; 255     I2C->CR2 |= I2C_CR2_START;
 695  0148 72105211      	bset	21009,#0
 698  014c 81            	ret	
 699  014d               L732:
 700                     ; 260     I2C->CR2 &= (uint8_t)(~I2C_CR2_START);
 702  014d 72115211      	bres	21009,#0
 703                     ; 262 }
 706  0151 81            	ret	
 741                     ; 270 void I2C_GenerateSTOP(FunctionalState NewState)
 741                     ; 271 {
 742                     	switch	.text
 743  0152               _I2C_GenerateSTOP:
 747                     ; 274   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 749                     ; 276   if (NewState != DISABLE)
 751  0152 4d            	tnz	a
 752  0153 2705          	jreq	L162
 753                     ; 279     I2C->CR2 |= I2C_CR2_STOP;
 755  0155 72125211      	bset	21009,#1
 758  0159 81            	ret	
 759  015a               L162:
 760                     ; 284     I2C->CR2 &= (uint8_t)(~I2C_CR2_STOP);
 762  015a 72135211      	bres	21009,#1
 763                     ; 286 }
 766  015e 81            	ret	
 802                     ; 294 void I2C_SoftwareResetCmd(FunctionalState NewState)
 802                     ; 295 {
 803                     	switch	.text
 804  015f               _I2C_SoftwareResetCmd:
 808                     ; 297   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 810                     ; 299   if (NewState != DISABLE)
 812  015f 4d            	tnz	a
 813  0160 2705          	jreq	L303
 814                     ; 302     I2C->CR2 |= I2C_CR2_SWRST;
 816  0162 721e5211      	bset	21009,#7
 819  0166 81            	ret	
 820  0167               L303:
 821                     ; 307     I2C->CR2 &= (uint8_t)(~I2C_CR2_SWRST);
 823  0167 721f5211      	bres	21009,#7
 824                     ; 309 }
 827  016b 81            	ret	
 863                     ; 318 void I2C_StretchClockCmd(FunctionalState NewState)
 863                     ; 319 {
 864                     	switch	.text
 865  016c               _I2C_StretchClockCmd:
 869                     ; 321   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 871                     ; 323   if (NewState != DISABLE)
 873  016c 4d            	tnz	a
 874  016d 2705          	jreq	L523
 875                     ; 326     I2C->CR1 &= (uint8_t)(~I2C_CR1_NOSTRETCH);
 877  016f 721f5210      	bres	21008,#7
 880  0173 81            	ret	
 881  0174               L523:
 882                     ; 332     I2C->CR1 |= I2C_CR1_NOSTRETCH;
 884  0174 721e5210      	bset	21008,#7
 885                     ; 334 }
 888  0178 81            	ret	
 924                     ; 343 void I2C_AcknowledgeConfig(I2C_Ack_TypeDef Ack)
 924                     ; 344 {
 925                     	switch	.text
 926  0179               _I2C_AcknowledgeConfig:
 928       00000000      OFST:	set	0
 931                     ; 347   assert_param(IS_I2C_ACK_OK(Ack));
 933                     ; 349   if (Ack == I2C_ACK_NONE)
 935  0179 4d            	tnz	a
 936  017a 2605          	jrne	L743
 937                     ; 352     I2C->CR2 &= (uint8_t)(~I2C_CR2_ACK);
 939  017c 72155211      	bres	21009,#2
 942  0180 81            	ret	
 943  0181               L743:
 944                     ; 357     I2C->CR2 |= I2C_CR2_ACK;
 946  0181 72145211      	bset	21009,#2
 947                     ; 359     if (Ack == I2C_ACK_CURR)
 949  0185 4a            	dec	a
 950  0186 2605          	jrne	L353
 951                     ; 362       I2C->CR2 &= (uint8_t)(~I2C_CR2_POS);
 953  0188 72175211      	bres	21009,#3
 956  018c 81            	ret	
 957  018d               L353:
 958                     ; 367       I2C->CR2 |= I2C_CR2_POS;
 960  018d 72165211      	bset	21009,#3
 961                     ; 370 }
 964  0191 81            	ret	
1036                     ; 380 void I2C_ITConfig(I2C_IT_TypeDef I2C_IT, FunctionalState NewState)
1036                     ; 381 {
1037                     	switch	.text
1038  0192               _I2C_ITConfig:
1040  0192 89            	pushw	x
1041       00000000      OFST:	set	0
1044                     ; 384   assert_param(IS_I2C_INTERRUPT_OK(I2C_IT));
1046                     ; 385   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1048                     ; 387   if (NewState != DISABLE)
1050  0193 9f            	ld	a,xl
1051  0194 4d            	tnz	a
1052  0195 2706          	jreq	L314
1053                     ; 390     I2C->ITR |= (uint8_t)I2C_IT;
1055  0197 9e            	ld	a,xh
1056  0198 ca521a        	or	a,21018
1058  019b 2006          	jra	L514
1059  019d               L314:
1060                     ; 395     I2C->ITR &= (uint8_t)(~(uint8_t)I2C_IT);
1062  019d 7b01          	ld	a,(OFST+1,sp)
1063  019f 43            	cpl	a
1064  01a0 c4521a        	and	a,21018
1065  01a3               L514:
1066  01a3 c7521a        	ld	21018,a
1067                     ; 397 }
1070  01a6 85            	popw	x
1071  01a7 81            	ret	
1107                     ; 405 void I2C_FastModeDutyCycleConfig(I2C_DutyCycle_TypeDef I2C_DutyCycle)
1107                     ; 406 {
1108                     	switch	.text
1109  01a8               _I2C_FastModeDutyCycleConfig:
1113                     ; 409   assert_param(IS_I2C_DUTYCYCLE_OK(I2C_DutyCycle));
1115                     ; 411   if (I2C_DutyCycle == I2C_DUTYCYCLE_16_9)
1117  01a8 a140          	cp	a,#64
1118  01aa 2605          	jrne	L534
1119                     ; 414     I2C->CCRH |= I2C_CCRH_DUTY;
1121  01ac 721c521c      	bset	21020,#6
1124  01b0 81            	ret	
1125  01b1               L534:
1126                     ; 419     I2C->CCRH &= (uint8_t)(~I2C_CCRH_DUTY);
1128  01b1 721d521c      	bres	21020,#6
1129                     ; 421 }
1132  01b5 81            	ret	
1155                     ; 428 uint8_t I2C_ReceiveData(void)
1155                     ; 429 {
1156                     	switch	.text
1157  01b6               _I2C_ReceiveData:
1161                     ; 431   return ((uint8_t)I2C->DR);
1163  01b6 c65216        	ld	a,21014
1166  01b9 81            	ret	
1231                     ; 441 void I2C_Send7bitAddress(uint8_t Address, I2C_Direction_TypeDef Direction)
1231                     ; 442 {
1232                     	switch	.text
1233  01ba               _I2C_Send7bitAddress:
1235  01ba 89            	pushw	x
1236       00000000      OFST:	set	0
1239                     ; 444   assert_param(IS_I2C_ADDRESS_OK(Address));
1241                     ; 445   assert_param(IS_I2C_DIRECTION_OK(Direction));
1243                     ; 448   Address &= (uint8_t)0xFE;
1245  01bb 7b01          	ld	a,(OFST+1,sp)
1246  01bd a4fe          	and	a,#254
1247  01bf 6b01          	ld	(OFST+1,sp),a
1248                     ; 451   I2C->DR = (uint8_t)(Address | (uint8_t)Direction);
1250  01c1 1a02          	or	a,(OFST+2,sp)
1251  01c3 c75216        	ld	21014,a
1252                     ; 452 }
1255  01c6 85            	popw	x
1256  01c7 81            	ret	
1290                     ; 459 void I2C_SendData(uint8_t Data)
1290                     ; 460 {
1291                     	switch	.text
1292  01c8               _I2C_SendData:
1296                     ; 462   I2C->DR = Data;
1298  01c8 c75216        	ld	21014,a
1299                     ; 463 }
1302  01cb 81            	ret	
1526                     ; 579 ErrorStatus I2C_CheckEvent(I2C_Event_TypeDef I2C_Event)
1526                     ; 580 {
1527                     	switch	.text
1528  01cc               _I2C_CheckEvent:
1530  01cc 89            	pushw	x
1531  01cd 5206          	subw	sp,#6
1532       00000006      OFST:	set	6
1535                     ; 581   __IO uint16_t lastevent = 0x00;
1537  01cf 5f            	clrw	x
1538  01d0 1f04          	ldw	(OFST-2,sp),x
1540                     ; 582   uint8_t flag1 = 0x00 ;
1542                     ; 583   uint8_t flag2 = 0x00;
1544                     ; 584   ErrorStatus status = ERROR;
1546                     ; 587   assert_param(IS_I2C_EVENT_OK(I2C_Event));
1548                     ; 589   if (I2C_Event == I2C_EVENT_SLAVE_ACK_FAILURE)
1550  01d2 1e07          	ldw	x,(OFST+1,sp)
1551  01d4 a30004        	cpw	x,#4
1552  01d7 2609          	jrne	L136
1553                     ; 591     lastevent = I2C->SR2 & I2C_SR2_AF;
1555  01d9 c65218        	ld	a,21016
1556  01dc a404          	and	a,#4
1557  01de 5f            	clrw	x
1558  01df 97            	ld	xl,a
1560  01e0 201a          	jra	L336
1561  01e2               L136:
1562                     ; 595     flag1 = I2C->SR1;
1564  01e2 c65217        	ld	a,21015
1565  01e5 6b03          	ld	(OFST-3,sp),a
1567                     ; 596     flag2 = I2C->SR3;
1569  01e7 c65219        	ld	a,21017
1570  01ea 6b06          	ld	(OFST+0,sp),a
1572                     ; 597     lastevent = ((uint16_t)((uint16_t)flag2 << (uint16_t)8) | (uint16_t)flag1);
1574  01ec 5f            	clrw	x
1575  01ed 7b03          	ld	a,(OFST-3,sp)
1576  01ef 97            	ld	xl,a
1577  01f0 1f01          	ldw	(OFST-5,sp),x
1579  01f2 5f            	clrw	x
1580  01f3 7b06          	ld	a,(OFST+0,sp)
1581  01f5 97            	ld	xl,a
1582  01f6 7b02          	ld	a,(OFST-4,sp)
1583  01f8 01            	rrwa	x,a
1584  01f9 1a01          	or	a,(OFST-5,sp)
1585  01fb 01            	rrwa	x,a
1586  01fc               L336:
1587  01fc 1f04          	ldw	(OFST-2,sp),x
1589                     ; 600   if (((uint16_t)lastevent & (uint16_t)I2C_Event) == (uint16_t)I2C_Event)
1591  01fe 1e04          	ldw	x,(OFST-2,sp)
1592  0200 01            	rrwa	x,a
1593  0201 1408          	and	a,(OFST+2,sp)
1594  0203 01            	rrwa	x,a
1595  0204 1407          	and	a,(OFST+1,sp)
1596  0206 01            	rrwa	x,a
1597  0207 1307          	cpw	x,(OFST+1,sp)
1598  0209 2604          	jrne	L536
1599                     ; 603     status = SUCCESS;
1601  020b a601          	ld	a,#1
1604  020d 2001          	jra	L736
1605  020f               L536:
1606                     ; 608     status = ERROR;
1608  020f 4f            	clr	a
1610  0210               L736:
1611                     ; 612   return status;
1615  0210 5b08          	addw	sp,#8
1616  0212 81            	ret	
1669                     ; 629 I2C_Event_TypeDef I2C_GetLastEvent(void)
1669                     ; 630 {
1670                     	switch	.text
1671  0213               _I2C_GetLastEvent:
1673  0213 5206          	subw	sp,#6
1674       00000006      OFST:	set	6
1677                     ; 631   __IO uint16_t lastevent = 0;
1679  0215 5f            	clrw	x
1680  0216 1f05          	ldw	(OFST-1,sp),x
1682                     ; 632   uint16_t flag1 = 0;
1684                     ; 633   uint16_t flag2 = 0;
1686                     ; 635   if ((I2C->SR2 & I2C_SR2_AF) != 0x00)
1688  0218 7205521805    	btjf	21016,#2,L766
1689                     ; 637     lastevent = I2C_EVENT_SLAVE_ACK_FAILURE;
1691  021d ae0004        	ldw	x,#4
1693  0220 2013          	jra	L176
1694  0222               L766:
1695                     ; 642     flag1 = I2C->SR1;
1697  0222 c65217        	ld	a,21015
1698  0225 97            	ld	xl,a
1699  0226 1f01          	ldw	(OFST-5,sp),x
1701                     ; 643     flag2 = I2C->SR3;
1703  0228 c65219        	ld	a,21017
1704  022b 5f            	clrw	x
1705  022c 97            	ld	xl,a
1706  022d 1f03          	ldw	(OFST-3,sp),x
1708                     ; 646     lastevent = ((uint16_t)((uint16_t)flag2 << 8) | (uint16_t)flag1);
1710  022f 7b02          	ld	a,(OFST-4,sp)
1711  0231 01            	rrwa	x,a
1712  0232 1a01          	or	a,(OFST-5,sp)
1713  0234 01            	rrwa	x,a
1714  0235               L176:
1715  0235 1f05          	ldw	(OFST-1,sp),x
1717                     ; 649   return (I2C_Event_TypeDef)lastevent;
1719  0237 1e05          	ldw	x,(OFST-1,sp)
1722  0239 5b06          	addw	sp,#6
1723  023b 81            	ret	
1938                     ; 680 FlagStatus I2C_GetFlagStatus(I2C_Flag_TypeDef I2C_Flag)
1938                     ; 681 {
1939                     	switch	.text
1940  023c               _I2C_GetFlagStatus:
1942  023c 89            	pushw	x
1943  023d 89            	pushw	x
1944       00000002      OFST:	set	2
1947                     ; 682   uint8_t tempreg = 0;
1949  023e 0f02          	clr	(OFST+0,sp)
1951                     ; 683   uint8_t regindex = 0;
1953                     ; 684   FlagStatus bitstatus = RESET;
1955                     ; 687   assert_param(IS_I2C_FLAG_OK(I2C_Flag));
1957                     ; 690   regindex = (uint8_t)((uint16_t)I2C_Flag >> 8);
1959  0240 9e            	ld	a,xh
1960  0241 6b01          	ld	(OFST-1,sp),a
1962                     ; 692   switch (regindex)
1965                     ; 709     default:
1965                     ; 710       break;
1966  0243 4a            	dec	a
1967  0244 2708          	jreq	L376
1968  0246 4a            	dec	a
1969  0247 270a          	jreq	L576
1970  0249 4a            	dec	a
1971  024a 270c          	jreq	L776
1972  024c 200f          	jra	L3101
1973  024e               L376:
1974                     ; 695     case 0x01:
1974                     ; 696       tempreg = (uint8_t)I2C->SR1;
1976  024e c65217        	ld	a,21015
1977                     ; 697       break;
1979  0251 2008          	jp	LC003
1980  0253               L576:
1981                     ; 700     case 0x02:
1981                     ; 701       tempreg = (uint8_t)I2C->SR2;
1983  0253 c65218        	ld	a,21016
1984                     ; 702       break;
1986  0256 2003          	jp	LC003
1987  0258               L776:
1988                     ; 705     case 0x03:
1988                     ; 706       tempreg = (uint8_t)I2C->SR3;
1990  0258 c65219        	ld	a,21017
1991  025b               LC003:
1992  025b 6b02          	ld	(OFST+0,sp),a
1994                     ; 707       break;
1996                     ; 709     default:
1996                     ; 710       break;
1998  025d               L3101:
1999                     ; 714   if ((tempreg & (uint8_t)I2C_Flag ) != 0)
2001  025d 7b04          	ld	a,(OFST+2,sp)
2002  025f 1502          	bcp	a,(OFST+0,sp)
2003  0261 2704          	jreq	L5101
2004                     ; 717     bitstatus = SET;
2006  0263 a601          	ld	a,#1
2009  0265 2001          	jra	L7101
2010  0267               L5101:
2011                     ; 722     bitstatus = RESET;
2013  0267 4f            	clr	a
2015  0268               L7101:
2016                     ; 725   return bitstatus;
2020  0268 5b04          	addw	sp,#4
2021  026a 81            	ret	
2065                     ; 760 void I2C_ClearFlag(I2C_Flag_TypeDef I2C_FLAG)
2065                     ; 761 {
2066                     	switch	.text
2067  026b               _I2C_ClearFlag:
2069  026b 89            	pushw	x
2070       00000002      OFST:	set	2
2073                     ; 762   uint16_t flagpos = 0;
2075                     ; 764   assert_param(IS_I2C_CLEAR_FLAG_OK(I2C_FLAG));
2077                     ; 767   flagpos = (uint16_t)I2C_FLAG & FLAG_Mask;
2079  026c 01            	rrwa	x,a
2080  026d 5f            	clrw	x
2081  026e 02            	rlwa	x,a
2082  026f 1f01          	ldw	(OFST-1,sp),x
2084                     ; 769   I2C->SR2 = (uint8_t)((uint16_t)(~flagpos));
2086  0271 7b02          	ld	a,(OFST+0,sp)
2087  0273 43            	cpl	a
2088  0274 c75218        	ld	21016,a
2089                     ; 770 }
2092  0277 85            	popw	x
2093  0278 81            	ret	
2259                     ; 792 ITStatus I2C_GetITStatus(I2C_ITPendingBit_TypeDef I2C_ITPendingBit)
2259                     ; 793 {
2260                     	switch	.text
2261  0279               _I2C_GetITStatus:
2263  0279 89            	pushw	x
2264  027a 5204          	subw	sp,#4
2265       00000004      OFST:	set	4
2268                     ; 794   ITStatus bitstatus = RESET;
2270                     ; 795   __IO uint8_t enablestatus = 0;
2272  027c 0f03          	clr	(OFST-1,sp)
2274                     ; 796   uint16_t tempregister = 0;
2276                     ; 799     assert_param(IS_I2C_ITPENDINGBIT_OK(I2C_ITPendingBit));
2278                     ; 801   tempregister = (uint8_t)( ((uint16_t)((uint16_t)I2C_ITPendingBit & ITEN_Mask)) >> 8);
2280  027e 9e            	ld	a,xh
2281  027f a407          	and	a,#7
2282  0281 5f            	clrw	x
2283  0282 97            	ld	xl,a
2284  0283 1f01          	ldw	(OFST-3,sp),x
2286                     ; 804   enablestatus = (uint8_t)(I2C->ITR & ( uint8_t)tempregister);
2288  0285 c6521a        	ld	a,21018
2289  0288 1402          	and	a,(OFST-2,sp)
2290  028a 6b03          	ld	(OFST-1,sp),a
2292                     ; 806   if ((uint16_t)((uint16_t)I2C_ITPendingBit & REGISTER_Mask) == REGISTER_SR1_Index)
2294  028c 7b05          	ld	a,(OFST+1,sp)
2295  028e a430          	and	a,#48
2296  0290 97            	ld	xl,a
2297  0291 4f            	clr	a
2298  0292 02            	rlwa	x,a
2299  0293 a30100        	cpw	x,#256
2300  0296 260d          	jrne	L1311
2301                     ; 809     if (((I2C->SR1 & (uint8_t)I2C_ITPendingBit) != RESET) && enablestatus)
2303  0298 c65217        	ld	a,21015
2304  029b 1506          	bcp	a,(OFST+2,sp)
2305  029d 2715          	jreq	L1411
2307  029f 0d03          	tnz	(OFST-1,sp)
2308  02a1 2711          	jreq	L1411
2309                     ; 812       bitstatus = SET;
2311  02a3 200b          	jp	LC005
2312                     ; 817       bitstatus = RESET;
2313  02a5               L1311:
2314                     ; 823     if (((I2C->SR2 & (uint8_t)I2C_ITPendingBit) != RESET) && enablestatus)
2316  02a5 c65218        	ld	a,21016
2317  02a8 1506          	bcp	a,(OFST+2,sp)
2318  02aa 2708          	jreq	L1411
2320  02ac 0d03          	tnz	(OFST-1,sp)
2321  02ae 2704          	jreq	L1411
2322                     ; 826       bitstatus = SET;
2324  02b0               LC005:
2326  02b0 a601          	ld	a,#1
2329  02b2 2001          	jra	L7311
2330  02b4               L1411:
2331                     ; 831       bitstatus = RESET;
2334  02b4 4f            	clr	a
2336  02b5               L7311:
2337                     ; 835   return  bitstatus;
2341  02b5 5b06          	addw	sp,#6
2342  02b7 81            	ret	
2387                     ; 873 void I2C_ClearITPendingBit(I2C_ITPendingBit_TypeDef I2C_ITPendingBit)
2387                     ; 874 {
2388                     	switch	.text
2389  02b8               _I2C_ClearITPendingBit:
2391  02b8 89            	pushw	x
2392       00000002      OFST:	set	2
2395                     ; 875   uint16_t flagpos = 0;
2397                     ; 878   assert_param(IS_I2C_CLEAR_ITPENDINGBIT_OK(I2C_ITPendingBit));
2399                     ; 881   flagpos = (uint16_t)I2C_ITPendingBit & FLAG_Mask;
2401  02b9 01            	rrwa	x,a
2402  02ba 5f            	clrw	x
2403  02bb 02            	rlwa	x,a
2404  02bc 1f01          	ldw	(OFST-1,sp),x
2406                     ; 884   I2C->SR2 = (uint8_t)((uint16_t)~flagpos);
2408  02be 7b02          	ld	a,(OFST+0,sp)
2409  02c0 43            	cpl	a
2410  02c1 c75218        	ld	21016,a
2411                     ; 885 }
2414  02c4 85            	popw	x
2415  02c5 81            	ret	
2428                     	xdef	_I2C_ClearITPendingBit
2429                     	xdef	_I2C_GetITStatus
2430                     	xdef	_I2C_ClearFlag
2431                     	xdef	_I2C_GetFlagStatus
2432                     	xdef	_I2C_GetLastEvent
2433                     	xdef	_I2C_CheckEvent
2434                     	xdef	_I2C_SendData
2435                     	xdef	_I2C_Send7bitAddress
2436                     	xdef	_I2C_ReceiveData
2437                     	xdef	_I2C_ITConfig
2438                     	xdef	_I2C_FastModeDutyCycleConfig
2439                     	xdef	_I2C_AcknowledgeConfig
2440                     	xdef	_I2C_StretchClockCmd
2441                     	xdef	_I2C_SoftwareResetCmd
2442                     	xdef	_I2C_GenerateSTOP
2443                     	xdef	_I2C_GenerateSTART
2444                     	xdef	_I2C_GeneralCallCmd
2445                     	xdef	_I2C_Cmd
2446                     	xdef	_I2C_Init
2447                     	xdef	_I2C_DeInit
2448                     	xref.b	c_lreg
2449                     	xref.b	c_x
2468                     	xref	c_sdivx
2469                     	xref	c_ludv
2470                     	xref	c_rtol
2471                     	xref	c_smul
2472                     	xref	c_lmul
2473                     	xref	c_lcmp
2474                     	xref	c_ltor
2475                     	end
