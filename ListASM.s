.file "ListASM.s"
.text

	.globl addToList
addToList:

	pushq %rbp 	#Push base pointer onto stack
	movq %rsp, %rbp #Move previous stack pointer to new base
	
	#Since Our List type is a node handle, we need to dereference
	#the handle before passing it into our add routine.
	movq (%rdi), %rdi
	call addItem

	popq %rbp 	#Pop the base pointer off the stack.
	retq

	.globl addItem

addItem:

	pushq %rbp 	#Push base poitner onto stack
	movq %rsp, %rbp	#Move previous stack pointer to new base
	subq $8,%rsp #Allocate space for local variables

	movq $0, %rax #clear rax
	movq %rdi,-8(%rsp)	#Store the current node pointer on the stack
	cmpq $0, (%rdi) 		#If head->next is null
	je .addItem_end 
	#Since the next pointer is the first element in the node struct,
	#we can simply dereference the pointer and store it in itself to
	#move our current forward.
	movq (%rdi), %rdi
	call addItem

.addItem_end:
	
	#Calling malloc is cheating, but we're starting small!
	pushq %rdi
	movq $16,%rdi 	#Size of data to allocate. Naievely assuming 16 bytes.
	call malloc
	popq %rdi
	movq %rax,(%rdi)	#Store the pointer returned by malloc into our cur->next
	movl %esi, 8(%rdi)	#Store the data into the integer of our struct
	movq (%rdi), %rdi 	#increment current so we can modify cur->next
	movq $0, (%rdi)

	popq %rbp
	ret
	
	
