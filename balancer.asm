; Verifies the balance of string delimiters.
; CSC 225, Assignment 4

            .ORIG x3000
            

MAIN        LEA R0, PROMPT      ; Print the prompt.
            LEA R1, STACK       ; Initialize R1, the stack pointer.
            ;LD  R3, NEW_OFFSET  ; Load a "negative newline" into R3.
            PUTS
            
WHILE       LD  R3, NEW_OFFSET  ; Load a "negative newline" into R3.
            GETC                ; While the user types characters...
                OUT                 ; ...echo the character...
                ADD R4, R0, R3      ; ...and the character... ; this line is the problem...
                BRz NEWLINE         ; ...is not the newline...
            

; if R0 is a left bracket... just add to stack
                AND R3, R3, #0 
                ADD R3, R0, #-15 
                ADD R3, R3, #-15 
                ADD R3, R3, #-10 
                BRnp NONLEFTP 
                    ADD R2, R0, #0 
                    JSR PUSH            ; ...push R0 onto my stack...
                    BRnzp LEFTS
NONLEFTP        AND R3, R3, #0 
                ADD R3, R0, #-15
                ADD R3, R3, #-15 
                ADD R3, R3, #-15
                ADD R3, R3, #-15
                ADD R3, R3, #-15
                ADD R3, R3, #-15
                ADD R3, R3, #-1
                BRnp NONLEFTB 
                    ADD R2, R0, #0 
                    JSR PUSH            ; ...push R0 onto my stack...   
                    BRnzp LEFTS
NONLEFTB        AND R3, R3, #0 
                ADD R3, R0, #-15
                ADD R3, R3, #-15 
                ADD R3, R3, #-15
                ADD R3, R3, #-15
                ADD R3, R3, #-15
                ADD R3, R3, #-15
                ADD R3, R3, #-15
                ADD R3, R3, #-15
                ADD R3, R3, #-3
                BRnp NONLEFTS
                    ADD R2, R0, #0 
                    JSR PUSH            ; ...push R0 onto my stack... 
                    BRnzp LEFTS
                    
; something to determine if they are just characters... not brackets... then we just jumped back down to the while 
; at this point we already know they aren't left brackets

; check right brackets, if not any of the right brackets skip to the bottom 
NONLEFTS        AND R3, R3, #0 
                ADD R3, R0, #-15 
                ADD R3, R3, #-15 
                ADD R3, R3, #-11 
                BRnp NONRIGHTP  
                    BRnzp RIGHTS
NONRIGHTP       AND R3, R3, #0 
                ADD R3, R0, #-15
                ADD R3, R3, #-15 
                ADD R3, R3, #-15
                ADD R3, R3, #-15
                ADD R3, R3, #-15
                ADD R3, R3, #-15
                ADD R3, R3, #-3
                BRnp NONRIGHTB 
                    BRnzp RIGHTS
NONRIGHTB       AND R3, R3, #0 
                ADD R3, R0, #-15
                ADD R3, R3, #-15 
                ADD R3, R3, #-15
                ADD R3, R3, #-15
                ADD R3, R3, #-15
                ADD R3, R3, #-15
                ADD R3, R3, #-15
                ADD R3, R3, #-15
                ADD R3, R3, #-5
                BRnp NONRIGHTS
                    BRnzp RIGHTS

LEFTS
RIGHTS          LDR R5, R1, #0      ; grab the TOS and store in R5 
                
                AND R6, R6, #0      ; clear R6 

; I need the matches for the TOS... except if the stack is empty then I do matches for R0        
                ; if R5 is 0 put R0 in R5??? 
                ADD R5, R5, #0      ; touch R5 
                BRnp NO0
                    ADD R5, R0, R5
                    
                ; now that I have the TOS i need to figure out what its match is
                    ; if 40, the match is 41 
                    ; if 41, the match is 40 
                    ; if 91, the match is 93
                    ; if 93, the match is 91 
                    ; if 123, the match is 125 
                    ; if 125, the match is 123 
                    
                    ; storing the match in R6 
                        
                
NO0             ADD R6, R6, #15 
                ADD R6, R6, #15 
                ADD R6, R6, #11 ; 41
                AND R3, R3, #0 
                ADD R3, R5, #-15 ; this needs to be R5 not R0 to get the right expected... 
                ADD R3, R3, #-15 
                ADD R3, R3, #-10 ; 40
                BRnp NOLPM
                    BRnzp LMATCHED
NOLPM           ADD R6, R6, #-1     ; 40  
                ADD R3, R3, #-1      ; 41 
                BRnp NORPM
                    BRnzp RMATCHED
