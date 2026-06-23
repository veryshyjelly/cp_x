; Created by Ayush Biswas at 2026/06/11 10:38
; https://atcoder.jp/contests/abc126/tasks/abc126_b

; @include fast_io

; @head begin
declare i32 @scanf(ptr, ...)
declare i32 @printf(ptr, ...)
declare ptr @strncpy(ptr, ptr, i64)
declare i32 @atoi(ptr)
; @head end

; @code begin

@fmt_in = constant [4 x i8] c"%5s\00"
@out_ambiguous = constant [11 x i8] c"AMBIGUOUS\0A\00"
@out_mmyy = constant [6 x i8] c"MMYY\0A\00"
@out_yymm = constant [6 x i8] c"YYMM\0A\00"
@out_na = constant [4 x i8] c"NA\0A\00"

; parse the %source starting at %index upto two characters
; copies the %source and adds null terminator, then uses atoi from stdlib
define i32 @parse_part(ptr %source, i64 %index) {
entry:
    %buf = alloca [3 x i8]
    %src-offset = getelementptr i8, ptr %source, i64 %index
    call ptr @strncpy(ptr %buf, ptr %src-offset, i64 2)
    %null-char = getelementptr [3 x i8], ptr %buf, i64 0, i64 2
    store i8 0, ptr %null-char
    %val = call i32 @atoi(ptr %buf)
    ret i32 %val
}

; checks weather %val is in the range [1, 12]
define i1 @is_valid_month(i32 %val) {
entry:
    %ge = icmp sge i32 %val, 1
    %le = icmp sle i32 %val, 12
    %res = and i1 %ge, %le
    ret i1 %res
}

define void @sol(ptr %s) {
    ; Reuse helper to parse
    %a = call i32 @parse_part(ptr %s, i64 0)
    %b = call i32 @parse_part(ptr %s, i64 2)

    ; Reuse helper to validate if both values are valid months
    %is_a_month = call i1 @is_valid_month(i32 %a)
    %is_b_month = call i1 @is_valid_month(i32 %b)

    %a.bit = zext i1 %is_a_month to i2
    %b.bit = zext i1 %is_b_month to i2
    %b_shifted = shl i2 %b.bit, 1

    %a_and_b = or i2 %a.bit, %b_shifted
    
    switch i2 %a_and_b, label %print_na [ i2 1, label %print_mmyy
                                          i2 2, label %print_yymm
                                          i2 3, label %print_ambiguous]

print_ambiguous:
    call i32 (ptr, ...) @printf(ptr @out_ambiguous)
    ret void

print_mmyy:
    call i32 (ptr, ...) @printf(ptr @out_mmyy)
    ret void

print_yymm:
    call i32 (ptr, ...) @printf(ptr @out_yymm)
    ret void

print_na:
    call i32 (ptr, ...) @printf(ptr @out_na)
    ret void
}

; main entry point
define i32 @main() {
entry:
    %s = alloca [6 x i8]
    ; Read the string from standard input
    call i64 @read-string(ptr %s)

    call void @sol(ptr %s)

    ret i32 0
}
; @code end