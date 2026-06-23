; @code begin

; @init-graph: Initialize graph with n vertices
; %graph: array of vectors currently uninitialized
; %n: number of vertices
define void @init-graph(ptr %graph, i64 %n) {
entry:
    br label %loop
loop: ; Loop through 0 to n
    %i = phi i64 [ 0, %entry ], [ %i.next, %loop.body ]
    %cmp.i = icmp sle i64 %i, %n
    br i1 %cmp.i, label %loop.body, label %loop.end
loop.body:
    %graph.i = getelementptr %struct.Vector, ptr %graph, i64 %i
    call void @vector.init(ptr %graph.i)
    %i.next = add i64 %i, 1
    br label %loop
loop.end:
    ret void
}

; @read-undirected-graph: Reads undirected graph from stdin
; %graph: array of vectors already initialized
; %edge-count: count of edges in the graph
define void @read-undirect-graph(ptr %graph, i64 %edge-count) {
entry:
    ; define u, v, w once
    br label %loop
loop:
    ; loop through number of edges to read the edges
    %i = phi i64 [ 0, %entry ], [ %i.next, %loop.body ]
    %cmp.i = icmp slt i64 %i, %edge-count
    br i1 %cmp.i, label %loop.body, label %loop.end
loop.body:
    ; Read the edge: u, v, and weight w
    %u = call i64 @read_i64()
    %v = call i64 @read_i64()
    %w = call i64 @read_i64()
    
    ; store (v, w) in a[u]
    %graph.u = getelementptr %struct.Vector, ptr %graph, i64 %u.val
    ; create (v, w)
    %box = call ptr @malloc(i64 16)
    %v_ = insertvalue {i64, i64} undef, i64 %v.val, 0 
    %vw = insertvalue {i64, i64} %v_, i64 %w.val, 1
    store {i64, i64} %v.w, ptr %box
    ; Push the box into u's adjacency list
    call void @vector.push(ptr %graph.u, ptr %box)

    ; store (u, w) in a[v]
    %graph.v = getelementptr %struct.Vector, ptr %graph, i64 %v.val
    ; create (u, w)
    %box2 = call ptr @malloc(i64 16)
    %u_ = insertvalue {i64, i64} undef, i64 %u.val, 0
    %u.w = insertvalue {i64, i64} %u_, i64 %w.val, 1
    store {i64, i64} %u.w, ptr %box2
    ; Push the box into v's adjacency list
    call void @vector.push(ptr %graph.v, ptr %box2)

    %i.next = add i64 %i, 1
    br label %loop
loop.end:
    ret void
}

; @code end