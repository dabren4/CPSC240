
;========= Begin Code ===========
extern scanf
extern printf
extern stdin
extern clearerr
extern isfloat
extern atof


global inputarray

segment .data

string_out_format db "%s", 0

invalid_msg db "The last input was invalid and not entered into the array. ", 0

segment .bss


segment .text
inputarray:

;Prolog ===== Insurance for any caller of this assembly module ====================================================================
;Any future program calling this module that the data in the caller's GPRs will not be modified.

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
pushf                                                       ;Backup rflags



push qword 0                ;Set the boundary
;Taking information from parameters
mov r14, rdi                ;holds the first parameter which is the array
mov r13, rsi                ;holds the second parameter which is the number of elements in that array

mov r12, 0                  ;for loop counter set to 0


;===========================Taking User Input =======================================================
beginLoop:

cmp r12, r13                ;condition that compares if the index reached the capacity of the array

;Takes user input and stores it for later usage
push qword 0
mov rax, 0
mov rdi, string_out_format      ;"%s"
mov rsi, rsp
call scanf


;Check to see if the user pressed Ctrl + D to finish their input
cdqe
cmp rax, -1         ;condition to terminate the loop when the user presses ctrl + D
je endLoop


;================= Validation for Float Values ====================================

;the user's input is checked to see if it is a valid float value
mov rax, 0
mov rdi, rsp            ;passing user input stored at the top of the stack into the first parameter
call isfloat               ;isfloat checks if the user entered a valid float value
cmp rax, 0                  ;A condition is met if a valid float is entered it returns 1, else it returns 0
je invalidInput


;converts the user's float from a string to float
mov rax, 0
mov rdi, rsp            ;passing the user input stored at the top of the stack into the first parameter
call atof               ;atof convers a string float into a double float value
movsd xmm14, xmm0    ;backup the elements in xmm0 and copies into xmm14
pop r11             ;reverse the push qword in the loop if it jumps through this block

movsd [r14 + r12 * 8], xmm14   ;copies the elements in xmm14 into the array
inc r12             ;increment the loop counter
jmp beginLoop

invalidInput:
;A invalid message displays if the user did not input a valid float value
mov rax, 0
mov rdi, invalid_msg        ;"The last input was invalid and not entered into the array. "
call printf
pop r11                     ;reverse the push qword in the loop if it runs into invalidInput
jmp beginLoop

;================Prepare to end the input_array.asm module ================================
endLoop:

pop rax ;reverse the push qword 0 in the loop once it exits

;Set the failbit back to 0
push qword 0
mov rax, 0
mov rdi, [stdin]
call clearerr
pop rax


pop rax                 ;reverse the first push qword 0 of the program

mov rax, r12                ;store the number of elements in the array from the counter of the loop and send it back to the manager module



;===== Restore original values to integer registers ===============================================================================


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


;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
