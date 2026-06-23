; @head begin
declare ptr @malloc(i64)
declare ptr @realloc(ptr, i64)
declare void @free(ptr)
; @head end

; @code begin

; - Field 0: ptr (pointer to the raw i64 data array on the heap)
; - Field 1: i64 (current size - number of elements)
; - Field 2: i64 (current capacity - maximum elements allocated)
%struct.Vector = type { ptr, i64, i64 }

; Allocates initial heap memory for 2 elements and sets size/capacity.
define void @vector.init(ptr %vec) {
entry:
    ; Allocate space for 2 elements of i64 (2 * 8 = 16 bytes)
    %data = call ptr @malloc(i64 16)
    %data.ptr = getelementptr %struct.Vector, ptr %vec, i64 0, i32 0
    store ptr %data, ptr %data.ptr

    %size.ptr = getelementptr %struct.Vector, ptr %vec, i64 0, i32 1
    store i64 0, ptr %size.ptr
    %cap.ptr = getelementptr %struct.Vector, ptr %vec, i64 0, i32 2
    store i64 2, ptr %cap.ptr
    
    ret void
}

; Appends an element. Automatically doubles the capacity if size == capacity.
define void @vector.push(ptr %vec, ptr %val) {
entry:
    ; Get pointers to size and capacity
    %size.ptr = getelementptr %struct.Vector, ptr %vec, i64 0, i32 1
    %size = load i64, ptr %size.ptr
    
    %cap.ptr = getelementptr %struct.Vector, ptr %vec, i64 0, i32 2
    %cap = load i64, ptr %cap.ptr
    
    %data.ptr = getelementptr %struct.Vector, ptr %vec, i64 0, i32 0
    
    ; If size == capacity, jump to resize block, else jump to insert
    %need-resize = icmp eq i64 %size, %cap
    br i1 %need-resize, label %resize, label %insert

resize:
    ; Double the capacity: new_cap = cap * 2
    %new-cap = mul i64 %cap, 2
    store i64 %new-cap, ptr %cap.ptr
    
    ; Calculate new byte size: new_cap * 8 (shifted left by 3)
    %new-bytes = shl i64 %new-cap, 3

    ; Load old pointer and pass to realloc
    %old-data = load ptr, ptr %data.ptr
    %new-data = call ptr @realloc(ptr %old-data, i64 %new-bytes)
    store ptr %new-data, ptr %data.ptr

    br label %insert

insert:
    ; Load the active pointer (reloaded in case 'realloc' moved the memory)
    %data = load ptr, ptr %data.ptr
    
    ; Calculate offset: data[size]
    %elem.ptr = getelementptr i64, ptr %data, i64 %size
    store ptr %val, ptr %elem.ptr
    
    ; Increment the size: size = size + 1
    %new-size = add i64 %size, 1
    store i64 %new-size, ptr %size.ptr
    
    ret void
}

define ptr @vector.get(ptr %vec, i64 %idx) {
    %data.ptr = getelementptr %struct.Vector, ptr %vec, i64 0, i32 0
    %data = load ptr, ptr %data.ptr 

    %element.ptr = getelementptr ptr, ptr %data, i64 %idx
    %element = load ptr, ptr %element.ptr
    ret ptr %element
}

; Returns whether the vector is empty or not
define i1 @vector.is-empty(ptr %vec) {
    ; Load the current size
    %size.ptr = getelementptr %struct.Vector, ptr %vec, i64 0, i32 1
    %size = load i64, ptr %size.ptr
    
    ; Check if empty
    %is-empty = icmp eq i64 %size, 0
    ret i1 %is-empty
}

; Returns a structure: { value, is_valid_boolean }
define { ptr, i1 } @vector.pop(ptr %vec) {
entry:
    %is-empty = call i1 @vector.is-empty(ptr %vec)
    br i1 %is-empty, label %empty, label %pop-val

pop-val:
    ; Load size
    %size.ptr = getelementptr %struct.Vector, ptr %vec, i64 0, i32 1
    %size = load i64, ptr %size.ptr

    ; Index of last element
    %last-idx = sub i64 %size, 1
    
    ; Load the element from memory
    %data.ptr = getelementptr %struct.Vector, ptr %vec, i64 0, i32 0
    %data = load ptr, ptr %data.ptr
    %elem.ptr = getelementptr i64, ptr %data, i64 %last-idx
    %val = load ptr, ptr %elem.ptr
    
    ; Update size
    store i64 %last-idx, ptr %size.ptr
    
    ; 1. Construct success struct: { %val, true }
    %s0 = insertvalue { ptr, i1 } undef, ptr %val, 0
    %s1 = insertvalue { ptr, i1 } %s0, i1 true, 1
    ret { ptr, i1 } %s1

empty:
    ; 2. Construct failure struct: { undef, false }
    ; 'undef' indicates the value field is garbage and should not be read
    %f0 = insertvalue { ptr, i1 } undef, ptr undef, 0
    %f1 = insertvalue { ptr, i1 } %f0, i1 false, 1
    ret { ptr, i1 } %f1
}

; Deallocates the heap-allocated array.
define void @vector.free(ptr %vec) {
entry:
    %data.ptr = getelementptr %struct.Vector, ptr %vec, i64 0, i32 0
    %data = load ptr, ptr %data.ptr
    call void @free(ptr %data)
    ret void
}

; @code end