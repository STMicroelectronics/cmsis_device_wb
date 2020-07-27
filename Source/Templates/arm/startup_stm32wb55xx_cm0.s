;******************************************************************************
;* File Name          : startup_stm32wb55xx_cm0.s
;* Author             : MCD Application Team
;* Description        : STM32WB55xx devices vector table for MDK-ARM toolchain.
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
;* This software component is licensed by ST under BSD 3-Clause license,
;* the "License"; You may not use this file except in compliance with the 
;* License. You may obtain a copy of the License at:
;*                        opensource.org/licenses/BSD-3-Clause
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
                DCD     USB_CRS_IRQHandler               ; USB High Priority, Low Priority (including USB wakeup) and CRS Interrupts
                DCD     RCC_FLASH_C1SEV_IRQHandler       ; RCC1 and FLASH and CPU1 M4 SEV Interrupt
                DCD     EXTI1_0_IRQHandler               ; EXTI Line 1:0 Interrupt
                DCD     EXTI3_2_IRQHandler               ; EXTI Line 3:2 Interrupt
                DCD     EXTI15_4_IRQHandler              ; EXTI Line 15:4 interrupt
                DCD     TSC_802_0_IRQHandler                  ; TSC Interrupt
                DCD     DMA1_Channel1_2_3_IRQHandler     ; DMA1 Channel 1 to 3 Interrupt
                DCD     DMA1_Channel4_5_6_7_IRQHandler   ; DMA1 Channels 4,5,6,7 Interrupt 
                DCD     DMA2_DMAMUX1_OVR_IRQHandler      ; DMA2 Channels[1..7] and DMAMUX Overrun Interrupts          
                DCD     ADC1_COMP_IRQHandler             ; ADC1 and COMP1 COMP2 Interrupt
                DCD     LPTIM1_IRQHandler                ; LPTIM1 Channel 5 Interrupt
                DCD     LPTIM2_IRQHandler                ; LPTIM2 Channel 6 Interrupt
                DCD     TIM1_IRQHandler                  ; TIM1 Interrupt
                DCD     TIM2_IRQHandler                  ; TIM2 Interrupt
                DCD     TIM16_IRQHandler                 ; TIM16 Interrupt
                DCD     TIM17_IRQHandler                 ; TIM17 Interrupt
                DCD     IPCC_C2_RX_C2_TX_HSEM_IRQHandler ; IPCC RX Occupied and TX Free Interrupt and Semaphore Interrupt
                DCD     AES1_RNG_PKA_IRQHandler          ; AES1,RNG and PKA Interrupt
                DCD     AES2_IRQHandler                  ; AES2 Interrupt
                DCD     LCD_802_1_IRQHandler             ; LCD Interrupt and 802.15.4 interrupt 1
                DCD     I2C1_IRQHandler                  ; I2C1 Event and Error Interrupt
                DCD     I2C3_IRQHandler                  ; I2C3 Event and Error Interrupt
                DCD     SPI1_IRQHandler                  ; SPI1 Interrupts
                DCD     SPI2_IRQHandler                  ; SPI2 Interrupt
                DCD     USART1_IRQHandler                ; USART1 Interrupt
                DCD     LPUART1_IRQHandler               ; LPUART1 Interrupt
                DCD     SAI1_IRQHandler                  ; SAI1 Interrupt
                DCD     BLE_IRQHandler                   ; BLE Interrupt
                DCD     _802_2_HOST_WKUP_IRQHandler      ; 802.15.4 Interrupt
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
                EXPORT  TSC_802_0_IRQHandler             [WEAK]
                EXPORT  DMA1_Channel1_2_3_IRQHandler     [WEAK]
                EXPORT  DMA1_Channel4_5_6_7_IRQHandler   [WEAK]
                EXPORT  DMA2_DMAMUX1_OVR_IRQHandler      [WEAK]
                EXPORT  ADC1_COMP_IRQHandler             [WEAK]
                EXPORT  LPTIM1_IRQHandler                [WEAK]
                EXPORT  LPTIM2_IRQHandler                [WEAK]
                EXPORT  TIM1_IRQHandler                  [WEAK]
                EXPORT  TIM2_IRQHandler                  [WEAK]
                EXPORT  TIM16_IRQHandler                 [WEAK]
                EXPORT  TIM17_IRQHandler                 [WEAK]
                EXPORT  IPCC_C2_RX_C2_TX_HSEM_IRQHandler [WEAK]
                EXPORT  AES1_RNG_PKA_IRQHandler          [WEAK]
                EXPORT  AES2_IRQHandler                  [WEAK]
                EXPORT  LCD_802_1_IRQHandler             [WEAK]
                EXPORT  I2C1_IRQHandler                  [WEAK]
                EXPORT  I2C3_IRQHandler                  [WEAK]
                EXPORT  SPI1_IRQHandler                  [WEAK]
                EXPORT  SPI2_IRQHandler                  [WEAK]
                EXPORT  USART1_IRQHandler                [WEAK]
                EXPORT  LPUART1_IRQHandler               [WEAK]
                EXPORT  SAI1_IRQHandler                  [WEAK]
                EXPORT  BLE_IRQHandler                   [WEAK]
                EXPORT  _802_2_HOST_WKUP_IRQHandler      [WEAK]

PVD_PVM_IRQHandler
RTC_LSECSS_IRQHandler
USB_CRS_IRQHandler
RCC_FLASH_C1SEV_IRQHandler
EXTI1_0_IRQHandler
EXTI3_2_IRQHandler
EXTI15_4_IRQHandler
TSC_802_0_IRQHandler
DMA1_Channel1_2_3_IRQHandler
DMA1_Channel4_5_6_7_IRQHandler
DMA2_DMAMUX1_OVR_IRQHandler
ADC1_COMP_IRQHandler
LPTIM1_IRQHandler
LPTIM2_IRQHandler
TIM1_IRQHandler
TIM2_IRQHandler
TIM16_IRQHandler
TIM17_IRQHandler
IPCC_C2_RX_C2_TX_HSEM_IRQHandler
AES1_RNG_PKA_IRQHandler
AES2_IRQHandler
LCD_802_1_IRQHandler
I2C1_IRQHandler
I2C3_IRQHandler
SPI1_IRQHandler
SPI2_IRQHandler
USART1_IRQHandler
LPUART1_IRQHandler
SAI1_IRQHandler
BLE_IRQHandler
_802_2_HOST_WKUP_IRQHandler

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
