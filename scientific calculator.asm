.model small
.stack 100h

.data
msg_intro db 13,10, '  1. Addition', 13,10, '  2. Subtraction', 13,10, '  3. Multiplication', 13,10
         db '  4. Division', 13,10, '  5. Negation', 13,10, '  6. Square', 13,10, '  7. Cube', 13,10
         db '  8. OR', 13,10, '  9. AND', 13,10, ' 10. XOR', 13,10, ' 11. NOT', 13,10, ' 12. Modulus', 13,10
         db ' 13. Cosine', 13,10, ' 14. Sine', 13,10, '  0. EXIT', '$'

msg_choose db 13,10,13,10,'Choose an option (0-14): $'
msg_enter1 db 13,10,'Enter Number 1: $'
msg_enter2 db 13,10,'Enter Number 2: $'
msg_enter_angle db 13,10,'Enter Angle (0-360 degrees): $'

msg_A    db 13,10,'The SUM of two Numbers = $'
msg_S    db 13,10,'The SUBTRACTION of two Numbers = $'
msg_M    db 13,10,'The MULTIPLICATION of two Numbers = $'
msg_D    db 13,10,'The DIVISION of two Numbers = $'
msg_N    db 13,10,'The NEGATION of the Number = $'
msg_SQ   db 13,10,'The SQUARE of the Number = $'
msg_CB   db 13,10,'The CUBE of the Number = $'
msg_OR   db 13,10,'The OR operation of two Numbers = $'
msg_AND  db 13,10,'The AND operation of two Numbers = $'
msg_XOR  db 13,10,'The XOR operation of two Numbers = $'
msg_NOT  db 13,10,'The NOT of the Number = $'
msg_MD   db 13,10,'The MODULUS of two Numbers = $'
msg_COS  db 13,10,'The COSINE of the Angle = $'
msg_SIN  db 13,10,'The SINE of the Angle = $'

newline db 13,10,'$'
cont    db 13,10,13,10,'Do you want to use again? (Yes = 1 / No = 0): $'
bye     db 13,10,13,10,'**** Thank You !!! :) ****',13,10,'$'
invalid_choice db 13,10,'Invalid Option! Please try again.$'
error_msg db 13,10,'Cannot be divided by 0. Undefined Math Error.$'

val1 dw ?
val2 dw ?
res  dw ?
operatorStr dw ?
angle dw ?
cos_result dw ?
sin_result dw ?

plus_sign db " + $"
minus_sign db " - $"
mul_sign db " * $"
div_sign db " / $"
neg_sign db " Negation $"
sq_sign  db " squared $"
cb_sign  db " cubed $"
or_sign  db " OR $"
and_sign db " AND $"
xor_sign db " XOR $"
not_sign db " NOT $"
mod_sign db " MOD $"
cos_sign db " cos $"
sin_sign db " sin $"

; Cosine table for 0-90 degrees (scaled by 10000)
cos_table dw 10000, 9998, 9994, 9986, 9976, 9962, 9945, 9925, 9903, 9877
          dw 9848, 9816, 9781, 9744, 9703, 9659, 9613, 9563, 9511, 9455
          dw 9397, 9336, 9272, 9205, 9135, 9063, 8988, 8910, 8829, 8746
          dw 8660, 8572, 8480, 8387, 8290, 8192, 8090, 7986, 7880, 7771
          dw 7660, 7547, 7431, 7314, 7193, 7071, 6947, 6820, 6691, 6561
          dw 6428, 6293, 6157, 6018, 5878, 5736, 5592, 5446, 5299, 5150
          dw 5000, 4848, 4695, 4540, 4384, 4226, 4067, 3907, 3746, 3584
          dw 3420, 3256, 3090, 2924, 2756, 2588, 2419, 2250, 2079, 1908
          dw 1736, 1564, 1392, 1219, 1045, 0872, 0698, 0523, 0349, 0175
          dw 0000

; Sine table for 0-90 degrees (scaled by 10000)
sin_table dw 0000, 0175, 0349, 0523, 0698, 0872, 1045, 1219, 1392, 1564
          dw 1736, 1908, 2079, 2250, 2419, 2588, 2756, 2924, 3090, 3256
          dw 3420, 3584, 3746, 3907, 4067, 4226, 4384, 4540, 4695, 4848
          dw 5000, 5150, 5299, 5446, 5592, 5736, 5878, 6018, 6157, 6293
          dw 6428, 6561, 6691, 6820, 6947, 7071, 7193, 7314, 7431, 7547
          dw 7660, 7771, 7880, 7986, 8090, 8192, 8290, 8387, 8480, 8572
          dw 8660, 8746, 8829, 8910, 8988, 9063, 9135, 9205, 9272, 9336
          dw 9397, 9455, 9511, 9563, 9613, 9659, 9703, 9744, 9781, 9816
          dw 9848, 9877, 9903, 9925, 9945, 9962, 9976, 9986, 9994, 9998
          dw 10000

