; Created by Ayush Biswas at 2026/06/15 20:26
; https://atcoder.jp/contests/abc127/tasks/abc127_b

; @include fast_io

; @head begin
declare i32 @printf(ptr, ...)
; @head end

; @code begin

; format strings for printing
@fmt-out = constant [5 x i8] c"%ld\0A\00"

define void @sol() {
entry:
    ; read n and k
    %r = call i64 @read-i64()
    %d = call i64 @read-i64()
    %x = call i64 @read-i64()
    br label %loop 
loop:
    %i = phi i64 [ 0, %entry ], [ %i.next, %loop.body ]
    %xi = phi i64 [ %x, %entry ], [ %xi.next, %loop.body ]
    %"i<10?" = icmp slt i64 %i, 10
    br i1 %"i<10?", label %loop.body, label %loop.end
loop.body:
    %xi.r = mul i64 %xi, %r
    %xi.next = sub i64 %xi.r, %d
    call i32 (ptr, ...) @printf(ptr @fmt-out, i64 %xi.next)
    %i.next = add i64 %i, 1
    br label %loop
loop.end:
    ret void
}

define i32 @main() {
    call ptr @sol()

    ret i32 0
}
; @code end