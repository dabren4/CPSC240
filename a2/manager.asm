

;========= Begin Code ===========
extern printf
extern scanf
extern printArray
extern inputarray
extern magnitude
extern append


global myArray

segment .data

start_msg db "This program will manage your arrays of 64-bit floats ", 0
first_arr_prompt db "For array A enter a sequence of 64-bit floats separated by white space. ", 10
                 db "After the last input press enter followed by Control + D:", 10, 0
sec_arr_prompt db "For array B enter a sequence of 64-bit floats separated by white space. ", 10
                 db "After the last input press enter followed by Control + D:", 10, 0

display_msgA db "These numbers were received and placed into array A:", 10, 0
display_msgB db "These numbers were received and placed into array B:", 10, 0

magnitude_msgA db "The magnitude of array A is %.5lf", 10, 0
magnitude_msgB db "The magnitude of array B is %.5lf", 10, 0

array_AB_msg db "Array A and B have been appended and given the name A", 0xE2, 0x8A, 0x95," B.", 10
             db "A", 0xE2, 0x8A, 0x95," B contains", 10, 0

magnitude_msgAB db "The magnitude of A", 0xE2, 0x8A, 0x95," B is %.5lf", 10, 0

empty_space db " ", 10, 0


segment .bss ;reserved for uninitialized data

myArr1 resq 25 ;array of 25 quad words reserved before run time.
myArr2 resq 25 ;array of 25 quad words reserved before run time.
sum_Arr resq 50 ;array of 50 quad words reserved before run time.

segment .text ;reserved for executing instructions.

;Prolog ===== Insurance for any caller of this assembly module ====================================================================
;Any future program calling this module that the data in the caller's GPRs will not be modified.

myArray:

push rbp
mov  rbp, rsp
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


;============= Begin the program =========================

push qword 0        ;remain on the boundary

;Displays the message about managing user's arrays
push qword 0
mov rax, 0                      ;A zero in rax means printf does not use data from xmm registers.
mov rdi, start_msg              ;"This program will manage your arrays of 64-bit floats "
call printf
pop rax


;================= Working with first array ===========================
;Displays message asking for user input into first array
push qword 99                       ;Get on the boundary
mov rax, 0
mov rdi, first_arr_prompt           ;"For array A enter a sequence of 64-bit floats separated by white space. " ;"After the last input press enter followed by Control + D:"
call printf
pop rax                             ;reverses the previous "push qword 99"

;User input is obtained and processed for later use
push qword 0
mov rax, 0
mov rdi, myArr1         ;first array passed in as the first parameter
mov rsi, 25             ;the fixed array size is passed in as the second parameter
call inputarray        ;calls inputarray function from the input_array.asm module to take in user's input
mov r15, rax            ;the number of elements in the first array is backed up into rax and copied into r15
pop rax

;Displays an empty new line
push qword 0
mov rax, 0
mov rdi, empty_space        ;" "
call printf
pop rax

;A message is displayed about the user's first array
push qword 0
mov rax, 0
mov rdi, display_msgA       ;"These numbers were received and placed into array A:"
call printf
pop rax

;The user's first array is shown
push qword 0
mov rax, 0
mov rdi, myArr1         ;the first array is passed as the first parameter
mov rsi, r15            ;the current number of elements in the first array is passed as the 2nd parameter
call printArray         ;printArray is called from the display module to display the user's first array
pop rax

;magnitude of the user's array is being calculated
push qword 0
mov rax, 0
mov rdi, myArr1             ;the first array is passed as the first parameter
mov rsi, r15                ;number of elements for the first array is passed as the second parameter
call magnitude             ;magnitude function is called to calculate the first array's magnitude
movsd xmm14, xmm0           ;the magnitude is backed up in the xmm0 registered and copied to xmm14
pop rax

;The magnitude of the user's first array is shown
push qword 0
mov rax, 1                  ;printf will need to access 1 SSE register
mov rdi, magnitude_msgA     ;"The magnitude of array A is %.10lf"
movsd xmm0, xmm14           ;xmm14 copies the magnitude over to xmm0 to be displayed
call printf
pop rax

;printing an empty new line
push qword 0
mov rax, 0
mov rdi, empty_space        ;" "
call printf
pop rax

