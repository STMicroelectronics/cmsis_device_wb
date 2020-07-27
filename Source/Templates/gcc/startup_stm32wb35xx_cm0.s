/**
  ******************************************************************************
  * @file      startup_stm32wb35xx_cm0.s
  * @author    MCD Application Team
  * @brief     STM32WB35xx devices vector table GCC toolchain.
  *            This module performs:
  *                - Set the initial SP
  *                - Set the initial PC == Reset_Handler,
  *                - Set the vector table entries with the exceptions ISR address
  *                - Branches to main in the C library (which eventually
  *                  calls main()).
  *            After Reset the Cortex-M0+ processor is in Thread mode,
  *            priority is Privileged, and the Stack is set to Main.
  ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; Copyright (c) 2019 STMicroelectronics. 
  * All rights reserved.</center></h2>
  *
  * This software component is licensed by ST under BSD 3-Clause license,
  * the "License"; You may not use this file except in compliance with the 
  * License. You may obtain a copy of the License at:
  *                        opensource.org/licenses/BSD-3-Clause
  *
  ******************************************************************************
  */

  .syntax unified
  .cpu cortex-m0
	.fpu softvfp
	.thumb

.global	g_pfnVectors
.global	Default_Handler

/* start address for the initialization values of the .data section.
defined in linker script */
.word	_sidata
/* start address for the .data section. defined in linker script */
.word	_sdata
/* end address for the .data section. defined in linker script */
.word	_edata
/* start address for the .bss section. defined in linker script */
.word	_sbss
/* end address for the .bss section. defined in linker script */
.word	_ebss

  .section .text.Reset_Handler
  .weak Reset_Handler
  .type Reset_Handler, %function
Reset_Handler:
  ldr   r0, =_estack
  mov   sp, r0          /* set stack pointer */
/* Call the clock system intitialization function.*/
  bl  SystemInit

/* Copy the data segment initializers from flash to SRAM */
  ldr r0, =_sdata
  ldr r1, =_edata
  ldr r2, =_sidata
  movs r3, #0
  b	LoopCopyDataInit

CopyDataInit:
  ldr r4, [r2, r3]
  str r4, [r0, r3]
  adds r3, r3, #4

LoopCopyDataInit:
  adds r4, r0, r3
  cmp r4, r1
  bcc CopyDataInit
  
/* Zero fill the bss segment. */
  ldr r2, =_sbss
  ldr r4, =_ebss
  movs r3, #0
  b LoopFillZerobss

FillZerobss:
  str  r3, [r2]
  adds r2, r2, #4

LoopFillZerobss:
  cmp r2, r4
  bcc FillZerobss

/* Call static constructors */
  bl __libc_init_array
/* Call the application s entry point.*/
	bl	main

LoopForever:
  b LoopForever
    
.size	Reset_Handler, .-Reset_Handler

/**
 * @brief  This is the code that gets called when the processor receives an
 *         unexpected interrupt.  This simply enters an infinite loop, preserving
 *         the system state for examination by a debugger.
 *
 * @param  None
 * @retval None
*/
  .section .text.Default_Handler,"ax",%progbits
Default_Handler:
Infinite_Loop:
	b	Infinite_Loop
	.size	Default_Handler, .-Default_Handler
/******************************************************************************
*
* The minimal vector table for a Cortex M0.  Note that the proper constructs
* must be placed on this to ensure that it ends up at physical address
* 0x0000.0000.
*
******************************************************************************/
 	.section	.isr_vector,"a",%progbits
	.type	g_pfnVectors, %object
	.size	g_pfnVectors, .-g_pfnVectors

g_pfnVectors:
  .word _estack
  .word Reset_Handler
  .word NMI_Handler
  .word HardFault_Handler
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word SVC_Handler
  .word 0
  .word 0
  .word PendSV_Handler
  .word SysTick_Handler
  .word 0
  .word PVD_PVM_IRQHandler
  .word RTC_LSECSS_IRQHandler
  .word USB_CRS_IRQHandler
  .word RCC_FLASH_C1SEV_IRQHandler
  .word EXTI1_0_IRQHandler
  .word EXTI3_2_IRQHandler
  .word EXTI15_4_IRQHandler
  .word _802_0_IRQHandler
  .word DMA1_Channel1_2_3_IRQHandler
  .word DMA1_Channel4_5_6_7_IRQHandler
  .word DMA2_DMAMUX1_OVR_IRQHandler
  .word ADC1_COMP_IRQHandler
  .word LPTIM1_IRQHandler
  .word LPTIM2_IRQHandler
  .word TIM1_IRQHandler
  .word TIM2_IRQHandler
  .word TIM16_IRQHandler
  .word TIM17_IRQHandler
  .word IPCC_C2_RX_C2_TX_HSEM_IRQHandler
  .word AES1_RNG_PKA_IRQHandler
  .word AES2_IRQHandler
  .word _802_1_IRQHandler
  .word I2C1_IRQHandler
  .word I2C3_IRQHandler
  .word SPI1_IRQHandler
  .word USART1_IRQHandler
  .word LPUART1_IRQHandler
  .word 0
  .word BLE_IRQHandler
  .word _802_2_HOST_WKUP_IRQHandler

