/*** asmFunc.s   ***/
/* Tell the assembler to allow both 16b and 32b extended Thumb instructions */
.syntax unified

#include <xc.h>

/* Tell the assembler that what follows is in data memory    */
.data
.align
@ Define the globals so that the C code can access them
/* define and initialize global variables that C can access */
/* create a string */
.global nameStr
.type nameStr,%gnu_unique_object
    
/*** STUDENTS: Change the next line to your name!  **/
nameStr: .asciz "Gabriel Raya"  

.align   /* realign so that next mem allocations are on word boundaries */
 
/* initialize a global variable that C can access to print the nameStr */
.global nameStrPtr
.type nameStrPtr,%gnu_unique_object
nameStrPtr: .word nameStr   /* Assign the mem loc of nameStr to nameStrPtr */
 
/* define and initialize global variables that C can access */

.global dividend,divisor,quotient,mod,we_have_a_problem
.type dividend,%gnu_unique_object
.type divisor,%gnu_unique_object
.type quotient,%gnu_unique_object
.type mod,%gnu_unique_object
.type we_have_a_problem,%gnu_unique_object

/* NOTE! These are only initialized ONCE, right before the program runs.
 * If you want these to be 0 every time asmFunc gets called, you must set
 * them to 0 at the start of your code!
 */
dividend:          .word     0  
divisor:           .word     0  
quotient:          .word     0  
mod:               .word     0 
we_have_a_problem: .word     0

 /* Tell the assembler that what follows is in instruction memory    */
.text
.align

    
/********************************************************************
function name: asmFunc
function description:
     output = asmFunc ()
     
where:
     output: 
     
     function description: The C call ..........
     
     notes:
        None
          
********************************************************************/    
.global asmFunc
.type asmFunc,%function
asmFunc:   

    /* save the caller's registers, as required by the ARM calling convention */
    push {r4-r11,LR}
 
.if 0
    /* profs test code. */
    mov r0,r0
.endif
    
    /** note to profs: asmFunc.s solution is in Canvas at:
     *    Canvas Files->
     *        Lab Files and Coding Examples->
     *            Lab 5 Division
     * Use it to test the C test code */
    
    /*** STUDENTS: Place your code BELOW this line!!! **************/
    /*3. Copy the input values in those registers 
     to the mem locations labeled dividend and divisor*/
    LDR r2, =dividend
    STR r0, [r2]
    MOV r2, r0
    
    LDR r3, =divisor
    STR r1, [r3]
    MOV r3, r1
    
    /* 4.Store 0 in locations quotient and mod. */
    LDR r4, =quotient
    LDR r5, =0
    STR r5, [r4]
    LDR r7, =mod
    STR r5, [r7]
    
    /*5. Check the input values. If either input value is 0, it is an error.*/
    CMP r0, r5
    BEQ error_
    
    CMP r1, r5
    BEQ error_
    
    /* 8. Use the division-by-subtraction method we discussed in class to 
     calculate the result of performing this integer division 
     operation: dividend / divisor */
    B division_by_subtraction
    B done

division_by_subtraction:
    CMP r0, r1
    BLO stop_loop
    
   
    /*10.Store the result of the division calculation into the memory 
     location labeled quotient*/
    LDR r5, =1
    SUB r0, r0, r1
    ADD r4, r4, r5
    
    
    B division_by_subtraction
    

stop_loop:
    /* 11.Store the result of dividend mod divisor (same as dividend % divisor)
     into the memory location labeled mod */
    /*MOV r7, r2*/
    /*LDR r2, r2*/
    LDR r7, =mod
    STR r2, [r7]
    /*LDR r7, [r2]*/
    /*12.	Make sure we_have_a_problem is set to 0*/
    LDR r6, =we_have_a_problem
    /*MOV r6, #0*/
    LDR r5, =0
    STR r5, [r6]
    /*13.	Set r0 equal to the result of the division calculation */
    LDR r0, =quotient
    
    
    B done

/* 6.For any error, do the following: */
error_:
    /* a) store a value of 1 into memory location labeled 
	we_have_a_problem */
    LDR r6, =we_have_a_problem
    MOV r5, #1
    STR r5, [r6]
    /* b) put the address of quotient(not the value stored at that address!)
	in r0 */
    LDR r0, =quotient
    /* c) branch to done. */
    B done
    
    
    
    
    
    
    
    /*** STUDENTS: Place your code ABOVE this line!!! **************/

done:    
    /* restore the caller's registers, as required by the 
     * ARM calling convention 
     */
    mov r0,r0 /* these are do-nothing lines to deal with IDE mem display bug */
    mov r0,r0 /* this is a do-nothing line to deal with IDE mem display bug */

screen_shot:    pop {r4-r11,LR}

    mov pc, lr	 /* asmFunc return to caller */
   

/**********************************************************************/   
.end  /* The assembler will not process anything after this directive!!! */
           




