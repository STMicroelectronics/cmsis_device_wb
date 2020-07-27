;******************************************************************************
;* File Name          : startup_stm32wb15xx_cm0.s
;* Author             : MCD Application Team
;* Description        : MO+ core vector table of the STM32WB15xx devices for the
;*                      IAR (EWARM) toolchain.
;*
;*                      This module performs:
;*                      - Set the initial SP
;*                      - Set the initial PC == _iar_program_start,
;*                      - Set the vector table entries with the exceptions ISR
;*                        address.
;*                      - Branches to main in the C library (which eventually
;*                        calls main()).
;*                      After Reset the Cortex-M0+ processor is in Thread mode,
;*                      priority is Privileged, and the Stack is set to Main.
;******************************************************************************
;* @attention
;*
;* <h2><center>&copy; Copyright (c) 2019 STMicroelectronics. 
;* All rights reserved.</center></h2>
;*
;* This software component is licensed by ST under BSD 3-Clause license,
;* the "License"; You may not use this file except in compliance with the 
;* License. You may obtain a copy of the License at:
;*                        opensource.org/licenses/BSD-3-Clause
;*
;******************************************************************************
;
;
; The modules in this file are included in the libraries, and may be replaced
; by any user-defined modules that define the PUBLIC symbol _program_start or
; a user defined start symbol.
; To override the cstartup defined in the library, simply add your modified
; version to the workbench project.
;
; The vector table is normally located at address 0.
; When debugging in RAM, it can be located in RAM, aligned to at least 2^6.
; The name "__vector_table" has special meaning for C-SPY:
; it is where the SP start value is found, and the NVIC vector
; table register (VTOR) is initialized to this address if != 0.
;
; Cortex-M version
;

        MODULE  ?cstartup

        ;; Forward declaration of sections.
        SECTION CSTACK:DATA:NOROOT(3)

        SECTION .intvec:CODE:NOROOT(2)

        EXTERN  __iar_program_start
        EXTERN  SystemInit
        PUBLIC  __vector_table

        DATA
__vector_table
        DCD     sfe(CSTACK)
        DCD     Reset_Handler                     ; Reset Handler

        DCD     NMI_Handler                       ; NMI Handler
        DCD     HardFault_Handler                 ; Hard Fault Handler
        DCD     0                                 ; Reserved
        DCD     0                                 ; Reserved
        DCD     0                                 ; Reserved
        DCD     0                                 ; Reserved
        DCD     0                                 ; Reserved
        DCD     0                                 ; Reserved
        DCD     0                                 ; Reserved
        DCD     SVC_Handler                       ; SVCall Handler
        DCD     0                                 ; Reserved
        DCD     0                                 ; Reserved
        DCD     PendSV_Handler                    ; PendSV Handler
        DCD     SysTick_Handler                   ; SysTick Handler

        ; External Interrupts
        DCD     0                                 ; Reserved
        DCD     PVD_PVM_IRQHandler                ; PVD and PVM detector
        DCD     RTC_LSECSS_IRQHandler             ; RTC Wakeup + RTC Tamper and TimeStamp + RTC Alarms (A & B) and LSECSS Interrupts
        DCD     0                                 ; Reserved
        DCD     RCC_FLASH_C1SEV_IRQHandler        ; RCC and FLASH and CPU1 M4 SEV Interrupt
        DCD     EXTI1_0_IRQHandler                ; EXTI Line 1:0 Interrupt
        DCD     EXTI3_2_IRQHandler                ; EXTI Line 3:2 Interrupt
        DCD     EXTI15_4_IRQHandler               ; EXTI Line 15:4 interrupt
        DCD     TSC_IRQHandler                    ; TSC Interrupt
        DCD     DMA1_Channel1_2_3_IRQHandler      ; DMA1 Channel 1 to 3 Interrupt
        DCD     DMA1_Channel4_5_6_7_IRQHandler    ; DMA1 Channels 4,5,6,7 Interrupt 
        DCD     DMAMUX1_OVR_IRQHandler            ; DMAMUX Overrun Interrupts
        DCD     ADC1_COMP_IRQHandler              ; ADC1 and COMP1 Interrupt
        DCD     LPTIM1_IRQHandler                 ; LPTIM1 Channel 5 Interrupt
        DCD     LPTIM2_IRQHandler                 ; LPTIM2 Channel 6 Interrupt
        DCD     TIM1_IRQHandler                   ; TIM1 Interrupt
        DCD     TIM2_IRQHandler                   ; TIM2 Interrupt
        DCD     0                                 ; Reserved
        DCD     0                                 ; Reserved
        DCD     IPCC_C2_RX_C2_TX_HSEM_IRQHandler  ; IPCC RX Occupied and TX Free Interrupt and Semaphore Interrupt
        DCD     RNG_PKA_IRQHandler                ; RNG and PKA Interrupt
        DCD     AES2_IRQHandler                   ; AES2 Interrupt
        DCD     0                                 ; Reserved
        DCD     I2C1_IRQHandler                   ; I2C1 Event and Error Interrupt
        DCD     0                                 ; Reserved
        DCD     SPI1_IRQHandler                   ; SPI1 Interrupts
        DCD     0                                 ; Reserved
        DCD     USART1_IRQHandler                 ; USART1 Interrupt
        DCD     LPUART1_IRQHandler                ; LPUART1 Interrupt
        DCD     0                                 ; Reserved
        DCD     BLE_IRQHandler                    ; BLE Interrupt
        DCD     0                                 ; Reserved


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Default interrupt handlers.
;;
        THUMB

        PUBWEAK Reset_Handler
        SECTION .text:CODE:NOROOT:REORDER(2)
