;****************************************************************************************************************************
;Program name: "Pythagoras".  This program takes in the user input of 2 sides of a triangle and calculates the hypotenuse. Copyright (C) 2023 Darren Chen.                                                                           *
;                                                                                                                           *
;This file is part of the software program "Pythagoras".                                                                   *
;Pythagoras is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License   *
;version 3 as published by the Free Software Foundation.                                                                    *
;Pythagoras is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied          *
;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
;A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                            *
;****************************************************************************************************************************




;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;
;Author information
;  Author name: Darren Chen
;  Author email: dchen4@csu.fullerton.edu
;
;Program information
;  Program name: RectanPythagorasgle
;  Programming languages: One modules in C++ and one module in X86
;  Date program began: 2023 Jan 28
;  Date of last update: 2023 Feb 06
;
;  Files in this program: driver.cpp, pythagoras.asm
;  Status: Finished.
;
;This file
;   File name: pythagoras.asm
;   Language: X86 with Intel syntax.
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l pythagoras.lis -o pythagoras.o pythagoras.asm

;===== Begin code area ================================================================================================
extern printf
extern scanf
global pythagoras

segment .data

input1prompt db "Enter the length of the first side of the triangle: ", 0
input2prompt db "Enter the length of the second side of the triangle: ", 0

one_float_format db "%lf",0

output_both_floats db "Thank you. You entered two sides: %.6lf and %.6lf ", 10, 0
output_hypotenuse_float db "The length of the hypotenuse is %.6lf", 10, 0

segment .bss
segment .text

pythagoras:
;prolog
;Any future program calling this module that the data in the caller's GPRs will not be modified.

push rbp
mov  rbp,rsp
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
pushf                                                       ;Backup rflags

;Registers rax, rip, and rsp are usually not backed up.
push qword 0


;msg and input for the first prompt
;
;display first prompt
push qword 0 ; Every printf and scanf statement needs to start with this
mov rax, 0
mov rdi, input1prompt
call printf
pop rax ; Every printf and scanf statement needs to end with this

;take user input
push qword 0
mov rax, 0
mov rdi, one_float_format
mov rsi, rsp
call scanf
movsd xmm10, [rsp]
pop rax

;msd and input for the second prompt
;
;display 2nd prompt
push qword 0
mov rax, 0
mov rdi, input2prompt
call printf
pop rax

;take user input
push qword 0
mov rax, 0
mov rdi, one_float_format
mov rsi, rsp
call scanf
movsd xmm11, [rsp]
pop rax

push qword 0

;display message with the two inputs

mov rax, 2
mov rdi, output_both_floats
movsd xmm0, xmm10
movsd xmm1, xmm11
call printf
pop rax


;calculate the hypotenuse from the user inputs

mulsd xmm10, xmm10 ;Square the input in xmm10 and store it in there
mulsd xmm11, xmm11 ;Square the 2nd input in xmm11 and store it in there
addsd xmm11, xmm10 ;add the result from xmm10 to xmm11 and copy it into xmm11
sqrtsd xmm15, xmm11 ;take the square root of the result in xmm11 and copy it into xmm15

;display hypotenuse length
push qword 0
mov rax, 1
mov rdi, output_hypotenuse_float
movsd xmm0, xmm15
call printf
pop rax

;ending

pop rax ;reverse the push qword 0 at the beginning

;return the hypotenuse to the driver
movsd xmm0, xmm15

;===== Restore original values to integer registers ===================================================================
popf                                                        ;Restore rflags
pop rbx                                                     ;Restore rbx
pop r15                                                     ;Restore r15
pop r14                                                     ;Restore r14
pop r13                                                     ;Restore r13
pop r12                                                     ;Restore r12
pop r11                                                     ;Restore r11
pop r10                                                     ;Restore r10
pop r9                                                      ;Restore r9
pop r8                                                      ;Restore r8
pop rcx                                                     ;Restore rcx
pop rdx                                                     ;Restore rdx
pop rsi                                                     ;Restore rsi
pop rdi                                                     ;Restore rdi
pop rbp                                                     ;Restore rbp


ret
