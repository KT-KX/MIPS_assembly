

Here's a raw README file for the project that you can copy directly:

```
# MIPS Assembly: Integer Input and Odd Number Summing

This project demonstrates the use of MIPS assembly language to implement two separate programs: 
1. A program to read multiple integers from the user, count the odd integers, and calculate their sum. 
2. A program to continuously prompt the user to enter integers, track the smallest and largest values, and exit when 0 is entered.

## Features

- **Odd Number Count and Sum Program:**
    - Prompts the user to enter 6 integers between -100 and 100.
    - Displays the count and sum of the odd integers entered.
    - Handles invalid input and out-of-range values.
  
- **Min/Max Integer Tracking Program:**
    - Continuously prompts the user to enter integers.
    - Tracks the smallest and largest integers entered.
    - Displays the minimum and maximum values after a valid input or informs the user to enter at least one valid number.

## Instructions

### Odd Number Count and Sum Program
1. The user is prompted to input 6 integers between -100 and 100.
2. If an input is out of range or not an integer, an error message is shown.
3. The program counts the odd integers and sums them.
4. After all inputs are received, the program prints the count and sum of the odd integers.

### Min/Max Integer Tracking Program
1. The user is prompted to input integers.
2. If an invalid input is given (non-integer), an error message is displayed.
3. The program tracks the smallest and largest values entered.
4. The program exits when 0 is entered, displaying the minimum and maximum values or a message if no valid numbers are entered.

## Code Breakdown

### Odd Number Count and Sum Program

- **Data Section:**
    - The prompt for user input, error messages, and output messages are defined.
  
- **Text Section:**
    - The main procedure handles user input and validation.
    - The program uses `jal` to call procedures for counting odd numbers, summing odd numbers, and printing results.

### Min/Max Integer Tracking Program

- **Data Section:**
    - The program defines a prompt for input, error message, and messages for minimum and maximum values.
  
- **Text Section:**
    - The input loop handles user input and performs string-to-integer conversion.
    - A check for valid input is performed, and the minimum and maximum integers are updated accordingly.

## MIPS Procedures

1. **increment_odd_count:** Increments the count of odd integers.
2. **add_to_odd_sum:** Adds the odd number to the total sum.
3. **print_odd_count:** Prints the count of odd numbers.
4. **print_odd_sum:** Prints the sum of odd numbers.
5. **str_to_int:** Converts a string input to an integer while handling signs and validation.

## Requirements

- MIPS Simulator (e.g., MARS, SPIM) to run the assembly code.

## Usage

1. Run the MIPS program on a simulator.
2. Follow the prompts to enter integers.
3. View the output based on the entered values (odd number count, sum, minimum, and maximum).

## License

This project is licensed under the MIT License.
```

You can directly copy this and use it as the README for your project.