.code
main proc
    mov ax, @data
    mov ds, ax

Start:
    mov ah, 9
    lea dx, msg_intro
    int 21h

    lea dx, msg_choose
    mov ah, 9
    int 21h

    call ReadNumber
    mov bx, ax

    cmp bx, 0
    je Exit
    cmp bx, 1
    je Addition
    cmp bx, 2
    je Subtraction
    cmp bx, 3
    je Multiplication
    cmp bx, 4
    je Division
    cmp bx, 5
    je Negation
    cmp bx, 6
    je Square
    cmp bx, 7
    je Cube
    cmp bx, 8
    je BitwiseOR
    cmp bx, 9
    je BitwiseAND
    cmp bx, 10
    je BitwiseXOR
    cmp bx, 11
    je BitwiseNOT
    cmp bx, 12
    je Modulus
    cmp bx, 13
    je Cosine
    cmp bx, 14
    je Sine

    lea dx, invalid_choice
    mov ah, 9
    int 21h
    jmp Continue

Addition:
    call InputTwo
    mov ax, val1
    add ax, val2
    mov res, ax
    lea dx, plus_sign
    mov operatorStr, dx
    lea dx, msg_A
    call ShowResultWithOp
    jmp Continue

Subtraction:
    call InputTwo
    mov ax, val1
    sub ax, val2
    mov res, ax
    lea dx, minus_sign
    mov operatorStr, dx
    lea dx, msg_S
    call ShowResultWithOp
    jmp Continue

Multiplication:
    call InputTwo
    mov ax, val1
    mov bx, val2
    mul bx
    mov res, ax
    lea dx, mul_sign
    mov operatorStr, dx
    lea dx, msg_M
    call ShowResultWithOp
    jmp Continue

Division:
    call InputTwo
    mov ax, val1
    mov bx, val2
    cmp bx, 0
    je DivError
    xor dx, dx
    div bx
    mov res, ax
    lea dx, div_sign
    mov operatorStr, dx
    lea dx, msg_D
    call ShowResultWithOp
    jmp Continue

Negation:
    call InputOne
    mov ax, val1
    neg ax
    mov res, ax
    lea dx, neg_sign
    mov operatorStr, dx
    lea dx, msg_N
    call ShowResultWithOpNeg
    jmp Continue

Square:
    call InputOne
    mov ax, val1
    mul ax
    mov res, ax
    lea dx, sq_sign
    mov operatorStr, dx
    lea dx, msg_SQ
    call ShowResultWithOpNeg
    jmp Continue

Cube:
    call InputOne
    mov ax, val1
    mul ax
    mov bx, ax
    mov ax, val1
    mul bx
    mov res, ax
    lea dx, cb_sign
    mov operatorStr, dx
    lea dx, msg_CB
    call ShowResultWithOpNeg
    jmp Continue

BitwiseOR:
    call InputTwo
    mov ax, val1
    or ax, val2
    mov res, ax
    lea dx, or_sign
    mov operatorStr, dx
    lea dx, msg_OR
    call ShowResultWithOp
    jmp Continue

BitwiseAND:
    call InputTwo
    mov ax, val1
    and ax, val2
    mov res, ax
    lea dx, and_sign
    mov operatorStr, dx
    lea dx, msg_AND
    call ShowResultWithOp
    jmp Continue

BitwiseXOR:
    call InputTwo
    mov ax, val1
    xor ax, val2
    mov res, ax
    lea dx, xor_sign
    mov operatorStr, dx
    lea dx, msg_XOR
    call ShowResultWithOp
    jmp Continue

BitwiseNOT:
    call InputOne
    mov ax, val1
    not ax
    mov res, ax
    lea dx, not_sign
    mov operatorStr, dx
    lea dx, msg_NOT
    call ShowResultWithOpNeg
    jmp Continue

Modulus:
    call InputTwo
    mov ax, val1
    mov bx, val2
    cmp bx, 0
    je DivError
    xor dx, dx
    div bx
    mov res, dx
    lea dx, mod_sign
    mov operatorStr, dx
    lea dx, msg_MD
    call ShowResultWithOp
    jmp Continue

