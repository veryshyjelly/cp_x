; @head begin
declare ptr @malloc(i64)
declare void @llvm.memset.p0.i64(ptr, i8, i64, i1)
; @head end

; @code begin

; - Field 0: parent array, P[x] < 0 => root, size = -P[x] and P[x] >= 0 => parent
; - Field 2: n
%struct.DSU = type { ptr, i64 }

; Initialize dsu with parent of size n
define void @dsu.init(ptr %dsu, i64 %n) {
entry:
    %n.ptr = getelementptr %struct.DSU, ptr %dsu, i64 0, i32 1
    store i64 %n, ptr %n.ptr

    %required-bits = mul i64 %n, 8
    %parent = call ptr @malloc(i64 %required-bits)
    call void @llvm.memset.p0.i64(ptr %parent, i8 -1, i64 %required-bits, i1 false)
    %parent.ptr = getelementptr %struct.DSU, ptr %dsu, i64 0, i32 0
    store ptr %parent, ptr %parent.ptr

    ret void
}

; Get the representative of the set in which a belongs
define i64 @dsu.parent(ptr %dsu, i64 %a) {
entry:
    %parent.ptr = getelementptr %struct.DSU, ptr %dsu, i64 0, i32 0
    %parent = load ptr, ptr %parent.ptr
    %a.parent.ptr = getelementptr i64, ptr %parent, i64 %a
    %a.parent = load i64, ptr %a.parent.ptr
    %is-root = icmp slt i64 %a.parent, 0
    br i1 %is-root, label %exit, label %not-root
not-root:
    %parent-rec = call i64 @dsu.parent(ptr %dsu, i64 %a.parent)
    store i64 %parent-rec, ptr %a.parent.ptr
    br label %exit
exit:
    %res = phi i64 [ %a, %entry ], [ %parent-rec, %not-root ]
    ret i64 %res
}

; Get the size of a (assuming a is root)
define i64 @dsu.size(ptr %dsu, i64 %a) {
entry:
    %parent.ptr = getelementptr %struct.DSU, ptr %dsu, i64 0, i32 0
    %parent = load ptr, ptr %parent.ptr
    %a.parent.ptr = getelementptr i64, ptr %parent, i64 %a
    %a.parent = load i64, ptr %a.parent.ptr
    %a.size = sub nsw i64 0, %a.parent
    ret i64 %a.size
}

; Check whether a and b are from same set
define i1 @dsu.same(ptr %dsu, i64 %a, i64 %b) {
entry:
    %a.parent = call i64 @dsu.parent(ptr %dsu, i64 %a)
    %b.parent = call i64 @dsu.parent(ptr %dsu, i64 %b)
    %same = icmp eq i64 %a.parent, %b.parent
    ret i1 %same
}

; Union two sets a and b
define void @dsu.union(ptr %dsu, i64 %a, i64 %b) {
entry:
    %a.parent = call i64 @dsu.parent(ptr %dsu, i64 %a)
    %b.parent = call i64 @dsu.parent(ptr %dsu, i64 %b)
    %same = icmp eq i64 %a.parent, %b.parent
    br i1 %same, label %exit, label %do-union

do-union:
    %a.size = call i64 @dsu.size(ptr %dsu, i64 %a.parent)
    %b.size = call i64 @dsu.size(ptr %dsu, i64 %b.parent)
    %"a<b?" = icmp slt i64 %a.size, %b.size
    %c = select i1 %"a<b?", i64 %a.parent, i64 %b.parent
    %d = select i1 %"a<b?", i64 %b.parent, i64 %a.parent

    ; load the parent and size arrays (to update them)
    %parent.ptr = getelementptr %struct.DSU, ptr %dsu, i64 0, i32 0
    %parent = load ptr, ptr %parent.ptr
    ; get the pointers to be updated
    %c.parent.ptr = getelementptr i64, ptr %parent, i64 %c
    %d.parent.ptr = getelementptr i64, ptr %parent, i64 %d
    %d.size.new = add i64 %a.size, %b.size ; size[d] = size[d] + size[c]
    %d.parent.new = sub nsw i64 0, %d.size.new ; P[d] = -size[d]
    store i64 %d, ptr %c.parent.ptr ; set d as the parent of c
    store i64 %d.parent.new, ptr %d.parent.ptr ; update the size of d

    br label %exit

exit:
    ret void
}

; @code end