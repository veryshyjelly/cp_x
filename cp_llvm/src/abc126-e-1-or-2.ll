; Created by Ayush Biswas at 2026/06/14 16:41
; https://atcoder.jp/contests/abc126/tasks/abc126_e

; @include fast_io
; @include dsu

; @head begin
declare i32 @printf(ptr, ...)
; @head end

; @code begin

; format strings printing
@fmt-out = constant [4 x i8] c"%ld\00"

define void @read-edges(ptr %dsu, i64 %m) {
entry:
    br label %loop
loop:
    %i = phi i64 [ 0, %entry ], [ %i.next, %loop.body ]
    %"i=n?" = icmp eq i64 %i, %m
    br i1 %"i=n?", label %loop.end, label %loop.body
loop.body:
    %i.next = add i64 %i, 1
    %x = call i64 @read-i64()
    %y = call i64 @read-i64()
    %z = call i64 @read-i64()
    call void @dsu.union(ptr %dsu, i64 %x, i64 %y)
    br label %loop
loop.end:
    ret void
}

define i64 @count-components(ptr %dsu) {
entry:
    %n.ptr = getelementptr %struct.DSU, ptr %dsu, i64 0, i32 1
    %n = load i64, ptr %n.ptr
    %parent.ptr = getelementptr %struct.DSU, ptr %dsu, i64 0, i32 0
    %parent = load ptr, ptr %parent.ptr
    br label %loop
loop:
    %i = phi i64 [ 1, %entry ], [ %i.next, %loop.body ]
    %res = phi i64 [ 0, %entry ], [ %res.next, %loop.body ]
    %"i=n?" = icmp eq i64 %i, %n
    br i1 %"i=n?", label %loop.end, label %loop.body
loop.body:
    %i.parent.ptr = getelementptr i64, ptr %parent, i64 %i
    %i.parent = load i64, ptr %i.parent.ptr
    %"i.parent<0?" = icmp slt i64 %i.parent, 0
    %res.inc = add i64 %res, 1
    %res.next = select i1 %"i.parent<0?", i64 %res.inc, i64 %res
    %i.next = add i64 %i, 1
    br label %loop
loop.end:
    ret i64 %res
}

define void @sol() {
entry:
    %n = call i64 @read-i64()
    %m = call i64 @read-i64()

    %dsu-size = add i64 %n, 1
    %dsu = alloca %struct.DSU
    call void @dsu.init(ptr %dsu, i64 %dsu-size)
    call void @read-edges(ptr %dsu, i64 %m)

    %num-components = call i64 @count-components(ptr %dsu)
    call i32 (ptr, ...) @printf(ptr @fmt-out, i64 %num-components)

    ret void
}

define i32 @main() {
    call void @sol()

    ret i32 0
}
; @code end