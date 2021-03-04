;******************************************************************************
;* File Name          : startup_stm32wb15xx_cm0.s
;* Author             : MCD Application Team
;* Description        : STM32WB15xx devices vector table for MDK-ARM toolchain.
;*                      This module performs:
;*                      - Set the initial SP
;*                      - Set the initial PC == Reset_Handler
;*                      - Set the vector table entries with the exceptions ISR address
;*                      - Branches to __main in the C library (which eventually
;*                        calls main()).
;*                      After Reset the Cortex-M0+ processor is in Thread mode,
;*                      priority is Privileged, and the Stack is set to Main.
;* <<< Use Configuration Wizard in Context Menu >>>   
;******************************************************************************
;* @attention
;*
;* Copyright (c) 2019 STMicroelectronics. All rights reserved.
;*
;* This software component is licensed by ST under Apache License, Version 2.0,
;* the "License"; You may not use this file except in compliance with the 
;* License. You may obtain a copy of the License at:
;*                        opensource.org/licenses/Apache-2.0
;*
;******************************************************************************

; Amount of memory (in bytes) allocated for Stack
; Tailor this value to your application needs
; <h> Stack Configuration
;   <o> Stack Size (in Bytes) <0x0-0xFFFFFFFF:8>
; </h>

Stack_Size      EQU     0x00000400

                AREA    STACK, NOINIT, READWRITE, ALIGN=3
Stack_Mem       SPACE   Stack_Size
__initial_sp


; <h> Heap Configuration
;   <o>  Heap Size (in Bytes) <0x0-0xFFFFFFFF:8>
; </h>

Heap_Size       EQU     0x00000200

                AREA    HEAP, NOINIT, READWRITE, ALIGN=3
__heap_base
Heap_Mem        SPACE   Heap_Size
__heap_limit

                PRESERVE8
                THUMB


; Vector Table Mapped to Address 0 at Reset
                AREA    RESET, DATA, READONLY
                EXPORT  __Vectors
                EXPORT  __Vectors_End
                EXPORT  __Vectors_Size

__Vectors       DCD     __initial_sp                     ; Top of Stack
                DCD     Reset_Handler                    ; Reset Handler
                DCD     NMI_Handler                      ; NMI Handler
                DCD     HardFault_Handler                ; Hard Fault Handler
                DCD     0                                ; Reserved
                DCD     0                                ; Reserved
                DCD     0                                ; Reserved
                DCD     0                                ; Reserved
                DCD     0                                ; Reserved
                DCD     0                                ; Reserved
                DCD     0                                ; Reserved
                DCD     SVC_Handler                      ; SVCall Handler
                DCD     0                                ; Reserved
                DCD     0                                ; Reserved
                DCD     PendSV_Handler                   ; PendSV Handler
                DCD     SysTick_Handler                  ; SysTick Handler
                DCD     0                                ; Reserved

                ; External Interrupts                    
                DCD     PVD_PVM_IRQHandler               ; PVD and PVM detector
                DCD     RTC_LSECSS_IRQHandler            ; RTC Wakeup + RTC Tamper and TimeStamp + RTC Alarms (A & B) and LSECSS Interrupts
                DCD     0                                ; Reserved
                DCD     RCC_FLASH_C1SEV_IRQHandler       ; RCC and FLASH and CPU1 M4 SEV Interrupt
                DCD     EXTI1_0_IRQHandler               ; EXTI Line 1:0 Interrupt
                DCD     EXTI3_2_IRQHandler               ; EXTI Line 3:2 Interrupt
                DCD     EXTI15_4_IRQHandler              ; EXTI Line 15:4 interrupt
                DCD     TSC_IRQHandler                   ; TSC Interrupt
                DCD     DMA1_Channel1_2_3_IRQHandler     ; DMA1 Channel 1 to 3 Interrupt
                DCD     DMA1_Channel4_5_6_7_IRQHandler   ; DMA1 Channels 4,5,6,7 Interrupt 
                DCD     DMAMUX1_OVR_IRQHandler           ; DMAMUX Overrun Interrupts
                DCD     ADC1_COMP_IRQHandler             ; ADC1 and COMP1 Interrupt
                DCD     LPTIM1_IRQHandler                ; LPTIM1 Channel 5 Interrupt
                DCD     LPTIM2_IRQHandler                ; LPTIM2 Channel 6 Interrupt
                DCD     TIM1_IRQHandler                  ; TIM1 Interrupt
                DCD     TIM2_IRQHandler                  ; TIM2 Interrupt
                DCD     0                                ; Reserved
                DCD     0                                ; Reserved
                DCD     IPCC_C2_RX_C2_TX_HSEM_IRQHandler ; IPCC RX Occupied and TX Free Interrupt and Semaphore Interrupt
                DCD     RNG_PKA_IRQHandler               ; RNG and PKA Interrupt
                DCD     AES2_IRQHandler                  ; AES2 Interrupt
                DCD     0                                ; Reserved
                DCD     I2C1_IRQHandler                  ; I2C1 Event and Error Interrupt
                DCD     0                                ; Reserved
                DCD     SPI1_IRQHandler                  ; SPI1 Interrupts
                DCD     0                                ; Reserved
                DCD     USART1_IRQHandler                ; USART1 Interrupt
                DCD     LPUART1_IRQHandler               ; LPUART1 Interrupt
                DCD     0                                ; Reserved
                DCD     BLE_IRQHandler                   ; BLE Interrupt
                DCD     0                                ; Reserved
