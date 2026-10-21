; Created by Ayush Biswas at 2026/06/15 23:05
; https://atcoder.jp/contests/abc127/tasks/abc127_d

; @include itertools
; @include fast_io

; @head begin
declare i32 @printf(ptr, ...)
declare void @qsort(ptr, i64, i64, ptr) ; (arr, size, width, cmp)
declare i64 @llvm.smin.i64(i64, i64)
; @head end

; @code begin

; format strings for printing
@fmt-out = constant [4 x i8] c"%ld\00"

define void @read-ai(ptr %el.ptr) {
    %el = call i64 @read-i64()
    store i64 %el, ptr %el.ptr
    ret void
}

define i32 @cmp-ai(ptr %a.ptr, ptr %b.ptr) {
    %a = load i64, ptr %a.ptr
    %b = load i64, ptr %b.ptr
    
    %gt = icmp sgt i64 %a, %b
    %lt = icmp slt i64 %a, %b

    %r1 = select i1 %gt, i32 -1, i32 0
    %r2 = select i1 %lt, i32 1, i32 %r1
    ret i32 %r2
}

define void @read-op(ptr %el.ptr) {
    %b = call i64 @read-i64()
    %c = call i64 @read-i64()
    %b_ = insertvalue { i64, i64 } undef, i64 %b, 0
    %bc = insertvalue { i64, i64 } %b_, i64 %c, 1
    store { i64, i64 } %bc, ptr %el.ptr
    ret void
}

define i32 @cmp-op(ptr %a.ptr, ptr %b.ptr) {
    %a = load { i64, i64 }, ptr %a.ptr
    %b = load { i64, i64 }, ptr %b.ptr
    %a.c = extractvalue { i64, i64 } %a, 1
    %b.c = extractvalue { i64, i64 } %b, 1
    %gt = icmp sgt i64 %a.c, %b.c
    %lt = icmp slt i64 %a.c, %b.c

    %r1 = select i1 %gt, i32 -1, i32 0
    %r2 = select i1 %lt, i32 1, i32 %r1
    ret i32 %r2
}

define i64 @max-sum(ptr %a, i64 %n, ptr %ops, i64 %m) {
entry:
    br label %loop
loop:
    %i = phi i64 [ 0, %entry ], [ %i.next, %ac-cond ], [ %i.body.next, %loop.body ]
    %j = phi i64 [ 0, %entry ], [ %j, %ac-cond ], [ %j.next, %loop.body ]
    %sum = phi i64 [ 0, %entry ], [ %sum, %ac-cond ], [ %sum.next, %loop.body ]
    %"j<m?" = icmp slt i64 %j, %m
    br i1 %"j<m?", label %i-bound, label %loop.end
i-bound:
    %"i<n?" = icmp slt i64 %i, %n
    br i1 %"i<n?", label %ac-cond, label %loop.end
ac-cond:
    ; extract values from the arrays
    %a.i.ptr = getelementptr i64, ptr %a, i64 %i
    %a.i = load i64, ptr %a.i.ptr
    %bc.ptr = getelementptr { i64, i64 }, ptr %ops, i64 %j
    %bc = load { i64, i64 }, ptr %bc.ptr
    %b = extractvalue { i64, i64 } %bc, 0
    %c = extractvalue { i64, i64 } %bc, 1

    %"a<c?" = icmp slt i64 %a.i, %c
    %i.next = add i64 %i, 1
    br i1 %"a<c?", label %loop.body, label %loop
loop.body:
    %n-i = sub i64 %n, %i
    %jmp = call i64 @llvm.smin.i64(i64 %n-i, i64 %b)
    %cjump = mul i64 %c, %jmp
    %sum.next = add i64 %sum, %cjump
    %i.body.next = add i64 %i, %jmp
    %j.next = add i64 %j, 1
    br label %loop

loop.end:
    %sum.final = phi i64 [ %sum, %i-bound ], [ %sum, %loop ]
    %i.final = phi i64 [ %i, %i-bound ], [ %i, %loop ]
    br label %sum_rest

sum_rest:
    %k = phi i64 [ %i.final, %loop.end ], [ %k.next, %sum_rest.body ]
    %acc = phi i64 [ %sum.final, %loop.end ], [ %acc.next, %sum_rest.body ]

    %cond = icmp slt i64 %k, %n
    br i1 %cond, label %sum_rest.body, label %sum_rest.end

sum_rest.body:
    %ptr = getelementptr i64, ptr %a, i64 %k
    %val = load i64, ptr %ptr

    %acc.next = add i64 %acc, %val
    %k.next = add i64 %k, 1

    br label %sum_rest

sum_rest.end:
    ret i64 %acc
}

define void @sol() {
    %n = call i64 @read-i64()
    %m = call i64 @read-i64()
    
    %a = alloca i64, i64 %n
    call void @for-each(ptr %a, i64 %n, i64 8, ptr @read-ai)
    call void @qsort(ptr %a, i64 %n, i64 8, ptr @cmp-ai)

    %ops = alloca { i64, i64 }, i64 %m
    call void @for-each(ptr %ops, i64 %m, i64 16, ptr @read-op)
    call void @qsort(ptr %ops, i64 %m, i64 16, ptr @cmp-op)

    %res = call i64 @max-sum(ptr %a, i64 %n, ptr %ops, i64 %m)
    call i32 (ptr, ...) @printf(ptr @fmt-out, i64 %res)

    ret void
}

define i32 @main() {
    call void @sol()

    ret i32 0
}
; @code end