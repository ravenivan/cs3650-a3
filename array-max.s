# Write the assembly code for the array_max function
.text

.global array_max
array_max:
  # max = items[0]
  movq (%rsi), %rax

  # i = 1
  movq $1, %rcx

loop:
  # if i >= n, then done
  cmpq %rdi, %rcx
  jae done

  # Get items[i] 
  movq (%rsi,%rcx,8), %rdx

  # if items[i] <= max, then skip updating max
  cmpq %rax, %rdx
  jbe next

  # max = items[i]
  movq %rdx, %rax

next:
  # i++
  incq %rcx
  jmp loop

done:
  ret
