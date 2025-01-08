.data
    prompt:     .asciiz "Enter an integer (0 to exit): "
    errorMsg:   .asciiz "Error: Invalid input! Please enter an integer.\n"
    minMsg:     .asciiz "\nMinimum value entered: "
    maxMsg:     .asciiz "\nMaximum value entered: "
    firstMsg:   .asciiz "Please enter at least one number before exiting.\n"
    buffer:     .space 100    # Buffer for string input
    newline:    .asciiz "\n"

.text
.globl main

main:
    # Initialize registers
    li $s0, 0x7FFFFFFF   # Initialize min with maximum possible integer
    li $s1, 0x80000000   # Initialize max with minimum possible integer
    li $s2, 0            # Flag to track if we've received at least one valid number

input_loop:
    # Print prompt
    li $v0, 4
    la $a0, prompt
    syscall
    
    # Read string input
    li $v0, 8
    la $a0, buffer
    li $a1, 100
    syscall
    
    # Convert and validate input
    la $a0, buffer
    jal str_to_int
    
    # Check if conversion was successful
    bltz $v1, input_error
    
    # Check if input is 0
    beqz $v0, check_exit
    
    # We have a valid number, set the flag
    li $s2, 1
    
    # Update min if necessary
    bge $v0, $s0, check_max
    move $s0, $v0        # Update min
    
check_max:
    # Update max if necessary
    ble $v0, $s1, input_loop
    move $s1, $v0        # Update max
    j input_loop
    
input_error:
    # Print error message
    li $v0, 4
    la $a0, errorMsg
    syscall
    j input_loop
    
check_exit:
    # Check if we've received at least one valid number
    beqz $s2, no_numbers
    
    # Print minimum value
    li $v0, 4
    la $a0, minMsg
    syscall
    li $v0, 1
    move $a0, $s0
    syscall
    
    # Print maximum value
    li $v0, 4
    la $a0, maxMsg
    syscall
    li $v0, 1
    move $a0, $s1
    syscall
    
    # Print newline and exit
    li $v0, 4
    la $a0, newline
    syscall
    li $v0, 10
    syscall
    
no_numbers:
    # Print message asking for at least one number
    li $v0, 4
    la $a0, firstMsg
    syscall
    j input_loop

# Function to convert string to integer
# Parameters: $a0 = address of string
# Returns: $v0 = integer value, $v1 = status (0 = success, -1 = error)
str_to_int:
    # Setup
    li $v0, 0           # Result
    li $v1, 0           # Status
    li $t0, 0           # Index
    li $t1, 0           # Sign flag (0 = positive)
    
    # Skip leading whitespace
    skip_space:
        lb $t2, ($a0)
        beq $t2, 32, next_space   # Space
        beq $t2, 9, next_space    # Tab
        beq $t2, 10, next_space   # Newline
        j check_sign
    next_space:
        addi $a0, $a0, 1
        j skip_space
    
    # Check for sign
    check_sign:
        lb $t2, ($a0)
        beq $t2, 45, negative     # minus sign
        beq $t2, 43, positive     # plus sign
        j process_digits
    negative:
        li $t1, 1               # Set negative flag
        addi $a0, $a0, 1
        j process_digits
    positive:
        addi $a0, $a0, 1
        
    # Process digits
    process_digits:
        lb $t2, ($a0)
        
        # Check for end of string or newline
        beqz $t2, end_conversion
        beq $t2, 10, end_conversion
        
        # Check if character is a digit
        blt $t2, 48, invalid
        bgt $t2, 57, invalid
        
        # Convert character to number and add to result
        addi $t2, $t2, -48        # Convert ASCII to number
        mul $v0, $v0, 10         # Multiply current result by 10
        add $v0, $v0, $t2        # Add new digit
        
        addi $a0, $a0, 1
        j process_digits
        
    invalid:
        li $v1, -1              # Set error status
        jr $ra
        
    end_conversion:
        # Apply sign if negative
        beqz $t1, done
        neg $v0, $v0
        
    done:
        jr $ra