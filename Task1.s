.data
prompt: .asciiz "Enter an integer between -100 and 100: "
error_msg: .asciiz "Error: Please enter a number within the range -100 to 100.\n"
odd_count_msg: .asciiz "Count of odd integers: "
odd_sum_msg: .asciiz "Sum of odd integers: "
newline: .asciiz "\n"

.text
.globl main

main:
    # Initialize the odd count and odd sum to 0
    li $s0, 0    # odd count
    li $s1, 0    # odd sum
    li $t0, 6    # number of integers to input

input_loop:
    # Prompt user for input
    li $v0, 4
    la $a0, prompt
    syscall

    # Read integer input
    li $v0, 5
    syscall
    move $t1, $v0

    # Check if input is in range [-100, 100]
    li $t2, -100
    li $t3, 100
    blt $t1, $t2, out_of_range
    bgt $t1, $t3, out_of_range

    # Check if the number is odd
    andi $t4, $t1, 1
    beq $t4, 0, skip_odd

    # Increment odd count and add to odd sum if odd
    jal increment_odd_count
    jal add_to_odd_sum

skip_odd:
    # Decrement the counter and repeat for 6 inputs
    sub $t0, $t0, 1
    bgtz $t0, input_loop

    # Print results
    jal print_odd_count
    jal print_odd_sum
    j end_program

out_of_range:
    # Print error message if out of range
    li $v0, 4
    la $a0, error_msg
    syscall
    j input_loop

# Procedure to increment odd count
increment_odd_count:
    addi $s0, $s0, 1
    jr $ra

# Procedure to add to odd sum
add_to_odd_sum:
    add $s1, $s1, $t1
    jr $ra

# Procedure to print odd count
print_odd_count:
    li $v0, 4
    la $a0, odd_count_msg
    syscall
    li $v0, 1
    move $a0, $s0
    syscall
    li $v0, 4
    la $a0, newline
    syscall
    jr $ra

# Procedure to print odd sum
print_odd_sum:
    li $v0, 4
    la $a0, odd_sum_msg
    syscall
    li $v0, 1
    move $a0, $s1
    syscall
    li $v0, 4
    la $a0, newline
    syscall
    jr $ra

end_program:
    li $v0, 10  # Exit program
    syscall
