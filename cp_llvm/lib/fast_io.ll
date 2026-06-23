; Portable Fast I/O Reader using getchar_unlocked
; Avoids glibc/BSD libc symbol differences, making it compatible with both Linux and macOS.

; @head begin
declare i32 @getchar_unlocked()
; @head end

; @code begin

; Parse String (Writes to %out_ptr, appends '\0', returns length)
define i64 @read-string(ptr %out_ptr) {
entry:
    br label %skip_loop

skip_loop:
    %c = call i32 @getchar_unlocked()
    %is_eof = icmp eq i32 %c, -1
    br i1 %is_eof, label %eof_return, label %check_ws

check_ws:
    %is_ws = icmp sle i32 %c, 32 ; check if ASCII <= 32 (whitespace)
    br i1 %is_ws, label %skip_loop, label %parse_start

parse_start:
    br label %parse_loop

parse_loop:
    %curr_c = phi i32 [ %c, %parse_start ], [ %next_c, %parse_loop ]
    %curr_len = phi i64 [ 0, %parse_start ], [ %next_len, %parse_loop ]
    
    ; Store the valid character in the destination buffer
    %curr_c_i8 = trunc i32 %curr_c to i8
    %gep = getelementptr inbounds i8, ptr %out_ptr, i64 %curr_len
    store i8 %curr_c_i8, ptr %gep, align 1
    
    %next_len = add i64 %curr_len, 1
    %next_c = call i32 @getchar_unlocked()
    
    ; Check if the next character marks EOF or whitespace
    %next_is_eof = icmp eq i32 %next_c, -1
    %next_is_ws = icmp sle i32 %next_c, 32
    %term_cond = or i1 %next_is_eof, %next_is_ws
    br i1 %term_cond, label %done, label %parse_loop

done:
    ; Null-terminate the string
    %term_gep = getelementptr inbounds i8, ptr %out_ptr, i64 %next_len
    store i8 0, ptr %term_gep, align 1
    ret i64 %next_len

eof_return:
    store i8 0, ptr %out_ptr, align 1
    ret i64 0
}

; @read_i32: reads an integer (maybe negative) from stdin
define i32 @read-i32() {
entry:
    br label %skip_loop

skip_loop:
    %c = call i32 @getchar_unlocked()
    %is_eof = icmp eq i32 %c, -1
    br i1 %is_eof, label %eof_return, label %check_minus

check_minus:
    %is_minus = icmp eq i32 %c, 45
    br i1 %is_minus, label %negative_start, label %check_digit

check_digit:
    %sub_c = sub i32 %c, 48
    %is_digit = icmp ult i32 %sub_c, 10
    br i1 %is_digit, label %parse_positive_start, label %skip_loop

negative_start:
    %c_neg_init = call i32 @getchar_unlocked()
    br label %parse_negative_loop

parse_negative_loop:
    %c_neg = phi i32 [ %c_neg_init, %negative_start ], [ %c_neg_next, %parse_negative_body ]
    %val_neg = phi i32 [ 0, %negative_start ], [ %val_neg_next, %parse_negative_body ]

    %sub_neg = sub i32 %c_neg, 48
    %is_digit_neg = icmp ult i32 %sub_neg, 10
    br i1 %is_digit_neg, label %parse_negative_body, label %negative_return

parse_negative_body:
    %mul_neg = mul nsw i32 %val_neg, 10
    %val_neg_next = add nsw i32 %mul_neg, %sub_neg
    %c_neg_next = call i32 @getchar_unlocked()
    br label %parse_negative_loop

parse_positive_start:
    br label %parse_positive_loop

parse_positive_loop:
    %c_pos = phi i32 [ %c, %parse_positive_start ], [ %c_pos_next, %parse_positive_body ]
    %val_pos = phi i32 [ 0, %parse_positive_start ], [ %val_pos_next, %parse_positive_body ]

    %sub_pos = sub i32 %c_pos, 48
    %is_digit_pos = icmp ult i32 %sub_pos, 10
    br i1 %is_digit_pos, label %parse_positive_body, label %positive_return

parse_positive_body:
    %mul_pos = mul nsw i32 %val_pos, 10
    %val_pos_next = add nsw i32 %mul_pos, %sub_pos
    %c_pos_next = call i32 @getchar_unlocked()
    br label %parse_positive_loop

negative_return:
    %negated_val = sub nsw i32 0, %val_neg
    ret i32 %negated_val

positive_return:
    ret i32 %val_pos

eof_return:
    ret i32 0
}

; @read_i64: read a long integer from stdin
define i64 @read-i64() {
entry:
    br label %skip_loop

skip_loop:
    %c = call i32 @getchar_unlocked()
    %is_eof = icmp eq i32 %c, -1
    br i1 %is_eof, label %eof_return, label %check_minus

check_minus:
    %is_minus = icmp eq i32 %c, 45 ; '-' character
    br i1 %is_minus, label %negative_start, label %check_digit

check_digit:
    %sub_c = sub i32 %c, 48
    %is_digit = icmp ult i32 %sub_c, 10
    br i1 %is_digit, label %parse_positive_start, label %skip_loop

negative_start:
    %c_neg_init = call i32 @getchar_unlocked()
    br label %parse_negative_loop

parse_negative_loop:
    %c_neg = phi i32 [ %c_neg_init, %negative_start ], [ %c_neg_next, %parse_negative_body ]
    %val_neg = phi i64 [ 0, %negative_start ], [ %val_neg_next, %parse_negative_body ]
    %sub_neg = sub i32 %c_neg, 48
    %is_digit_neg = icmp ult i32 %sub_neg, 10
    br i1 %is_digit_neg, label %parse_negative_body, label %negative_return

parse_negative_body:
    %digit_neg_i64 = zext i32 %sub_neg to i64
    %mul_neg = mul nsw i64 %val_neg, 10
    %val_neg_next = add nsw i64 %mul_neg, %digit_neg_i64
    %c_neg_next = call i32 @getchar_unlocked()
    br label %parse_negative_loop

parse_positive_start:
    br label %parse_positive_loop

parse_positive_loop:
    %c_pos = phi i32 [ %c, %parse_positive_start ], [ %c_pos_next, %parse_positive_body ]
    %val_pos = phi i64 [ 0, %parse_positive_start ], [ %val_pos_next, %parse_positive_body ]
    %sub_pos = sub i32 %c_pos, 48
    %is_digit_pos = icmp ult i32 %sub_pos, 10
    br i1 %is_digit_pos, label %parse_positive_body, label %positive_return

parse_positive_body:
    %digit_pos_i64 = zext i32 %sub_pos to i64
    %mul_pos = mul nsw i64 %val_pos, 10
    %val_pos_next = add nsw i64 %mul_pos, %digit_pos_i64
    %c_pos_next = call i32 @getchar_unlocked()
    br label %parse_positive_loop

negative_return:
    %negated_val = sub nsw i64 0, %val_neg
    ret i64 %negated_val

positive_return:
    ret i64 %val_pos

eof_return:
    ret i64 0
}

attributes #0 = { alwaysinline }

; @code end