Reset_Handler
        LDR     R0, =SystemInit
        BLX     R0
        LDR     R0, =__iar_program_start
        BX      R0

        PUBWEAK NMI_Handler
        SECTION .text:CODE:NOROOT:REORDER(1)
NMI_Handler
        B NMI_Handler

        PUBWEAK HardFault_Handler
        SECTION .text:CODE:NOROOT:REORDER(1)
HardFault_Handler
        B HardFault_Handler

        PUBWEAK SVC_Handler
        SECTION .text:CODE:NOROOT:REORDER(1)
SVC_Handler
        B SVC_Handler

        PUBWEAK PendSV_Handler
        SECTION .text:CODE:NOROOT:REORDER(1)
PendSV_Handler
        B PendSV_Handler

        PUBWEAK SysTick_Handler
        SECTION .text:CODE:NOROOT:REORDER(1)
SysTick_Handler
        B SysTick_Handler

        PUBWEAK PVD_PVM_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
PVD_PVM_IRQHandler
        B PVD_PVM_IRQHandler

        PUBWEAK RTC_LSECSS_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
RTC_LSECSS_IRQHandler
        B RTC_LSECSS_IRQHandler

        PUBWEAK RCC_FLASH_C1SEV_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
RCC_FLASH_C1SEV_IRQHandler
        B RCC_FLASH_C1SEV_IRQHandler

        PUBWEAK EXTI1_0_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
EXTI1_0_IRQHandler
        B EXTI1_0_IRQHandler

        PUBWEAK EXTI3_2_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
EXTI3_2_IRQHandler
        B EXTI3_2_IRQHandler

        PUBWEAK EXTI15_4_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
EXTI15_4_IRQHandler
        B EXTI15_4_IRQHandler

        PUBWEAK TSC_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
TSC_IRQHandler
        B TSC_IRQHandler

        PUBWEAK DMA1_Channel1_2_3_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
DMA1_Channel1_2_3_IRQHandler
        B DMA1_Channel1_2_3_IRQHandler

        PUBWEAK DMA1_Channel4_5_6_7_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
DMA1_Channel4_5_6_7_IRQHandler
        B DMA1_Channel4_5_6_7_IRQHandler

        PUBWEAK DMAMUX1_OVR_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
DMAMUX1_OVR_IRQHandler
        B DMAMUX1_OVR_IRQHandler

        PUBWEAK ADC1_COMP_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
ADC1_COMP_IRQHandler
        B ADC1_COMP_IRQHandler

        PUBWEAK LPTIM1_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
LPTIM1_IRQHandler
        B LPTIM1_IRQHandler

        PUBWEAK LPTIM2_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
LPTIM2_IRQHandler
        B LPTIM2_IRQHandler

        PUBWEAK TIM1_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
TIM1_IRQHandler
        B TIM1_IRQHandler

        PUBWEAK TIM2_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
TIM2_IRQHandler
        B TIM2_IRQHandler

        PUBWEAK IPCC_C2_RX_C2_TX_HSEM_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
IPCC_C2_RX_C2_TX_HSEM_IRQHandler
        B IPCC_C2_RX_C2_TX_HSEM_IRQHandler

        PUBWEAK RNG_PKA_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
RNG_PKA_IRQHandler
        B RNG_PKA_IRQHandler

        PUBWEAK AES2_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
AES2_IRQHandler
        B AES2_IRQHandler

        PUBWEAK I2C1_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
I2C1_IRQHandler
        B I2C1_IRQHandler

        PUBWEAK SPI1_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
SPI1_IRQHandler
        B SPI1_IRQHandler

        PUBWEAK USART1_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
USART1_IRQHandler
        B USART1_IRQHandler

        PUBWEAK LPUART1_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
LPUART1_IRQHandler
        B LPUART1_IRQHandler

        PUBWEAK BLE_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
BLE_IRQHandler
        B BLE_IRQHandler

        END

;************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE*****