/*******************************************************************************
*
* Provide weak aliases for each Exception handler to the Default_Handler.
* As they are weak aliases, any function with the same name will override
* this definition.
*
*******************************************************************************/
  .weak  NMI_Handler
  .thumb_set NMI_Handler,Default_Handler

  .weak  HardFault_Handler
  .thumb_set HardFault_Handler,Default_Handler

  .weak  SVC_Handler
  .thumb_set SVC_Handler,Default_Handler

  .weak  PendSV_Handler
  .thumb_set PendSV_Handler,Default_Handler

  .weak  SysTick_Handler
  .thumb_set SysTick_Handler,Default_Handler

  .weak  PVD_PVM_IRQHandler
  .thumb_set PVD_PVM_IRQHandler,Default_Handler

  .weak  RTC_LSECSS_IRQHandler
  .thumb_set RTC_LSECSS_IRQHandler,Default_Handler

  .weak  USB_CRS_IRQHandler
  .thumb_set USB_CRS_IRQHandler,Default_Handler

  .weak  RCC_FLASH_C1SEV_IRQHandler
  .thumb_set RCC_FLASH_C1SEV_IRQHandler,Default_Handler

  .weak  EXTI1_0_IRQHandler
  .thumb_set EXTI1_0_IRQHandler,Default_Handler

  .weak  EXTI3_2_IRQHandler
  .thumb_set EXTI3_2_IRQHandler,Default_Handler

  .weak  EXTI15_4_IRQHandler
  .thumb_set EXTI15_4_IRQHandler,Default_Handler

  .weak  _802_0_IRQHandler
  .thumb_set _802_0_IRQHandler,Default_Handler

  .weak  DMA1_Channel1_2_3_IRQHandler
  .thumb_set DMA1_Channel1_2_3_IRQHandler,Default_Handler

  .weak  DMA1_Channel4_5_6_7_IRQHandler
  .thumb_set DMA1_Channel4_5_6_7_IRQHandler,Default_Handler

  .weak  DMA2_DMAMUX1_OVR_IRQHandler
  .thumb_set DMA2_DMAMUX1_OVR_IRQHandler,Default_Handler

  .weak  ADC1_COMP_IRQHandler
  .thumb_set ADC1_COMP_IRQHandler,Default_Handler

  .weak  LPTIM1_IRQHandler
  .thumb_set LPTIM1_IRQHandler,Default_Handler

  .weak  LPTIM2_IRQHandler
  .thumb_set LPTIM2_IRQHandler,Default_Handler

  .weak  TIM1_IRQHandler
  .thumb_set TIM1_IRQHandler,Default_Handler

  .weak  TIM2_IRQHandler
  .thumb_set TIM2_IRQHandler,Default_Handler

  .weak  TIM16_IRQHandler
  .thumb_set TIM16_IRQHandler,Default_Handler

  .weak  TIM17_IRQHandler
  .thumb_set TIM17_IRQHandler,Default_Handler

  .weak  IPCC_C2_RX_C2_TX_HSEM_IRQHandler
  .thumb_set IPCC_C2_RX_C2_TX_HSEM_IRQHandler,Default_Handler

  .weak  AES1_RNG_PKA_IRQHandler
  .thumb_set AES1_RNG_PKA_IRQHandler,Default_Handler

  .weak  AES2_IRQHandler
  .thumb_set AES2_IRQHandler,Default_Handler

  .weak  _802_1_IRQHandler
  .thumb_set _802_1_IRQHandler,Default_Handler

  .weak  I2C1_IRQHandler
  .thumb_set I2C1_IRQHandler,Default_Handler

  .weak  I2C3_IRQHandler
  .thumb_set I2C3_IRQHandler,Default_Handler

  .weak  SPI1_IRQHandler
  .thumb_set SPI1_IRQHandler,Default_Handler

  .weak  USART1_IRQHandler
  .thumb_set USART1_IRQHandler,Default_Handler

  .weak  LPUART1_IRQHandler
  .thumb_set LPUART1_IRQHandler,Default_Handler

  .weak  BLE_IRQHandler
  .thumb_set BLE_IRQHandler,Default_Handler

  .weak  _802_2_HOST_WKUP_IRQHandler
  .thumb_set _802_2_HOST_WKUP_IRQHandler,Default_Handler

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
