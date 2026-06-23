; @code begin

; @read-array: read array with n elements from stdin
; %arr: array of n elements, currently uninitialized
; %n: number of elements to read
; %f: function to call for each arr[i]
define void @for-each(ptr %arr, i64 %n, i64 %width, ptr %f) {
entry:
    br label %loop

loop:
    %i = phi i64 [ 0, %entry ], [ %i.next, %body ]

    %cond = icmp slt i64 %i, %n
    br i1 %cond, label %body, label %end

body:
    %offset = mul i64 %i, %width
    %elem.ptr = getelementptr i8, ptr %arr, i64 %offset

    call void %f(ptr %elem.ptr)

    %i.next = add i64 %i, 1
    br label %loop

end:
    ret void
}

; @code end