;====================== Working with the second array ==================================
;prompt for the user to enter a second array
push qword 99                   ;Get on the boundary
mov rax, 0
mov rdi, sec_arr_prompt         ;"For array B enter a sequence of 64-bit floats separated by white space. " "After the last input press enter followed by Control + D:"
call printf
pop rax                            ;reverses the previous "push qword 99"

;The array is being processed after user inputs values
push qword 0
mov rax, 0
mov rdi, myArr2             ;second array is passed as the first parameter
mov rsi, 25                 ;the fixed size of the second array is passed as the second parameter
call inputarray             ;inputarray is called to take user input from the input_array module
mov r14, rax                ;the number of elements is backed up in rax and copied into r14
pop rax

;empty new line is shown
push qword 0
mov rax, 0
mov rdi, empty_space            ;" "
call printf
pop rax

;Displays the message about the second array entered
push qword 0
mov rax, 0
mov rdi, display_msgB       ;"These numbers were received and placed into array B:"
call printf
pop rax

;The second array is displayed based on user's input
push qword 0
mov rax, 0
mov rdi, myArr2             ;second array is passed into the first parameter
mov rsi, r14                ;number of elements for the second array is passed into the second parameter
call printArray
pop rax

;magnitude for the 2nd array is being calculated
push qword 0
mov rax, 0
mov rdi, myArr2             ;second array is passed into the first parameter
mov rsi, r14                ;number of elements for the second array is passed into the second parameter
call magnitude
movsd xmm13, xmm0           ;the magnitude is backed up from xmm0 and copied into xmm13 for storage
pop rax

;The 2nd magnitude is shown along with a message
push qword 0
mov rax, 1                      ;printf will need to access 1 SSE register
mov rdi, magnitude_msgB         ;"The magnitude of array B is %.10lf"
movsd xmm0, xmm13               ;magnitude for the second array is copied from xmm13 to xmm0 for display
call printf
pop rax

;=================== Doing work with the third array and magnitude ============================

;empty space for a new line is shown
push qword 0
mov rax, 0
mov rdi, empty_space        ;" "
call printf
pop rax

;A third array is being created based on the user's two arrays created
push qword 0
mov rax, 0
mov rdi, myArr1             ;pass first array into first parameter
mov rsi, r15                ;pass number of elements in first array as second parameter
mov rdx, myArr2             ;pass second array into third parameter
mov rcx, r14                ;pass number of elements in second array as fourth parameter
mov r8, sum_Arr             ;pass the third array which is going to be the combined first and second array as the fifth parameter
call append                 ;call append function to combine the first two arrays
mov r13, rax                ;the number of elements for the appended third array is backed up from rax in the append module and copied to r13
pop rax

;A message is shown for the user's third array
push qword 0
mov rax, 0
mov rdi, array_AB_msg       ;"Array A and B have been appended and given the name A", 0xE2, 0x8A, 0x95," B."
call printf
pop rax

;The 3rd array is displayed based on the user's first 2 arrays combined
push qword 0
mov rax, 0
mov rdi, sum_Arr        ;the third array is passed as the first parameter
mov rsi, r13            ;the number of elements in the third array is passed as the second parameter
call printArray          ;the printArray function in display_array module is called to display the third array
pop rax

;the magnitude for the 3rd array is being calculated
push qword 0
mov rax, 0
mov rdi, sum_Arr        ;pass third array into first parameter
mov rsi, r13            ;pass the number of elements in the third array as the second parameter
call magnitude          ;magnitude module is called to calculate the magnitude based on the user's array
movsd xmm12, xmm0       ;the magnitude is backed up in xmm0 and copied into xmm12
pop rax

;displays an empty new line for neatness
push qword 0
mov rax, 0
mov rdi, empty_space        ;" "
call printf
pop rax

;The magnitude for the third array is displayed with a message
push qword 0
mov rax, 1                     ;printf need access 1 SSE register
mov rdi, magnitude_msgAB       ;"The magnitude of A", 0xE2, 0x8A, 0x95," B is %.10lf"
movsd xmm0, xmm12               ;The magnitude of the third array is backed up in xmm12 and copied into xmm0 for display
call printf
pop rax

;displays an empty new line for neatness
push qword 0
mov rax, 0
mov rdi, empty_space        ;" "
call printf
pop rax

pop rax                 ;reverses the first push qword 0 in this program


movsd xmm0, xmm12       ;Select the third array's magnitude to be returned to the caller module



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
