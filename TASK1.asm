; Program: Number Classification
; Description: Prompts for a user input number and classifies it as POSITIVE, NEGATIVE, or ZERO.
; Author: Hope Macharia
; Date: November 2024

global _start

section .data
    prompt          db 'Enter a number: ', 0
    positive_msg    db 'The number is POSITIVE', 10, 0
    negative_msg    db 'The number is NEGATIVE', 10, 0
    zero_msg        db 'The number is ZERO', 10, 0
    input_buffer    db 10 dup(0)

section .text
_start:
    ; Print the prompt asking for the user to input a number
    ; sys_write system call is used to display the prompt.
    mov     eax, 4              ; sys_write (system call number for writing)
    mov     ebx, 1              ; File descriptor (stdout)
    mov     ecx, prompt         ; Address of the prompt message
    mov     edx, 15             ; Length of the prompt message
    int     0x80                ; Kernel interrupt for system call (output the prompt)

    ; Read the user input into the buffer (stdin)
    ; sys_read system call is used to take the input from the user.
    mov     eax, 3              ; sys_read (system call number for reading)
    mov     ebx, 0              ; File descriptor (stdin)
    mov     ecx, input_buffer   ; Address where user input is stored
    mov     edx, 10             ; Max number of bytes to read (buffer size)
    int     0x80                ; Kernel interrupt for system call (get user input)

    ; Convert the ASCII string in input_buffer to an integer (atoi function)
    mov     esi, input_buffer   ; Point to the start of the input string (input_buffer)
    call    atoi                ; Call the atoi subroutine (converts ASCII to integer)

    ; Compare the number in EAX (converted integer) with 0
    cmp     eax, 0              ; Compare the integer value in EAX with zero
    je      output_zero         ; If EAX == 0, jump to output_zero case
    jl      output_negative     ; If EAX < 0, jump to output_negative case
    ; If EAX > 0, continue to output_positive section (falls through)

output_positive:
    ; This section handles the case when the number is POSITIVE.
    ; Unconditional jump ensures the program exits after processing this case.
    mov     eax, 4              ; sys_write system call for output
    mov     ebx, 1              ; File descriptor (stdout)
    mov     ecx, positive_msg   ; Address of the positive message
    mov     edx, 23             ; Length of the message string
    int     0x80                ; Kernel interrupt (output the message)
    jmp     exit_program        ; Unconditional jump to exit_program (prevents further checks)

output_negative:
    ; This section handles the case when the number is NEGATIVE.
    ; Jumping here is done if the value in EAX is less than 0.
    mov     eax, 4              ; sys_write system call for output
    mov     ebx, 1              ; File descriptor (stdout)
    mov     ecx, negative_msg   ; Address of the negative message
    mov     edx, 23             ; Length of the message string
    int     0x80                ; Kernel interrupt (output the message)
    jmp     exit_program        ; Unconditional jump to exit_program (prevents further checks)

output_zero:
    ; This section handles the case when the number is ZERO.
    ; Jumping here is done if the value in EAX is exactly 0.
    mov     eax, 4              ; sys_write system call for output
    mov     ebx, 1              ; File descriptor (stdout)
    mov     ecx, zero_msg       ; Address of the zero message
    mov     edx, 19             ; Length of the message string
    int     0x80                ; Kernel interrupt (output the message)

exit_program:
    ; The exit section of the program.
    ; Unconditional jump to exit the program after displaying the result.
    mov     eax, 1              ; sys_exit system call for program termination
    xor     ebx, ebx            ; Exit code 0 (successful program termination)
    int     0x80                ; Kernel interrupt to exit the program

; Subroutine: ASCII to Integer Conversion (atoi)
; This subroutine converts the ASCII string at ESI to an integer in EAX.
; It also handles negative numbers and ignores non-numeric characters.
atoi:
    xor     eax, eax            ; Clear EAX register (prepare for storing the result)
    xor     ebx, ebx            ; Clear EBX (used for sign detection)

atoi_loop:
    lodsb                       ; Load the next byte from input_buffer into AL (ASCII value)
    cmp     al, 0x0A            ; Check if the byte is a newline character (Enter key)
    je      atoi_done           ; If newline, end the loop (input finished)
    cmp     al, '-'             ; Check if the byte is a minus sign
    jne     atoi_digit_check    ; If not '-', continue checking digits
    inc     ebx                 ; If '-', mark the number as negative (sign flag)
    jmp     atoi_loop           ; Continue the loop

atoi_digit_check:
    cmp     al, '0'             ; Check if the character is less than '0'
    jl      atoi_done           ; If less than '0', end the conversion (non-numeric)
    cmp     al, '9'             ; Check if the character is greater than '9'
    jg      atoi_done           ; If greater than '9', end the conversion (non-numeric)
    sub     al, '0'             ; Convert ASCII value to numeric value (subtract ASCII '0')
    imul    eax, 10             ; Multiply current value in EAX by 10 (shifting left)
    add     eax, eax            ; Add the current digit to EAX
    jmp     atoi_loop           ; Continue the loop for the next character

atoi_done:
    ; If the number is negative, negate the result stored in EAX.
    test    ebx, ebx            ; Check if the negative flag is set (EBX is non-zero)
    jz      atoi_end            ; If not negative, skip negation
    neg     eax                 ; Negate the value in EAX

atoi_end:
    ret                         ; Return from subroutine with the result in EAX

; Explanation of jump instructions and control flow:

; 1. JE (Jump if Equal) is used to jump to the "output_zero" label when the value
;    in EAX is 0. This ensures that the number zero is handled correctly.
; 2. JL (Jump if Less) is used to jump to the "output_negative" label if the value
;    in EAX is less than 0. This efficiently handles the case for negative numbers.
; 3. JMP (unconditional jump) is used after outputting the positive, negative, or
;    zero messages to exit the program. This prevents further checks once a condition is met.

; The use of these jump instructions (JE, JL, and JMP) ensures the program flow remains
; structured, with no unnecessary checks or redundant processing once a case has been handled.
; This also improves the readability and efficiency of the program by clearly separating the
; logic for each possible outcome (positive, negative, or zero).
