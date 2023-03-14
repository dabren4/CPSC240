
;========= Begin Code ===========

global append

segment .data

segment .bss

segment .text
append:

;Prolog ===== Insurance for any caller of this assembly module ====================================================================
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




push qword 0        ;Staying in the boundary
;mov rax, 0

;Setting up the append function prototype append(arr1, s1, arr2, s2, arr3)
;Taking information from parameters
mov r15, rdi        ;pass first array as the first parameter
mov r14, rsi        ;pass the number of elements for the first array in the second parameter
mov r13, rdx        ;pass the second array as the third parameter
mov r12, rcx        ;pass the number of elements for the second array as the fourth parameter
mov r11, r8         ;pass the third array as the fifth parameter


mov r10, 0  ;counter for the loop

;Loop the first array and second array to store the elements into the third array
initiateLoop:
cmp r10, r14        ;condition which compares the counter if it reaches the size of the first array
je finishLoop       ;If the condition is met then jump to the end of the loop

movsd xmm15, [r15 + 8 * r10]        ;copy the first array elements into xmm15
movsd [r11 + 8 * r10], xmm15        ;copy the xmm15 elements into the third array
inc r10                            ;increment the loop counter
jmp initiateLoop

finishLoop:

mov r9, 0               ;initialize a new loop counter for the second loop

initiateLoop2:
cmp r9, r12
je finishLoop2

movsd xmm15, [r13 + 8 * r9]     ;copy all the elements in the second array with r9 as the index into xmm15
movsd [r11 + 8 * r10], xmm15       ;copy all elements in xmm15 into the third array with r10 as the index from the first loop
inc r9                              ;increment the loop counter
inc r10                             ;increment the index for the third array to update the new elements added
jmp initiateLoop2

finishLoop2:

pop rax                     ;reverses the push qword 0 at the beginning of the program

mov rax, r10                   ;stores the number of elements for the third array and return it to the manager module


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
