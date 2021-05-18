   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.1 - 30 Jun 2020
   3                     ; Generator (Limited) V4.4.12 - 02 Jul 2020
   4                     ; Optimizer V4.4.12 - 02 Jul 2020
  47                     ; 44 void SPI_DeInit(void)
  47                     ; 45 {
  49                     	switch	.text
  50  0000               _SPI_DeInit:
  54                     ; 46     SPI->CR1    = SPI_CR1_RESET_VALUE;
  56  0000 725f5200      	clr	20992
  57                     ; 47     SPI->CR2    = SPI_CR2_RESET_VALUE;
  59  0004 725f5201      	clr	20993
  60                     ; 48     SPI->ICR    = SPI_ICR_RESET_VALUE;
  62  0008 725f5202      	clr	20994
  63                     ; 49     SPI->SR     = SPI_SR_RESET_VALUE;
  65  000c 35025203      	mov	20995,#2
  66                     ; 50     SPI->CRCPR  = SPI_CRCPR_RESET_VALUE;
  68  0010 35075205      	mov	20997,#7
  69                     ; 51 }
  72  0014 81            	ret	
 388                     ; 72 void SPI_Init(SPI_FirstBit_TypeDef FirstBit, SPI_BaudRatePrescaler_TypeDef BaudRatePrescaler, SPI_Mode_TypeDef Mode, SPI_ClockPolarity_TypeDef ClockPolarity, SPI_ClockPhase_TypeDef ClockPhase, SPI_DataDirection_TypeDef Data_Direction, SPI_NSS_TypeDef Slave_Management, uint8_t CRCPolynomial)
 388                     ; 73 {
 389                     	switch	.text
 390  0015               _SPI_Init:
 392  0015 89            	pushw	x
 393  0016 88            	push	a
 394       00000001      OFST:	set	1
 397                     ; 75     assert_param(IS_SPI_FIRSTBIT_OK(FirstBit));
 399                     ; 76     assert_param(IS_SPI_BAUDRATE_PRESCALER_OK(BaudRatePrescaler));
 401                     ; 77     assert_param(IS_SPI_MODE_OK(Mode));
 403                     ; 78     assert_param(IS_SPI_POLARITY_OK(ClockPolarity));
 405                     ; 79     assert_param(IS_SPI_PHASE_OK(ClockPhase));
 407                     ; 80     assert_param(IS_SPI_DATA_DIRECTION_OK(Data_Direction));
 409                     ; 81     assert_param(IS_SPI_SLAVEMANAGEMENT_OK(Slave_Management));
 411                     ; 82     assert_param(IS_SPI_CRC_POLYNOMIAL_OK(CRCPolynomial));
 413                     ; 85     SPI->CR1 = (uint8_t)((uint8_t)((uint8_t)FirstBit | BaudRatePrescaler) |
 413                     ; 86                     (uint8_t)((uint8_t)ClockPolarity | ClockPhase));
 415  0017 7b07          	ld	a,(OFST+6,sp)
 416  0019 1a08          	or	a,(OFST+7,sp)
 417  001b 6b01          	ld	(OFST+0,sp),a
 419  001d 9f            	ld	a,xl
 420  001e 1a02          	or	a,(OFST+1,sp)
 421  0020 1a01          	or	a,(OFST+0,sp)
 422  0022 c75200        	ld	20992,a
 423                     ; 89     SPI->CR2 = (uint8_t)((uint8_t)(Data_Direction) | (uint8_t)(Slave_Management));
 425  0025 7b09          	ld	a,(OFST+8,sp)
 426  0027 1a0a          	or	a,(OFST+9,sp)
 427  0029 c75201        	ld	20993,a
 428                     ; 91     if (Mode == SPI_MODE_MASTER)
 430  002c 7b06          	ld	a,(OFST+5,sp)
 431  002e a104          	cp	a,#4
 432  0030 2606          	jrne	L302
 433                     ; 93         SPI->CR2 |= (uint8_t)SPI_CR2_SSI;
 435  0032 72105201      	bset	20993,#0
 437  0036 2004          	jra	L502
 438  0038               L302:
 439                     ; 97         SPI->CR2 &= (uint8_t)~(SPI_CR2_SSI);
 441  0038 72115201      	bres	20993,#0
 442  003c               L502:
 443                     ; 101     SPI->CR1 |= (uint8_t)(Mode);
 445  003c c65200        	ld	a,20992
 446  003f 1a06          	or	a,(OFST+5,sp)
 447  0041 c75200        	ld	20992,a
 448                     ; 104     SPI->CRCPR = (uint8_t)CRCPolynomial;
 450  0044 7b0b          	ld	a,(OFST+10,sp)
 451  0046 c75205        	ld	20997,a
 452                     ; 105 }
 455  0049 5b03          	addw	sp,#3
 456  004b 81            	ret	
 511                     ; 113 void SPI_Cmd(FunctionalState NewState)
 511                     ; 114 {
 512                     	switch	.text
 513  004c               _SPI_Cmd:
 517                     ; 116     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 519                     ; 118     if (NewState != DISABLE)
 521  004c 4d            	tnz	a
 522  004d 2705          	jreq	L532
 523                     ; 120         SPI->CR1 |= SPI_CR1_SPE; /* Enable the SPI peripheral*/
 525  004f 721c5200      	bset	20992,#6
 528  0053 81            	ret	
 529  0054               L532:
 530                     ; 124         SPI->CR1 &= (uint8_t)(~SPI_CR1_SPE); /* Disable the SPI peripheral*/
 532  0054 721d5200      	bres	20992,#6
 533                     ; 126 }
 536  0058 81            	ret	
 645                     ; 135 void SPI_ITConfig(SPI_IT_TypeDef SPI_IT, FunctionalState NewState)
 645                     ; 136 {
 646                     	switch	.text
 647  0059               _SPI_ITConfig:
 649  0059 89            	pushw	x
 650  005a 88            	push	a
 651       00000001      OFST:	set	1
 654                     ; 137     uint8_t itpos = 0;
 656                     ; 139     assert_param(IS_SPI_CONFIG_IT_OK(SPI_IT));
 658                     ; 140     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 660                     ; 143     itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)SPI_IT & (uint8_t)0x0F));
 662  005b 9e            	ld	a,xh
 663  005c a40f          	and	a,#15
 664  005e 5f            	clrw	x
 665  005f 97            	ld	xl,a
 666  0060 a601          	ld	a,#1
 667  0062 5d            	tnzw	x
 668  0063 2704          	jreq	L41
 669  0065               L61:
 670  0065 48            	sll	a
 671  0066 5a            	decw	x
 672  0067 26fc          	jrne	L61
 673  0069               L41:
 674  0069 6b01          	ld	(OFST+0,sp),a
 676                     ; 145     if (NewState != DISABLE)
 678  006b 0d03          	tnz	(OFST+2,sp)
 679  006d 2707          	jreq	L113
 680                     ; 147         SPI->ICR |= itpos; /* Enable interrupt*/
 682  006f c65202        	ld	a,20994
 683  0072 1a01          	or	a,(OFST+0,sp)
 685  0074 2004          	jra	L313
 686  0076               L113:
 687                     ; 151         SPI->ICR &= (uint8_t)(~itpos); /* Disable interrupt*/
 689  0076 43            	cpl	a
 690  0077 c45202        	and	a,20994
 691  007a               L313:
 692  007a c75202        	ld	20994,a
 693                     ; 153 }
 696  007d 5b03          	addw	sp,#3
 697  007f 81            	ret	
 731                     ; 159 void SPI_SendData(uint8_t Data)
 731                     ; 160 {
 732                     	switch	.text
 733  0080               _SPI_SendData:
 737                     ; 161     SPI->DR = Data; /* Write in the DR register the data to be sent*/
 739  0080 c75204        	ld	20996,a
 740                     ; 162 }
 743  0083 81            	ret	
 766                     ; 169 uint8_t SPI_ReceiveData(void)
 766                     ; 170 {
 767                     	switch	.text
 768  0084               _SPI_ReceiveData:
 772                     ; 171     return ((uint8_t)SPI->DR); /* Return the data in the DR register*/
 774  0084 c65204        	ld	a,20996
 777  0087 81            	ret	
 813                     ; 180 void SPI_NSSInternalSoftwareCmd(FunctionalState NewState)
 813                     ; 181 {
 814                     	switch	.text
 815  0088               _SPI_NSSInternalSoftwareCmd:
 819                     ; 183     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 821                     ; 185     if (NewState != DISABLE)
 823  0088 4d            	tnz	a
 824  0089 2705          	jreq	L163
 825                     ; 187         SPI->CR2 |= SPI_CR2_SSI; /* Set NSS pin internally by software*/
 827  008b 72105201      	bset	20993,#0
 830  008f 81            	ret	
 831  0090               L163:
 832                     ; 191         SPI->CR2 &= (uint8_t)(~SPI_CR2_SSI); /* Reset NSS pin internally by software*/
 834  0090 72115201      	bres	20993,#0
 835                     ; 193 }
 838  0094 81            	ret	
 861                     ; 200 void SPI_TransmitCRC(void)
 861                     ; 201 {
 862                     	switch	.text
 863  0095               _SPI_TransmitCRC:
 867                     ; 202     SPI->CR2 |= SPI_CR2_CRCNEXT; /* Enable the CRC transmission*/
 869  0095 72185201      	bset	20993,#4
 870                     ; 203 }
 873  0099 81            	ret	
 909                     ; 211 void SPI_CalculateCRCCmd(FunctionalState NewState)
 909                     ; 212 {
 910                     	switch	.text
 911  009a               _SPI_CalculateCRCCmd:
 915                     ; 214     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 917                     ; 216     if (NewState != DISABLE)
 919  009a 4d            	tnz	a
 920  009b 2705          	jreq	L314
 921                     ; 218         SPI->CR2 |= SPI_CR2_CRCEN; /* Enable the CRC calculation*/
 923  009d 721a5201      	bset	20993,#5
 926  00a1 81            	ret	
 927  00a2               L314:
 928                     ; 222         SPI->CR2 &= (uint8_t)(~SPI_CR2_CRCEN); /* Disable the CRC calculation*/
 930  00a2 721b5201      	bres	20993,#5
 931                     ; 224 }
 934  00a6 81            	ret	
 998                     ; 231 uint8_t SPI_GetCRC(SPI_CRC_TypeDef SPI_CRC)
 998                     ; 232 {
 999                     	switch	.text
1000  00a7               _SPI_GetCRC:
1002       00000001      OFST:	set	1
1005                     ; 233     uint8_t crcreg = 0;
1007                     ; 236     assert_param(IS_SPI_CRC_OK(SPI_CRC));
1009                     ; 238     if (SPI_CRC != SPI_CRC_RX)
1011  00a7 4d            	tnz	a
1012  00a8 2704          	jreq	L154
1013                     ; 240         crcreg = SPI->TXCRCR;  /* Get the Tx CRC register*/
1015  00aa c65207        	ld	a,20999
1019  00ad 81            	ret	
1020  00ae               L154:
1021                     ; 244         crcreg = SPI->RXCRCR; /* Get the Rx CRC register*/
1023  00ae c65206        	ld	a,20998
1025                     ; 248     return crcreg;
1029  00b1 81            	ret	
1054                     ; 256 void SPI_ResetCRC(void)
1054                     ; 257 {
1055                     	switch	.text
1056  00b2               _SPI_ResetCRC:
1060                     ; 260     SPI_CalculateCRCCmd(ENABLE);
1062  00b2 a601          	ld	a,#1
1063  00b4 ade4          	call	_SPI_CalculateCRCCmd
1065                     ; 263     SPI_Cmd(ENABLE);
1067  00b6 a601          	ld	a,#1
1069                     ; 264 }
1072  00b8 2092          	jp	_SPI_Cmd
1096                     ; 271 uint8_t SPI_GetCRCPolynomial(void)
1096                     ; 272 {
1097                     	switch	.text
1098  00ba               _SPI_GetCRCPolynomial:
1102                     ; 273     return SPI->CRCPR; /* Return the CRC polynomial register */
1104  00ba c65205        	ld	a,20997
1107  00bd 81            	ret	
1163                     ; 281 void SPI_BiDirectionalLineConfig(SPI_Direction_TypeDef SPI_Direction)
1163                     ; 282 {
1164                     	switch	.text
1165  00be               _SPI_BiDirectionalLineConfig:
1169                     ; 284     assert_param(IS_SPI_DIRECTION_OK(SPI_Direction));
1171                     ; 286     if (SPI_Direction != SPI_DIRECTION_RX)
1173  00be 4d            	tnz	a
1174  00bf 2705          	jreq	L325
1175                     ; 288         SPI->CR2 |= SPI_CR2_BDOE; /* Set the Tx only mode*/
1177  00c1 721c5201      	bset	20993,#6
1180  00c5 81            	ret	
1181  00c6               L325:
1182                     ; 292         SPI->CR2 &= (uint8_t)(~SPI_CR2_BDOE); /* Set the Rx only mode*/
1184  00c6 721d5201      	bres	20993,#6
1185                     ; 294 }
1188  00ca 81            	ret	
1309                     ; 304 FlagStatus SPI_GetFlagStatus(SPI_Flag_TypeDef SPI_FLAG)
1309                     ; 305 {
1310                     	switch	.text
1311  00cb               _SPI_GetFlagStatus:
1313       00000001      OFST:	set	1
1316                     ; 306     FlagStatus status = RESET;
1318                     ; 308     assert_param(IS_SPI_FLAGS_OK(SPI_FLAG));
1320                     ; 311     if ((SPI->SR & (uint8_t)SPI_FLAG) != (uint8_t)RESET)
1322  00cb c45203        	and	a,20995
1323  00ce 2702          	jreq	L306
1324                     ; 313         status = SET; /* SPI_FLAG is set */
1326  00d0 a601          	ld	a,#1
1329  00d2               L306:
1330                     ; 317         status = RESET; /* SPI_FLAG is reset*/
1333                     ; 321     return status;
1337  00d2 81            	ret	
1372                     ; 339 void SPI_ClearFlag(SPI_Flag_TypeDef SPI_FLAG)
1372                     ; 340 {
1373                     	switch	.text
1374  00d3               _SPI_ClearFlag:
1378                     ; 341     assert_param(IS_SPI_CLEAR_FLAGS_OK(SPI_FLAG));
1380                     ; 343     SPI->SR = (uint8_t)(~SPI_FLAG);
1382  00d3 43            	cpl	a
1383  00d4 c75203        	ld	20995,a
1384                     ; 344 }
1387  00d7 81            	ret	
1469                     ; 359 ITStatus SPI_GetITStatus(SPI_IT_TypeDef SPI_IT)
1469                     ; 360 {
1470                     	switch	.text
1471  00d8               _SPI_GetITStatus:
1473  00d8 88            	push	a
1474  00d9 89            	pushw	x
1475       00000002      OFST:	set	2
1478                     ; 361     ITStatus pendingbitstatus = RESET;
1480                     ; 362     uint8_t itpos = 0;
1482                     ; 363     uint8_t itmask1 = 0;
1484                     ; 364     uint8_t itmask2 = 0;
1486                     ; 365     uint8_t enablestatus = 0;
1488                     ; 366     assert_param(IS_SPI_GET_IT_OK(SPI_IT));
1490                     ; 368     itpos = (uint8_t)((uint8_t)1 << ((uint8_t)SPI_IT & (uint8_t)0x0F));
1492  00da a40f          	and	a,#15
1493  00dc 5f            	clrw	x
1494  00dd 97            	ld	xl,a
1495  00de a601          	ld	a,#1
1496  00e0 5d            	tnzw	x
1497  00e1 2704          	jreq	L45
1498  00e3               L65:
1499  00e3 48            	sll	a
1500  00e4 5a            	decw	x
1501  00e5 26fc          	jrne	L65
1502  00e7               L45:
1503  00e7 6b01          	ld	(OFST-1,sp),a
1505                     ; 371     itmask1 = (uint8_t)((uint8_t)SPI_IT >> (uint8_t)4);
1507  00e9 7b03          	ld	a,(OFST+1,sp)
1508  00eb 4e            	swap	a
1509  00ec a40f          	and	a,#15
1510  00ee 6b02          	ld	(OFST+0,sp),a
1512                     ; 373     itmask2 = (uint8_t)((uint8_t)1 << itmask1);
1514  00f0 5f            	clrw	x
1515  00f1 97            	ld	xl,a
1516  00f2 a601          	ld	a,#1
1517  00f4 5d            	tnzw	x
1518  00f5 2704          	jreq	L06
1519  00f7               L26:
1520  00f7 48            	sll	a
1521  00f8 5a            	decw	x
1522  00f9 26fc          	jrne	L26
1523  00fb               L06:
1525                     ; 375     enablestatus = (uint8_t)((uint8_t)SPI->SR & itmask2);
1527  00fb c45203        	and	a,20995
1528  00fe 6b02          	ld	(OFST+0,sp),a
1530                     ; 377     if (((SPI->ICR & itpos) != RESET) && enablestatus)
1532  0100 c65202        	ld	a,20994
1533  0103 1501          	bcp	a,(OFST-1,sp)
1534  0105 2708          	jreq	L766
1536  0107 7b02          	ld	a,(OFST+0,sp)
1537  0109 2704          	jreq	L766
1538                     ; 380         pendingbitstatus = SET;
1540  010b a601          	ld	a,#1
1543  010d 2001          	jra	L176
1544  010f               L766:
1545                     ; 385         pendingbitstatus = RESET;
1547  010f 4f            	clr	a
1549  0110               L176:
1550                     ; 388     return  pendingbitstatus;
1554  0110 5b03          	addw	sp,#3
1555  0112 81            	ret	
1600                     ; 404 void SPI_ClearITPendingBit(SPI_IT_TypeDef SPI_IT)
1600                     ; 405 {
1601                     	switch	.text
1602  0113               _SPI_ClearITPendingBit:
1604       00000001      OFST:	set	1
1607                     ; 406     uint8_t itpos = 0;
1609                     ; 407     assert_param(IS_SPI_CLEAR_IT_OK(SPI_IT));
1611                     ; 412     itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)(SPI_IT & (uint8_t)0xF0) >> 4));
1613  0113 4e            	swap	a
1614  0114 a40f          	and	a,#15
1615  0116 5f            	clrw	x
1616  0117 97            	ld	xl,a
1617  0118 a601          	ld	a,#1
1618  011a 5d            	tnzw	x
1619  011b 2704          	jreq	L66
1620  011d               L07:
1621  011d 48            	sll	a
1622  011e 5a            	decw	x
1623  011f 26fc          	jrne	L07
1624  0121               L66:
1626                     ; 414     SPI->SR = (uint8_t)(~itpos);
1628  0121 43            	cpl	a
1629  0122 c75203        	ld	20995,a
1630                     ; 416 }
1633  0125 81            	ret	
1646                     	xdef	_SPI_ClearITPendingBit
1647                     	xdef	_SPI_GetITStatus
1648                     	xdef	_SPI_ClearFlag
1649                     	xdef	_SPI_GetFlagStatus
1650                     	xdef	_SPI_BiDirectionalLineConfig
1651                     	xdef	_SPI_GetCRCPolynomial
1652                     	xdef	_SPI_ResetCRC
1653                     	xdef	_SPI_GetCRC
1654                     	xdef	_SPI_CalculateCRCCmd
1655                     	xdef	_SPI_TransmitCRC
1656                     	xdef	_SPI_NSSInternalSoftwareCmd
1657                     	xdef	_SPI_ReceiveData
1658                     	xdef	_SPI_SendData
1659                     	xdef	_SPI_ITConfig
1660                     	xdef	_SPI_Cmd
1661                     	xdef	_SPI_Init
1662                     	xdef	_SPI_DeInit
1681                     	end