__Vectors_End

__Vectors_Size  EQU  __Vectors_End - __Vectors

                AREA    |.text|, CODE, READONLY

; Reset handler
Reset_Handler    PROC
                 EXPORT  Reset_Handler                 [WEAK]
        IMPORT  SystemInit
        IMPORT  __main

                 LDR     R0, =SystemInit
                 BLX     R0
                 LDR     R0, =__main
                 BX      R0
                 ENDP

; Dummy Exception Handlers (infinite loops which can be modified)

NMI_Handler     PROC
                EXPORT  NMI_Handler                    [WEAK]
                B       .
                ENDP
HardFault_Handler\
                PROC
                EXPORT  HardFault_Handler              [WEAK]
                B       .
                ENDP
SVC_Handler     PROC
                EXPORT  SVC_Handler                    [WEAK]
                B       .
                ENDP
PendSV_Handler  PROC
                EXPORT  PendSV_Handler                 [WEAK]
                B       .
                ENDP
SysTick_Handler PROC
                EXPORT  SysTick_Handler                [WEAK]
                B       .
                ENDP

Default_Handler PROC
                EXPORT  PVD_PVM_IRQHandler               [WEAK]
                EXPORT  RTC_LSECSS_IRQHandler            [WEAK]
                EXPORT  USB_CRS_IRQHandler               [WEAK]
                EXPORT  RCC_FLASH_C1SEV_IRQHandler       [WEAK]
                EXPORT  EXTI1_0_IRQHandler               [WEAK]
                EXPORT  EXTI3_2_IRQHandler               [WEAK]
                EXPORT  EXTI15_4_IRQHandler              [WEAK]
                EXPORT  TSC_IRQHandler                   [WEAK]
                EXPORT  DMA1_Channel1_2_3_IRQHandler     [WEAK]
                EXPORT  DMA1_Channel4_5_6_7_IRQHandler   [WEAK]
                EXPORT  DMAMUX1_OVR_IRQHandler           [WEAK]
                EXPORT  ADC1_COMP_IRQHandler             [WEAK]
                EXPORT  LPTIM1_IRQHandler                [WEAK]
                EXPORT  LPTIM2_IRQHandler                [WEAK]
                EXPORT  TIM1_IRQHandler                  [WEAK]
                EXPORT  TIM2_IRQHandler                  [WEAK]
                EXPORT  IPCC_C2_RX_C2_TX_HSEM_IRQHandler [WEAK]
                EXPORT  RNG_PKA_IRQHandler               [WEAK]
                EXPORT  AES2_IRQHandler                  [WEAK]
                EXPORT  I2C1_IRQHandler                  [WEAK]
                EXPORT  SPI1_IRQHandler                  [WEAK]
                EXPORT  USART1_IRQHandler                [WEAK]
                EXPORT  LPUART1_IRQHandler               [WEAK]
                EXPORT  BLE_IRQHandler                   [WEAK]

PVD_PVM_IRQHandler
RTC_LSECSS_IRQHandler
USB_CRS_IRQHandler
RCC_FLASH_C1SEV_IRQHandler
EXTI1_0_IRQHandler
EXTI3_2_IRQHandler
EXTI15_4_IRQHandler
TSC_IRQHandler
DMA1_Channel1_2_3_IRQHandler
DMA1_Channel4_5_6_7_IRQHandler
DMAMUX1_OVR_IRQHandler
ADC1_COMP_IRQHandler
LPTIM1_IRQHandler
LPTIM2_IRQHandler
TIM1_IRQHandler
TIM2_IRQHandler
IPCC_C2_RX_C2_TX_HSEM_IRQHandler
RNG_PKA_IRQHandler
AES2_IRQHandler
I2C1_IRQHandler
SPI1_IRQHandler
USART1_IRQHandler
LPUART1_IRQHandler
BLE_IRQHandler

                B       .

                ENDP

                ALIGN

;*******************************************************************************
; User Stack and Heap initialization
;*******************************************************************************
                 IF      :DEF:__MICROLIB

                 EXPORT  __initial_sp
                 EXPORT  __heap_base
                 EXPORT  __heap_limit

                 ELSE

                 IMPORT  __use_two_region_memory
                 EXPORT  __user_initial_stackheap

__user_initial_stackheap

                 LDR     R0, =  Heap_Mem
                 LDR     R1, =(Stack_Mem + Stack_Size)
                 LDR     R2, = (Heap_Mem +  Heap_Size)
                 LDR     R3, = Stack_Mem
                 BX      LR

                 ALIGN

                 ENDIF

                 END

;************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE*****
