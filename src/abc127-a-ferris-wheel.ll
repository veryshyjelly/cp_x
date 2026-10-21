; Created by Ayush Biswas at 2026/06/15 20:06
; https://atcoder.jp/contests/abc127/tasks/abc127_a

; @include fast_io

; @head begin
declare i32 @printf(ptr, ...)
; @head end

; @code begin

; format strings for printing
@fmt-out = constant [4 x i8] c"%ld\00"

define void @sol() {
    ; read a and b
    %a = call i64 @read-i64()
    %b = call i64 @read-i64()
    %c = lshr i64 %b, 1
    
    %is-old = icmp sge i64 %a, 13
    %is-child = icmp sle i64 %a, 5
    %res1 = select i1 %is-old, i64 %b, i64 %c
    %res2 = select i1 %is-child, i64 0, i64 %res1

    call i32 (ptr, ...) @printf(ptr @fmt-out, i64 %res2)

    ret void
}

define i32 @main() {
    call ptr @sol()

    ret i32 0
}
; @code end