NORPM           ADD R6, R6, #15 
                ADD R6, R6, #15
                ADD R6, R6, #15
                ADD R6, R6, #6      ; 91
                ADD R3, R3, #-15
                ADD R3, R3, #-15
                ADD R3, R3, #-15
                ADD R3, R3, #-7     ; 93 
                BRnp NOLBM
                    BRnzp RMATCHED
NOLBM           ADD R6, R6, #2      ; 93 
                ADD R3, R3, #2     ; 91 
                BRnp NORBM
                    BRnzp LMATCHED
NORBM           ADD R6, R6, #15 
                ADD R6, R6, #15     ; 123 
                ADD R3, R3, #-15
                ADD R3, R3, #-15
                ADD R3, R3, #-4     ; 125
                BRnp NOLSM
                    BRnzp RMATCHED
NOLSM           ADD R6, R6, #2      ; 125
                ADD R3, R3, #2      ; 123 
                BRnp NORSM
                    BRnzp LMATCHED
                    

; unpaired right brackets are not failing - they are saying they are balanced
    ; you also have to hit enter, when in fact they should be autofailing... 

RMATCHED    NOT R6, R6 
            ADD R6, R6, #1
            
            ADD R3, R5, R6
            
            BRnzp SKIP
 
            
LMATCHED    NOT R6, R6 
            ADD R6, R6, #1
            
            NOT R5, R5 
            ADD R5, R5, #1
            
            ADD R3, R0, R5
            
            BRz FINE
        
            ADD R3, R0, R6   
                

SKIP        BRnp NOPAIR
                JSR POP
                ADD R1, R1, #-1 
                AND R3, R3, #0 
                STR R3, R1, #0
                ADD R1, R1, #1
FINE 
MATCHED
NONRIGHTS
NORSM
NONBRACKET	    BRnzp WHILE         ; ...loop back 

; what is we calculate the expected match with every bracket... so every time 
; with this set up we don't know what the expected match is... 
NEWLINE	        LDR R5, R1, #0 
                ADD R5, R5, #0 
                BRz FINAL
                    BRnzp NOPAIR 

NOPAIR     LEA R0, UNBALANCED 
            PUTS 
            
            NOT R6, R6 
            ADD R6, R6, #1          ; unnegate R6 
            
            ADD R0, R6, #0          ; touch R6
            OUT
            
            AND R0, R0, #0          ; ...get the ASCII '''... 
            ADD R0, R0, #15
            ADD R0, R0, #15  
            ADD R0, R0, #9
            OUT                     ; ...print the '''...
            
            AND R0, R0, #0          ; ...get the ASCII '.'... 
            ADD R0, R0, #15
            ADD R0, R0, #15  
            ADD R0, R0, #15
            ADD R0, R0, #1
            OUT                     ; ...print the '.'...
            
            BRnzp DONE
			
FINAL       LEA R0, BALANCED            ; load the balanced string     
            PUTS                        ; print the balanced string
            
            ; If the user hits the ‘Enter’ key, your program may assume that they will not type any additional input.
            ; It must ensure that there exist no unbalanced opening delimiters, then quit.
            
            ; TODO Complete this program
            ;       If an opening delimiter is typed, push it onto the stack.
            ;       If a closing delimiter is typed, pop an opening delimiter
            ;        off of the stack and ensure that they match.
            ;       When the expression ends, ensure that the stack is empty.
            

DONE        HALT            ; Halt.

; Space for a stack with capacity 16
            .BLKW #16
STACK       .FILL x00

; TODO Add any additional required constants or subroutines below this point.
PROMPT          .STRINGZ "Enter a string: "
BALANCED        .STRINGZ "Delimiters are balanced."
UNBALANCED      .STRINGZ "\nDelimiters are not balanced. Expected '"
NEW_OFFSET  .FILL x-0A

; NOTE Do not alter the following lines. They allow the subroutines in other
;       files to be called without manually calculating their offsets.

PUSH        ST  R6, PUSHR6
            ST  R7, PUSHR7
            LDI R6, PUSHADDR
            JSRR R6
            LD  R7, PUSHR7
            LD  R6, PUSHR6
            RET

PUSHR6      .FILL x0000
PUSHR7      .FILL x0000
PUSHADDR    .FILL x4000

POP         ST  R6, POPR6
            ST  R7, POPR7
            LDI R6, POPADDR
            JSRR R6
            LD  R7, POPR7
            LD  R6, POPR6
            RET

POPR6       .FILL x0000
POPR7       .FILL x0000
POPADDR     .FILL x4001

PEEK        ST  R6, PEEKR6
            ST  R7, PEEKR7
            LDI R6, PEEKADDR
            JSRR R6
            LD  R7, PEEKR7
            LD  R6, PEEKR6
            RET

PEEKR6      .FILL x0000
PEEKR7      .FILL x0000
PEEKADDR    .FILL x4002

            .END
