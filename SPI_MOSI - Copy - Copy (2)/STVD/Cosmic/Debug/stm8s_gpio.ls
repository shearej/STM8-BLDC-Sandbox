   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.1 - 30 Jun 2020
   3                     ; Generator (Limited) V4.4.12 - 02 Jul 2020
   4                     ; Optimizer V4.4.12 - 02 Jul 2020
 113                     ; 47 void GPIO_DeInit(GPIO_TypeDef* GPIOx)
 113                     ; 48 {
 115                     	switch	.text
 116  0000               _GPIO_DeInit:
 120                     ; 49     GPIOx->ODR = GPIO_ODR_RESET_VALUE; /* Reset Output Data Register */
 122  0000 7f            	clr	(x)
 123                     ; 50     GPIOx->DDR = GPIO_DDR_RESET_VALUE; /* Reset Data Direction Register */
 125  0001 6f02          	clr	(2,x)
 126                     ; 51     GPIOx->CR1 = GPIO_CR1_RESET_VALUE; /* Reset Control Register 1 */
 128  0003 6f03          	clr	(3,x)
 129                     ; 52     GPIOx->CR2 = GPIO_CR2_RESET_VALUE; /* Reset Control Register 2 */
 131  0005 6f04          	clr	(4,x)
 132                     ; 53 }
 135  0007 81            	ret	
 375                     ; 65 void GPIO_Init(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin, GPIO_Mode_TypeDef GPIO_Mode)
 375                     ; 66 {
 376                     	switch	.text
 377  0008               _GPIO_Init:
 379  0008 89            	pushw	x
 380       00000000      OFST:	set	0
 383                     ; 71     assert_param(IS_GPIO_MODE_OK(GPIO_Mode));
 385                     ; 72     assert_param(IS_GPIO_PIN_OK(GPIO_Pin));
 387                     ; 75   GPIOx->CR2 &= (uint8_t)(~(GPIO_Pin));
 389  0009 7b05          	ld	a,(OFST+5,sp)
 390  000b 43            	cpl	a
 391  000c e404          	and	a,(4,x)
 392  000e e704          	ld	(4,x),a
 393                     ; 81     if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x80) != (uint8_t)0x00) /* Output mode */
 395  0010 7b06          	ld	a,(OFST+6,sp)
 396  0012 2a16          	jrpl	L771
 397                     ; 83         if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x10) != (uint8_t)0x00) /* High level */
 399  0014 a510          	bcp	a,#16
 400  0016 2705          	jreq	L102
 401                     ; 85             GPIOx->ODR |= (uint8_t)GPIO_Pin;
 403  0018 f6            	ld	a,(x)
 404  0019 1a05          	or	a,(OFST+5,sp)
 406  001b 2004          	jra	L302
 407  001d               L102:
 408                     ; 89             GPIOx->ODR &= (uint8_t)(~(GPIO_Pin));
 410  001d 7b05          	ld	a,(OFST+5,sp)
 411  001f 43            	cpl	a
 412  0020 f4            	and	a,(x)
 413  0021               L302:
 414  0021 f7            	ld	(x),a
 415                     ; 92         GPIOx->DDR |= (uint8_t)GPIO_Pin;
 417  0022 1e01          	ldw	x,(OFST+1,sp)
 418  0024 e602          	ld	a,(2,x)
 419  0026 1a05          	or	a,(OFST+5,sp)
 421  0028 2005          	jra	L502
 422  002a               L771:
 423                     ; 97         GPIOx->DDR &= (uint8_t)(~(GPIO_Pin));
 425  002a 7b05          	ld	a,(OFST+5,sp)
 426  002c 43            	cpl	a
 427  002d e402          	and	a,(2,x)
 428  002f               L502:
 429  002f e702          	ld	(2,x),a
 430                     ; 104     if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x40) != (uint8_t)0x00) /* Pull-Up or Push-Pull */
 432  0031 7b06          	ld	a,(OFST+6,sp)
 433  0033 a540          	bcp	a,#64
 434  0035 2706          	jreq	L702
 435                     ; 106         GPIOx->CR1 |= (uint8_t)GPIO_Pin;
 437  0037 e603          	ld	a,(3,x)
 438  0039 1a05          	or	a,(OFST+5,sp)
 440  003b 2005          	jra	L112
 441  003d               L702:
 442                     ; 110         GPIOx->CR1 &= (uint8_t)(~(GPIO_Pin));
 444  003d 7b05          	ld	a,(OFST+5,sp)
 445  003f 43            	cpl	a
 446  0040 e403          	and	a,(3,x)
 447  0042               L112:
 448  0042 e703          	ld	(3,x),a
 449                     ; 117     if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x20) != (uint8_t)0x00) /* Interrupt or Slow slope */
 451  0044 7b06          	ld	a,(OFST+6,sp)
 452  0046 a520          	bcp	a,#32
 453  0048 2706          	jreq	L312
 454                     ; 119         GPIOx->CR2 |= (uint8_t)GPIO_Pin;
 456  004a e604          	ld	a,(4,x)
 457  004c 1a05          	or	a,(OFST+5,sp)
 459  004e 2005          	jra	L512
 460  0050               L312:
 461                     ; 123         GPIOx->CR2 &= (uint8_t)(~(GPIO_Pin));
 463  0050 7b05          	ld	a,(OFST+5,sp)
 464  0052 43            	cpl	a
 465  0053 e404          	and	a,(4,x)
 466  0055               L512:
 467  0055 e704          	ld	(4,x),a
 468                     ; 125 }
 471  0057 85            	popw	x
 472  0058 81            	ret	
 518                     ; 135 void GPIO_Write(GPIO_TypeDef* GPIOx, uint8_t PortVal)
 518                     ; 136 {
 519                     	switch	.text
 520  0059               _GPIO_Write:
 522       fffffffe      OFST: set -2
 525                     ; 137     GPIOx->ODR = PortVal;
 527  0059 7b03          	ld	a,(OFST+5,sp)
 528  005b f7            	ld	(x),a
 529                     ; 138 }
 532  005c 81            	ret	
 579                     ; 148 void GPIO_WriteHigh(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 579                     ; 149 {
 580                     	switch	.text
 581  005d               _GPIO_WriteHigh:
 583       fffffffe      OFST: set -2
 586                     ; 150     GPIOx->ODR |= (uint8_t)PortPins;
 588  005d f6            	ld	a,(x)
 589  005e 1a03          	or	a,(OFST+5,sp)
 590  0060 f7            	ld	(x),a
 591                     ; 151 }
 594  0061 81            	ret	
 641                     ; 161 void GPIO_WriteLow(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 641                     ; 162 {
 642                     	switch	.text
 643  0062               _GPIO_WriteLow:
 645       fffffffe      OFST: set -2
 648                     ; 163     GPIOx->ODR &= (uint8_t)(~PortPins);
 650  0062 7b03          	ld	a,(OFST+5,sp)
 651  0064 43            	cpl	a
 652  0065 f4            	and	a,(x)
 653  0066 f7            	ld	(x),a
 654                     ; 164 }
 657  0067 81            	ret	
 704                     ; 174 void GPIO_WriteReverse(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 704                     ; 175 {
 705                     	switch	.text
 706  0068               _GPIO_WriteReverse:
 708       fffffffe      OFST: set -2
 711                     ; 176     GPIOx->ODR ^= (uint8_t)PortPins;
 713  0068 f6            	ld	a,(x)
 714  0069 1803          	xor	a,(OFST+5,sp)
 715  006b f7            	ld	(x),a
 716                     ; 177 }
 719  006c 81            	ret	
 757                     ; 185 uint8_t GPIO_ReadOutputData(GPIO_TypeDef* GPIOx)
 757                     ; 186 {
 758                     	switch	.text
 759  006d               _GPIO_ReadOutputData:
 763                     ; 187     return ((uint8_t)GPIOx->ODR);
 765  006d f6            	ld	a,(x)
 768  006e 81            	ret	
 805                     ; 196 uint8_t GPIO_ReadInputData(GPIO_TypeDef* GPIOx)
 805                     ; 197 {
 806                     	switch	.text
 807  006f               _GPIO_ReadInputData:
 811                     ; 198     return ((uint8_t)GPIOx->IDR);
 813  006f e601          	ld	a,(1,x)
 816  0071 81            	ret	
 884                     ; 207 BitStatus GPIO_ReadInputPin(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin)
 884                     ; 208 {
 885                     	switch	.text
 886  0072               _GPIO_ReadInputPin:
 888       fffffffe      OFST: set -2
 891                     ; 209     return ((BitStatus)(GPIOx->IDR & (uint8_t)GPIO_Pin));
 893  0072 e601          	ld	a,(1,x)
 894  0074 1403          	and	a,(OFST+5,sp)
 897  0076 81            	ret	
 975                     ; 219 void GPIO_ExternalPullUpConfig(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin, FunctionalState NewState)
 975                     ; 220 {
 976                     	switch	.text
 977  0077               _GPIO_ExternalPullUpConfig:
 979       fffffffe      OFST: set -2
 982                     ; 222     assert_param(IS_GPIO_PIN_OK(GPIO_Pin));
 984                     ; 223     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 986                     ; 225     if (NewState != DISABLE) /* External Pull-Up Set*/
 988  0077 7b04          	ld	a,(OFST+6,sp)
 989  0079 2706          	jreq	L374
 990                     ; 227         GPIOx->CR1 |= (uint8_t)GPIO_Pin;
 992  007b e603          	ld	a,(3,x)
 993  007d 1a03          	or	a,(OFST+5,sp)
 995  007f 2005          	jra	L574
 996  0081               L374:
 997                     ; 230         GPIOx->CR1 &= (uint8_t)(~(GPIO_Pin));
 999  0081 7b03          	ld	a,(OFST+5,sp)
1000  0083 43            	cpl	a
1001  0084 e403          	and	a,(3,x)
1002  0086               L574:
1003  0086 e703          	ld	(3,x),a
1004                     ; 232 }
1007  0088 81            	ret	
1020                     	xdef	_GPIO_ExternalPullUpConfig
1021                     	xdef	_GPIO_ReadInputPin
1022                     	xdef	_GPIO_ReadOutputData
1023                     	xdef	_GPIO_ReadInputData
1024                     	xdef	_GPIO_WriteReverse
1025                     	xdef	_GPIO_WriteLow
1026                     	xdef	_GPIO_WriteHigh
1027                     	xdef	_GPIO_Write
1028                     	xdef	_GPIO_Init
1029                     	xdef	_GPIO_DeInit
1048                     	end
