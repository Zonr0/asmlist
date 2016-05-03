.file "ListASM.s"
.text

	.globl addItem

addItem:

	pushq %rbp 	#Push base poitner onto stack
	movq %rsp, %rbp	#Move previous stack pointer to new base
	subq $8,%rsp #Allocate space for local variables

	movq $0, %rax #clear rax
	movq %rdi,-8(%rsp)	#Store the current node pointer on the stack
	cmpq $0, %rdi 		#If head is null
	je .end 
	leaq %			#Compute the address of the next pointer
	call addItem
.end

	

