; Copyright 2023 Darren Chen
; This program is free software, you can redistribute it and or modify it
; under the terms of the GNU General Public License version 3
; A copy of the GNU General Public License version 3 is available here: https://www.gnu.org/licenses/

; Author Name: Darren Chen
; Author Email: dchen4@csu.fullerton.edu

; Program name: Non-Deterministic Random Numbers
; Files in program: main.cpp, executive.asm, fill_random_array.asm, show_array.asm, quicksort.cpp, r.sh
; System requirements: Linux on an x86 machine
; Programming languages: x86 Assembly, C++ and SH
; Date program development began: 3/07/2023
; Date finished: 3/13/2023
; Status: No known errors

; Language: x86 Assembly
; No data passed to this module. Module passes string back to main.

; Translation information
; Run r.sh script

;===================================================================================================================

extern printf


section .data
format: db "%s", 10, 0
headers: db   "IEEE754                    Scientific Decimal", 0
numformat: db "0x%016lx         %f",10, 0
;numformat: db "0x%016lx         %-18.13g",10, 0
;0x%016lx

section .bss

section .text
global show_array

show_array:

push rbp
  mov rbp, rsp
  push rdi                                                    ;Backup rdi
  push rsi                                                    ;Backup rsi
  push rdx                                                    ;Backup rdx
  push rcx                                                    ;Backup rcx
  push r8                                                     ;Backup r8
  push r9                                                     ;Backup r9
  push r10                                                    ;Backup r10
  push r11                                                    ;Backup r11
  push r12                                                    ;Backup r12
  push r13                                                    ;Backup r13
  push r14                                                    ;Backup r14
  push r15                                                    ;Backup r15
  push rbx                                                    ;Backup rbx
  pushf

  xor r15, r15
  mov r14, rdi
  mov r13, rsi

  mov rax, 0
  mov rdi, format
  mov rsi, headers
  call printf

  ;loop prints every value of the array for count
beginLoop:
  cmp r15, r13
  je exitLoop


  mov rsi, [r14 + 8*r15]
  movsd xmm0, [r14 + 8*r15]


  mov rax, 1
  mov rdi, numformat
  call printf


  inc r15
  jmp beginLoop

exitLoop:


    popf ; Restore rflags
    pop rbx ; Restore rbx
    pop r15 ; Restore r15
    pop r14 ; Restore r14
    pop r13 ; Restore r13
    pop r12 ; Restore r12
    pop r11 ; Restore r11
    pop r10 ; Restore r10
    pop r9 ; Restore r9
    pop r8 ; Restore r8
    pop rcx ; Restore rcx
    pop rdx ; Restore rdx
    pop rsi ; Restore rsi
    pop rdi ; Restore rdi

    pop rbp ; Restore rbp
    ret
