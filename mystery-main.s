# Write the assembly code for the main function of the mystery program
.text

.globl main
main:
  # Save argv bc function calls may overwrite %rsi
  pushq %rbx
  pushq %r12
  pushq %r13

  movq %rsi, %rbx

  # if argc != 3
  cmpq $3, %rdi
  jne wrong_args

  # a = atol(argv[1])
  movq 8(%rbx), %rdi
  call atol
  movq %rax, %r12

  # b = atol(argv[2])
  movq 16(%rbx), %rdi
  call atol
  movq %rax, %r13

  # result = crunch(a, b)
  movq %r12, %rdi
  movq %r13, %rsi
  call crunch

  # compare result w 0
  cmpq $0, %rax
  jl print_hat
  je print_tea

  # result > 0
  leaq beer_msg(%rip), %rdi
  call puts
  jmp success

print_hat:
  leaq hat_msg(%rip), %rdi
  call puts
  jmp success

print_tea:
  leaq tea_msg(%rip), %rdi
  call puts
  jmp success

wrong_args:
  leaq error_msg(%rip), %rdi
  call puts
  movl $1, %eax

  popq %r13
  popq %r12
  popq %rbx
  ret

success:
  movl $0, %eax

  popq %r13
  popq %r12
  popq %rbx
  ret

.data
error_msg:
  .asciz "Two arguments required."
hat_msg:
  .asciz "hat"
tea_msg:
  .asciz "tea"
beer_msg:
  .asciz "beer"