Cosine:
    call InputAngle
    call CalculateCos
    lea dx, cos_sign
    mov operatorStr, dx
    lea dx, msg_COS
    call ShowTrigResult
    jmp Continue

Sine:
    call InputAngle
    call CalculateSin
    lea dx, sin_sign
    mov operatorStr, dx
    lea dx, msg_SIN
    call ShowTrigResult
    jmp Continue

DivError:
    lea dx, error_msg
    mov ah, 9
    int 21h
    jmp Continue

Continue:
    lea dx, cont
    mov ah, 9
    int 21h
    mov ah, 1
    int 21h
    sub al, '0'
    cmp al, 1
    je Start

Exit:
    lea dx, bye
    mov ah, 9
    int 21h
    mov ah, 4ch
    int 21h
main endp

InputOne proc
    push ax
    push dx
    lea dx, msg_enter1
    mov ah, 9
    int 21h
    call ReadNumber
    mov val1, ax
    pop dx
    pop ax
    ret
InputOne endp

InputTwo proc
    push ax
    push dx
    lea dx, msg_enter1
    mov ah, 9
    int 21h
    call ReadNumber
    mov val1, ax
    lea dx, msg_enter2
    mov ah, 9
    int 21h
    call ReadNumber
    mov val2, ax
    pop dx
    pop ax
    ret
InputTwo endp

InputAngle proc
    push ax
    push dx
    lea dx, msg_enter_angle
    mov ah, 9
    int 21h
    call ReadNumber
    mov angle, ax
    pop dx
    pop ax
    ret
InputAngle endp

CalculateCos proc
    push ax
    push bx
    push cx
    push dx
    push si
    
    ; Normalize angle to 0-359
    mov ax, angle
    mov bx, 360
    xor dx, dx
    div bx
    mov ax, dx    ; ax now contains angle % 360
    
    ; Determine quadrant and get reference angle
    cmp ax, 90
    jbe first_quad_cos
    cmp ax, 180
    jbe second_quad_cos
    cmp ax, 270
    jbe third_quad_cos
    jmp fourth_quad_cos
    
first_quad_cos:
    ; cos(angle) = cos_table[angle]
    mov si, ax
    shl si, 1       ; multiply by 2 (word size)
    mov ax, [cos_table + si]
    jmp store_cos_result
    
second_quad_cos:
    ; cos(angle) = -cos_table[180-angle]
    mov bx, 180
    sub bx, ax
    mov si, bx
    shl si, 1
    mov ax, [cos_table + si]
    neg ax
    jmp store_cos_result
    
third_quad_cos:
    ; cos(angle) = -cos_table[angle-180]
    sub ax, 180
    mov si, ax
    shl si, 1
    mov ax, [cos_table + si]
    neg ax
    jmp store_cos_result
    
fourth_quad_cos:
    ; cos(angle) = cos_table[360-angle]
    mov bx, 360
    sub bx, ax
    mov si, bx
    shl si, 1
    mov ax, [cos_table + si]
    
store_cos_result:
    mov cos_result, ax
    
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
CalculateCos endp

CalculateSin proc
    push ax
    push bx
    push cx
    push dx
    push si
    
    ; Normalize angle to 0-359
    mov ax, angle
    mov bx, 360
    xor dx, dx
    div bx
    mov ax, dx    ; ax now contains angle % 360
    
    ; Determine quadrant and get reference angle
    cmp ax, 90
    jbe first_quad_sin
    cmp ax, 180
    jbe second_quad_sin
    cmp ax, 270
    jbe third_quad_sin
    jmp fourth_quad_sin
    
first_quad_sin:
    ; sin(angle) = sin_table[angle]
    mov si, ax
    shl si, 1       ; multiply by 2 (word size)
    mov ax, [sin_table + si]
    jmp store_sin_result
    
second_quad_sin:
    ; sin(angle) = sin_table[180-angle]
    mov bx, 180
    sub bx, ax
    mov si, bx
    shl si, 1
    mov ax, [sin_table + si]
    jmp store_sin_result
    
third_quad_sin:
    ; sin(angle) = -sin_table[angle-180]
    sub ax, 180
    mov si, ax
    shl si, 1
    mov ax, [sin_table + si]
    neg ax
    jmp store_sin_result
    
