; Created by Ayush Biswas at 2026/06/13 11:21
; https://atcoder.jp/contests/abc126/tasks/abc126_d

; @include graph
; @include fast_io
; @include vector

; @head begin
declare i32 @printf(ptr, ...)
declare ptr @malloc(i64)
declare void @llvm.memset.p0.i64(ptr, i8, i64, i1)
; @head end

; @code begin

; format strings for printing
@fmt_out = constant [4 x i8] c"%d\0A\00"

define void @dfs(ptr %graph, ptr %visited, ptr %coloring, i64 %node, i64 %distance) {
entry:
    ; coloring[node] = distance % 2
    %color = and i64 %distance, 1
    %color.i1 = trunc i64 %color to i1
    %color.ptr = getelementptr i1, ptr %coloring, i64 %node
    store i1 %color.i1, ptr %color.ptr

    ; extract neighbors and neighbors.size
    %neighbors = getelementptr %struct.Vector, ptr %graph, i64 %node
    %neighbors.size.ptr = getelementptr %struct.Vector, ptr %graph, i64 %node, i32 1
    %neighbors.size = load i64, ptr %neighbors.size.ptr

    br label %loop

loop:
    %i = phi i64 [ 0, %entry ], [ %i.next, %loop.body ], [ %i.next, %visit ]
    %cmp.i = icmp slt i64 %i, %neighbors.size ; i < neighbors.size
    br i1 %cmp.i, label %loop.body, label %loop.end 
loop.body:
    %i.next = add i64 %i, 1
    %edge.ptr = call ptr @vector.get(ptr %neighbors, i64 %i) ; edge = neighbors[i]
    %edge = load {i64, i64}, ptr %edge.ptr
    
    %v = extractvalue {i64, i64} %edge, 0 ; { v,  = edge 
    %w = extractvalue {i64, i64} %edge, 1 ;   w }

    %is-visited.ptr = getelementptr i1, ptr %visited, i64 %v
    %is-visited = load i1, ptr %is-visited.ptr
    br i1 %is-visited, label %loop, label %visit
visit:
    store i1 true, ptr %is-visited.ptr
    %distance.next = add i64 %distance, %w
    call void @dfs(ptr %graph, ptr %visited, ptr %coloring, i64 %v, i64 %distance.next)

    br label %loop
loop.end:
    ret void
}

define void @print-coloring(ptr %coloring, i64 %size) {
entry:
    br label %loop
loop:
    %i = phi i64 [1, %entry], [%i.next, %loop.body]
    %cmp.i = icmp slt i64 %i, %size
    br i1 %cmp.i, label %loop.body, label %loop.end
loop.body:
    %elem.ptr = getelementptr i1, ptr %coloring, i64 %i
    %element = load i1, ptr %elem.ptr
    %elem.i32 = zext i1 %element to i32
    call void (ptr, ...) @printf(ptr @fmt_out, i32 %elem.i32)
    %i.next = add i64 %i, 1
    br label %loop
loop.end:
    ret void
}

define void @sol() {
entry:
    %n = call i64 @read_i64()

    ; Dynamically allocate an array of N Vectors on the stack
    %graph.size = add i64 %n, 1
    %graph = alloca %struct.Vector, i64 %graph.size
    %edge-count = sub i64 %n, 1

    call void @init-graph(ptr %graph, i64 %n)
    call void @read-undirected-graph(ptr %graph, i64 %edge-count)

    %visited = alloca i1, i64 %graph.size
    %coloring = alloca i1, i64 %graph.size
    call void @llvm.memset.p0.i64(ptr %visited, i8 0, i64 %graph.size, i1 false)
    call void @llvm.memset.p0.i64(ptr %coloring, i8 0, i64 %graph.size, i1 false)

    %visited.1 = getelementptr i1, ptr %visited, i64 1
    store i1 true, ptr %visited.1

    call void @dfs(ptr %graph, ptr %visited, ptr %coloring, i64 1, i64 0)
    call void @print-coloring(ptr %coloring, i64 %graph.size)

    ret void
}

define i32 @main() {
entry:
    call void @sol()
    ret i32 0
}
; @code end