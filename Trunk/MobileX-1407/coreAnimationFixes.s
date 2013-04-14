.syntax unified

.macro ENTRY /* name */
.text
.align 2
.globl    _$0
_$0:	
.endmacro

ENTRY caFix
	bx lr