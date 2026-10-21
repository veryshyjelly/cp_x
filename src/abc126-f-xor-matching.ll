; Created by Ayush Biswas at 2026/06/14 18:58
; https://atcoder.jp/contests/abc126/tasks/abc126_f

; @include fast_io

; @head begin
declare i32 @printf(ptr, ...)
; @head end

; @code begin

; format strings for printing
@fmt-out = constant [5 x i8] c"%ld \00"

define void @fill-k0(ptr %res, i64 %n) {
entry:
    %N = lshr i64 %n, 1
    br label %loop
loop:
    %i = phi i64 [ 0, %entry ], [ %i.next, %loop.body ]
    %"i=n?" = icmp eq i64 %i, %n
    br i1 %"i=n?", label %loop.end, label %loop.body
loop.body:
    %a = sub i64 %n, %i 
    %a1 = sub i64 %a, 1
    %left = icmp ult i64 %i, %N
    %val = select i1 %left, i64 %i, i64 %a1
    %res.i = getelementptr i64, ptr %res, i64 %i
    store i64 %val, ptr %res.i
    %i.next = add i64 %i, 1
    br label %loop
loop.end:
    ret void
}

define void @fill-kn0(ptr %res, i64 %n, i64 %k) {
entry:
    %N = lshr i64 %n, 1
    %right-start = sub i64 %n, 2
    br label %loop
loop:
    %i = phi i64 [ 0, %entry ], [ %i.next, %loop.body ], [ %i.next,  %"i=k" ]
    %left = phi i64 [ 0, %entry ], [ %left, %"i=k" ], [ %left.next, %loop.body ]
    %right = phi i64 [ %right-start, %entry ], [ %right, %"i=k" ], [ %right.next, %loop.body ]
    %"i=N?" = icmp eq i64 %i, %N
    br i1 %"i=N?", label %loop.end, label %"i=k"
"i=k":
    %i.next = add i64 %i, 1
    %"i=k?" = icmp eq i64 %i, %k
    br i1 %"i=k?", label %loop, label %loop.body
loop.body:
    %res.left.ptr = getelementptr i64, ptr %res, i64 %left
    %res.right.ptr = getelementptr i64, ptr %res, i64 %right
    store i64 %i, ptr %res.left.ptr
    store i64 %i, ptr %res.right.ptr
    %left.next = add i64 %left, 1
    %right.next = sub i64 %right, 1
    br label %loop
loop.end:
    %mid = sub i64 %N, 1
    %mid.ptr = getelementptr i64, ptr %res, i64 %mid
    store i64 %k, ptr %mid.ptr

    %last = sub i64 %n, 1
    %last.ptr = getelementptr i64, ptr %res, i64 %last
    store i64 %k, ptr %last.ptr
    ret void
}

define void @print-array(ptr %res, i64 %n) {
entry:
    br label %loop
loop:
    %i = phi i64 [ 0, %entry ], [ %i.next, %loop.body ]
    %"i<n?" = icmp slt i64 %i, %n
    br i1 %"i<n?", label %loop.body, label %loop.end 
loop.body:
    %res.i.ptr = getelementptr i64, ptr %res, i64 %i
    %res.i = load i64, ptr %res.i.ptr
    call i32 (ptr, ...) @printf(ptr @fmt-out, i64 %res.i)
    %i.next = add i64 %i, 1
    br label %loop
loop.end:
    ret void
}

define void @sol() {
    ; read n and k
    %m = call i64 @read-i64()
    %k = call i64 @read-i64()

    %"2^m" = shl i64 1, %m
    %res-length = shl i64 %"2^m", 1

    %res = alloca i64, i64 %res-length

    %"k>=2^m?" = icmp sge i64 %k, %"2^m"
    br i1 %"k>=2^m?", label %no-solution, label %check-further

check-further:
    %"k=0?" = icmp eq i64 %k, 0
    br i1 %"k=0?", label %"k=0", label %"k!=0"

"k=0":
    call void @fill-k0(ptr %res, i64 %res-length)
    br label %print-solution
"k!=0":
    %"m=1?" = icmp eq i64 %m, 1
    br i1 %"m=1?", label %no-solution, label %"m!=1"
"m!=1":
    call void @fill-kn0(ptr %res, i64 %res-length, i64 %k)
    br label %print-solution

print-solution:
    call void @print-array(ptr %res, i64 %res-length)
    br label %exit

no-solution:
    call i32 (ptr, ...) @printf(ptr @fmt-out, i64 -1)
    br label %exit

exit:
    ret void
}

define i32 @main() {
    call void @sol()

    ret i32 0
}
; @code end