fourth_quad_sin:
    ; sin(angle) = -sin_table[360-angle]
    mov bx, 360
    sub bx, ax
    mov si, bx
    shl si, 1
    mov ax, [sin_table + si]
    neg ax
    
store_sin_result:
    mov sin_result, ax
    
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
CalculateSin endp

ShowResultWithOp proc
    push ax
    push bx
    push cx
    push dx

    mov ah, 9
    int 21h

    mov ax, val1
    call PrintNum

    mov dx, operatorStr
    mov ah, 9
    int 21h

    mov ax, val2
    call PrintNum

    mov ah, 2
    mov dl, '='
    int 21h
    mov dl, ' '
    int 21h

    mov ax, res
    call PrintNum

    lea dx, newline
    mov ah, 9
    int 21h

    pop dx
    pop cx
    pop bx
    pop ax
    ret
ShowResultWithOp endp

ShowResultWithOpNeg proc
    push ax
    push bx
    push cx
    push dx

    mov ah, 9
    int 21h

    mov ax, val1
    call PrintNum

    mov dx, operatorStr
    mov ah, 9
    int 21h

    mov ah, 2
    mov dl, '='
    int 21h
    mov dl, ' '
    int 21h

    mov ax, res
    call PrintNum

    lea dx, newline
    mov ah, 9
    int 21h

    pop dx
    pop cx
    pop bx
    pop ax
    ret
ShowResultWithOpNeg endp

ShowTrigResult proc
    push ax
    push bx
    push cx
    push dx
    push si

    mov ah, 9
    int 21h       ; Display the message (msg_COS or msg_SIN)

    mov ax, angle
    call PrintNum ; Print the angle

    mov dx, operatorStr
    mov ah, 9
    int 21h       ; Print the operator string (cos_sign or sin_sign)

    mov ah, 2
    mov dl, '='
    int 21h
    mov dl, ' '
    int 21h

    ; Check which trigonometric function to display
    mov dx, operatorStr
    cmp dx, offset cos_sign
    je show_cos_result
    ; else show sin result
    mov ax, sin_result
    jmp print_trig_value
    
show_cos_result:
    mov ax, cos_result
    
print_trig_value:
    ; Check if negative
    test ax, ax
    jns positive_trig_value
    push ax
    mov dl, '-'
    mov ah, 2
    int 21h
    pop ax
    neg ax
    
positive_trig_value:
    ; Print the integer part (0 or 1)
    cmp ax, 10000
    jb less_than_1
    mov dl, '1'
    mov ah, 2
    int 21h
    sub ax, 10000
    jmp print_decimal_point
    
less_than_1:
    mov dl, '0'
    mov ah, 2
    int 21h
    
print_decimal_point:
    mov dl, '.'
    mov ah, 2
    int 21h
    
    ; Print the fractional part (4 digits)
    mov cx, 4
print_fraction_loop:
    mov bx, 10
    mul bx         ; ax = ax * 10
    mov bx, 10000
    xor dx, dx
    div bx         ; ax = ax / 10000, dx = remainder
    add al, '0'    ; convert to ASCII
    mov dl, al
    mov ah, 2
    int 21h
    mov ax, dx     ; remainder for next iteration
    loop print_fraction_loop

    lea dx, newline
    mov ah, 9
    int 21h

    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
ShowTrigResult endp

ReadNumber proc
    push bx
    push cx
    push dx
    xor ax, ax
    xor bx, bx       ; Clear BX to avoid leftover digits
    xor cx, cx
ReadLoop:
    mov ah, 1
    int 21h
    cmp al, 13
    je DoneRead
    cmp al, '0'
    jb ReadLoop
    cmp al, '9'
    ja ReadLoop
    sub al, '0'
    mov cl, al
    mov ax, bx
    mov dx, 10
    mul dx
    add ax, cx
    mov bx, ax
    jmp ReadLoop
DoneRead:
    mov ax, bx
    pop dx
    pop cx
    pop bx
    ret
ReadNumber endp

PrintNum proc
    push ax
    push bx
    push cx
    push dx
    push si

    mov cx, 0
    mov bx, 10
    cmp ax, 0
    jge NotNeg
    push ax
    mov dl, '-'
    mov ah, 2
    int 21h
    pop ax
    neg ax
NotNeg:
    inc cx
    xor dx, dx
    div bx
    push dx
    cmp ax, 0
    jne NotNeg
PrintLoop:
    pop dx
    add dl, '0'
    mov ah, 2
    int 21h
    loop PrintLoop

    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
PrintNum endp

end main