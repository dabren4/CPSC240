



extern printf
extern scanf
extern atof
global pythagoras

segment .data

  prompt1 db  "Enter the length of the first side of the triangle: ", 0
  prompt2 db  "Enter the length of the second side of the triangle: ", 0

  float_form  db  "%f %f", 0
  string_form  db  "%s", 0

  output  db  "The length of the hypotenuse is %.6lf"

  exit    db  "Please enjoy your triangles %s %s.", 10, 0

segment .bss


segment .text

  global  start

pythagoras:
;========
start:

  push  rbp
  mov   rsp, rbp
  push  rdi
  push  rsi
  push  rdx
  push  rcx
  push  r8
  push  r9
  push  r10
  push  r11
  push  r12
  push  r13
  push  r14
  push  r15
  push  rbx
  pushf
  jmp   input

  push qword 0

input:

  ; Prints output prompt
  mov   rdi,  output
  call printf
  pop rax

  ;make space for 2 strings
  sub   rsp,  2048
  mov   rax,  0
  mov   rdi,  string_form
  mov   rsi,  rsp
  mov   r15,  rsp
  call  scanf
  pop rax

  mov   r10,  rax
  mov   rdi,  string_form
  mov   rsi,  rax
  call  printf
  pop rax

  add   rsp,  2048
;========
end:

pop rax ;reverse the push qword 0 at the start

movsd xmm0, xmm15

;Restores registers
  popf
  pop   rbx
  pop   r15
  pop   r14
  pop   r13
  pop   r12
  pop   r11
  pop   r10
  pop   r9
  pop   r8
  pop   rcx
  pop   rdx
  pop   rsi
  pop   rdi
  pop   rbp

  ret
