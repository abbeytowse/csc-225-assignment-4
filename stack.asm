; Implements stack operations.
; CSC 225, Assignment 4

            .ORIG x4000
            

; NOTE: Do not alter the following lines. They are hardcoded in other files,
;       since the assembler cannot resolve cross-file labels.

            .FILL PUSH
            .FILL POP
            .FILL PEEK

; Pushes one element onto the stack.
;  Takes the stack pointer in R1, element to push in R2.
;  Returns the stack pointer in R1.
; TODO: Implement this subroutine.
PUSH        ST R2, SAVER2  ; Save R2 

			;AND R2, R2, #0 
			;ADD R2, R0, #0 
                            
            ADD R1, R1, #-1 ; Move the stack pointer *down* one location.
            STR R2, R1, #0  ; this is the push - we are storing the value of R2 in R1 
            
            LD R2, SAVER2   ; Restore R2
            
            RET             ; Return from the subroutine back to main 
            

; Pops one element off of the stack.
;  Takes the stack pointer in R1.
;  Returns the stack pointer in R1, popped element in R2.
; TODO: Implement this subroutine.
POP         ;ST R2, SAVER2   ; Save R2 

            ;AND R2, R2, #0 
			;ADD R2, R0, #0 

            LDR R2, R1, #0
            ADD R1, R1, #1  ; Move the stack pointer *up* one location.
        
            ;LD R2, SAVER2   ; Restore R2
        
            RET 

; Peeks at one element on the stack.
;  Takes the stack pointer in R1.
;  Returns the stack pointer in R1, peeked element in R2.
; TODO: Implement this subroutine.
PEEK        ;ST R2, SAVER2   ; Save R2 

            ;AND R2, R2, #0 
			;ADD R2, R0, #0

            LDR R2, R1, #0
        
            ;LD R2, SAVER2   ; Restore R2
        
            RET 
            
SAVER2  .FILL X00           ;space in to save R2  

            .END


