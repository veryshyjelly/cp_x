; Created by Ayush Biswas at 2026/06/11 10:27
; https://atcoder.jp/contests/abc126/tasks/abc126_a

; @include fast_io

; @head begin
declare i32 @printf(ptr, ...)
; @head end

; @code begin

; format strings for scanning and printing
@fmt-out = constant [4 x i8] c"%s\0A\00"

define void @sol() {
    ; read n and k
    %n = call i64 @read-i64()
    %k = call i64 @read-i64()
    
    %s = alloca [100 x i8]
    call i64 @read-string(ptr %s)

    %idx = sub i64 %k, 1 ; get the index

    %char.ptr = getelementptr [100 x i8], ptr %s, i64 0, i64 %idx

    %char = load i8, ptr %char.ptr
    %char.lower = add i8 %char, 32 ; convert to lowercase
    store i8 %char.lower, ptr %char.ptr

    call i32 (ptr, ...) @printf(ptr @fmt-out, ptr %s)

    ret void
}

define i32 @main() {
    call void @sol()

    ret i32 0
}
; @code end