; Created by Ayush Biswas at 2026/06/11 17:37
; https://atcoder.jp/contests/abc126/tasks/abc126_c

; @include fast_io

; @head begin
declare i32 @printf(ptr, ...)
; @head end

; @code begin

; Global constant formatting strings
@fmt_out = constant [7 x i8] c"%.12f\0A\00"

; Calculates the success probability starting with die value %i.
; Continuously doubles the score and halves the probability until %curr >= %k.
define double @get_prob_for_die(i64 %i, i64 %k) {
entry:
    br label %loop.cond

loop.cond:
    ; PHI state registers:
    ; - %curr_val: the active score (initial: %i, multiplied by 2 each pass)
    ; - %factor: the probability multiplier (initial: 1.0, halved each pass)
    %val.curr = phi i64 [ %i, %entry ], [ %val.next, %loop.body ]
    %factor   = phi double [ 1.0, %entry ], [ %factor.next, %loop.body ]

    ; Check if current score is strictly less than K
    %cmp = icmp slt i64 %val.curr, %k
    br i1 %cmp, label %loop.body, label %loop.exit

loop.body:
    ; Double the value, halve the probability
    %val.next = mul i64 %val.curr, 2
    %factor.next = fmul double %factor, 0.5
    br label %loop.cond

loop.exit:
    ret double %factor
}

; Sums the probabilities across all possible die outcomes from 1 to N.
; Returns the final average (accumulated probability / N).
define double @solve(i64 %n, i64 %k) {
entry:
    br label %loop

loop:
    ; PHI state registers:
    ; - %i: the loop counter (1 to N)
    ; - %sum: the accumulated probability across all die faces
    %i    = phi i64 [ 1, %entry ], [ %i.next, %loop.body ]
    %sum  = phi double [ 0.0, %entry ], [ %sum.next, %loop.body ]

    ; Exit condition: i > N
    %cmp = icmp sle i64 %i, %n
    br i1 %cmp, label %loop.body, label %loop.exit

loop.body:
    ; Fetch the winning probability for die face %i
    %p = call double @get_prob_for_die(i64 %i, i64 %k)
    
    ; Add the result to our rolling sum
    %sum.next = fadd double %sum, %p
    %i.next = add i64 %i, 1
    br label %loop

loop.exit:
    ; Cast N from a 32-bit integer to a double to perform division
    %n.double = sitofp i64 %n to double
    %ans = fdiv double %sum, %n.double
    ret double %ans
}

; MAIN ENTRY POINT
define i32 @main() {
entry:
    ; Allocate storage on the stack to read N and K
    %n = call i64 @read-i64()
    %k = call i64 @read-i64()

    ; Calculate the average probability
    %ans = call double @solve(i64 %n, i64 %k)

    ; Print the output with 12 decimal places
    call i32 (ptr, ...) @printf(ptr @fmt_out, double %ans)

    ret i32 0
}
; @code end