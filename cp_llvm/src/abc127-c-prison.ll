; Created by Ayush Biswas at 2026/06/15 21:13
; https://atcoder.jp/contests/abc127/tasks/abc127_c

; @include fast_io

; @head begin
declare i32 @printf(ptr, ...)
; @head end

; @code begin

; format strings for printing
@fmt-out = constant [4 x i8] c"%ld\00"

define void @sol() {
entry:
    ; read n and k
    %n = call i64 @read-i64()
    %m = call i64 @read-i64()
    br label %loop
loop:
    %i = phi i64 [ 0, %entry ], [ %i.next, %loop.cont ]
    %l = phi i64 [ 0, %entry ], [ %l.next, %loop.cont ]
    %r = phi i64 [ 100001, %entry ], [ %r.next, %loop.cont ]
    %"i<m?" = icmp slt i64 %i, %m
    br i1 %"i<m?", label %loop.body, label %print-cards
loop.body:
    %li = call i64 @read-i64()
    %ri = call i64 @read-i64()
    %"li>r?" = icmp sgt i64 %li, %r
    %"ri<l?" = icmp slt i64 %ri, %l
    %no-solution = or i1 %"li>r?", %"ri<l?"
    br i1 %no-solution, label %zero-cards, label %loop.cont
loop.cont:
    %"li>l?" = icmp sgt i64 %li, %l
    %"ri<r?" = icmp slt i64 %ri, %r
    %l.next = select i1 %"li>l?", i64 %li, i64 %l
    %r.next = select i1 %"ri<r?", i64 %ri, i64 %r
    %i.next = add i64 %i, 1
    br label %loop
print-cards:
    %diff = sub i64 %r, %l
    %res = add i64 %diff, 1
    call i32 (ptr, ...) @printf(ptr @fmt-out, i64 %res)
    ret void

zero-cards:
    call i32 (ptr, ...) @printf(ptr @fmt-out, i64 0)
    ret void
}

define i32 @main() {
    call ptr @sol()

    ret i32 0
}
; @code end