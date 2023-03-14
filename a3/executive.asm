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
extern fill_random_array
extern scanf
extern fgets
extern stdin
extern strlen
extern show_array
extern quicksort


INPUT_LEN equ 256 ; Max bytes of name, title, response

section .data
  format: db "%s", 0 ; Format indicating a null-terminated string, c-string
  int_format: db "%d", 0

  message1:  db        "Please enter your name: ", 0   ; newline would be 10 normally
  message2:  db        "Please enter your title (Ms, Mr, Engineer, Programmer, Mathematician, Genius, etc): ", 0
  message3:  db        "Nice to meet you ", 0
  message4:  db        "This program will generate 64-bit IEEE float numbers.", 0
  message5:  db        "How many numbers do you want? Today's limit is 100 per customer. ", 0
  message6:  db        "Your numbers have been stored in an array. Here is that array.", 0
  sort_msg:  db        "The array is now being sorted.", 10, 0
  update_msg:db        "Here is the updated array.", 10, 0
  spc: db " ", 0 ; space character

section .bss
  ; === Reserve bytes for the title, name, and response given by user ===
  ; Reserve 256 bytes for each
  title: resb INPUT_LEN
  name: resb INPUT_LEN
  count: resq 1

  Array1: resq 100

section .text
global executive
global Array1

executive:
  push rbp ; Push memory address of base of previous stack frame onto stack top
  mov rbp, rsp ; Copy value of stack pointer into base pointer, rbp = rsp = both point to stack top
  ; Rbp now holds the address of the new stack frame, i.e "top" of stack
  push rdi ; Backup rdi
  push rsi ; Backup rsi
  push rdx ; Backup rdx
  push rcx ; Backup rcx
  push r8 ; Backup r8
  push r9 ; Backup r9
  push r10 ; Backup r10
  push r11 ; Backup r11
  push r12 ; Backup r12
  push r13 ; Backup r13
  push r14 ; Backup r14
  push r15 ; Backup r15
  push rbx ; Backup rbx
  pushf ; Backup rflags

  ; Mov rax, 0 = move 0 into rax, i.e rax = 0.
  ; 0 indicates we will not have any floating pt arguments, so 0 XMM registers used
  mov rax, 0

  ; prints
  mov rdi, format       ; Passes 1st parameter to printf
  mov rsi, message1     ; Passes 2nd parameter to printf
  call printf           ; Call external C print funct

  ;get user input
  mov rax, 0
  mov rdi, name
  ; Provide fgets with the second argument, the size of the bytes reserved
  ; Move into second argument register rsi
  mov rsi, INPUT_LEN ; read 256 bytes

  ; Move the contents at address of stdin, i.e. dereference, into 3rd argument
  ; register
  mov rdx, [stdin]

  ; Call the external function fgets
  call fgets

  mov rax, 0 ; Indicate 0 floating point arguments
  mov rdi, format ; Move string format argument into register rdi
  mov rsi, message2 ; Move message2 into second argument register rsi
  call printf ; Call external function printf

  mov rax, 0 ; Indicate we have no floating point arguments to pass to external function
  mov rdi, title ; Move first argument into argument register rdi
  mov rsi, INPUT_LEN ; Provide fgets with the second argument, the size of the bytes reserved, then move it into second argument register rsi
  mov rdx, [stdin] ; Move the contents at address of stdin, i.e. dereference, into 3rd argument register
  call fgets ; Call the external function fgets

  mov rax, 0                ; Indicate 0 floating point arguments
  mov rdi, title            ; Move title into the first argument register
  call strlen               ; Call external function strlen, which returns the length of the string leading up to '\0'
  sub rax, 1                ; The length is stored in rax. Here we subtract 1 from rax to obtain the location of '\n'
  mov byte [title + rax], 0 ; Replace the byte where '\n' exits with '

  mov rax, 0                ; Indicate 0 floating point arguments
  mov rdi, format           ; Move string format argument into register rdi
  mov rsi, message3         ; Move message3 into second argument register rsi
  call printf               ; Call external function printf

  mov rax, 0                ; Indicate 0 floating point arguments
  mov rdi, format           ; Move string format argument into register rdi
  mov rsi, title            ; Move title into second argument register rsi
  call printf               ; Call external function printf

  mov rax, 0                ; Indicate 0 floating point arguments
  mov rdi, format           ; Move string format argument into register rdi
  mov rsi, spc              ; Move space character to format output into second argument register rsi
  call printf               ; Call external function printf

  mov rax, 0                ; Indicate 0 floating point arguments
  mov rdi, format           ; Move string format argument into register rdi
  mov rsi, name             ; Move name into second argument register rsi
  call printf               ; Call external function printf

  mov rax, 0                ; Indicate 0 floating point arguments
  mov rdi, format           ; Move string format argument into register rdi
  mov rsi, message4         ; Move message4 into second argument register rsi
  call printf               ; Call external function printf


  mov rax, 0                ; Indicate 0 floating point arguments
  mov rdi, format           ; Move string format argument into register rdi
  mov rsi, message5         ; Move message5 into second argument register rsi
  call printf               ; Call external function printf

inputLoop:
  ;take in user input for amt of arrays
  mov rax, 0
  mov rdi, int_format
  mov rsi, count
  call scanf

  cmp qword [count], 100
  jge inputLoop
  cmp qword [count], 0
  jle inputLoop

exitLoop:

  ;pass in number given and call fill_random_arrays
  mov rax, 0
  mov rdi, Array1
  mov rsi, [count]
  call fill_random_array


  ;show_array
  mov rax, 0
  mov rdi, Array1
  mov rsi, [count]
  call show_array

  ;Sorting message
  mov rax, 0                ; Indicate 0 floating point arguments
  mov rdi, format           ; Move string format argument into register rdi
  mov rsi, sort_msg         ; Move message4 into second argument register rsi
  call printf               ; Call external function printf

  ;call quicksort
  mov rax, 0
  mov rdi, Array1
  mov rsi, [count]
  call quicksort

  ;update message
  mov rax, 0                ; Indicate 0 floating point arguments
  mov rdi, format           ; Move string format argument into register rdi
  mov rsi, update_msg         ; Move message4 into second argument register rsi
  call printf               ; Call external function printf

  ;show_array but sorted
  mov rax, 0
  mov rdi, Array1
  mov rsi, [count]
  call show_array

  mov rax, 0 ; Indicate 0 floating point arguments
  mov rdi, name ; Move name into the first argument register
  call strlen ; Call external function strlen, which returns the length of the string leading up to '\0'
  sub rax, 1 ; The length is stored in rax. Here we subtract 1 from rax to obtain the location of '\n'
  mov byte [name + rax], 0 ; Replace the byte where '\n' exits with '

  mov rax, name

  ;Epilogue
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
