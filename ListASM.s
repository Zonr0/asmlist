.file "ListASM.s"
.text

	.globl addBeginning
addBeginning:
	pushq %rbp
	movq %rsp, %rbp

	pushq %rdi
	pushq %rsi
	movq $16, %rdi 		#Set the size of data to allocate
	call malloc
	popq %rsi	
	popq %rdi

	movl %esi,8(%rax)

	movq (%rdi), %r10 	#Store head
	movq %r10, (%rax)	#Set new node's next to head
	movq %rax, (%rdi)	#Set head to new node.

	popq %rbp
	retq
	
	.globl addToListSorted
addToListSorted:
	#Note: Buggy!

	pushq %rbp 	#Push base pointer onto stack
	movq %rsp, %rbp #Move previous stack pointer to new base
	
	#Since Our List type is a node handle, we need to dereference
	#the handle before passing it into our add routine.
	#pushq %rdi
	#movq (%rdi), %rdi

	cmp $0,(%rdi)
	je .addToListSorted_Empty_List
	
	call addItemSorted
	jmp .addToListSorted_End

.addToListSorted_Empty_List:
	pushq %rsi
	pushq %rdi
	movq $16,%rdi  
	call malloc

	#Restore our registers after the function call
	popq %rdi 
	popq %rsi

	movq %rax, (%rdi)	#Set our first pointer to point to the new node.
	movq (%rdi), %rdi 	#Get the actual struct starting address
	movq $0, (%rdi)		#Initialize a null next pointer
	movl %esi, 8(%rdi)	#Fill in the data at the integer loc for the struct.

.addToListSorted_End:
	popq %rbp 	#Pop the base pointer off the stack.
	retq

	.globl addItemSorted

addItemSorted:

	pushq %rbp 		#Push base poitner onto stack
	movq %rsp, %rbp		#Move previous stack pointer to new base

	movq $0, %rax 		#clear rax
	cmpq $0, (%rdi) 	#If head->next is null
	je .addItemSorted_add 
	cmp  %esi, 8(%rdi)	#Compare esi to data in next
	jge  .addItemSorted_add
	#Since the next pointer is the first element in the node struct,
	#we can simply dereference the pointer and store it in itself to
	#move our current forward.
	movq (%rdi), %rdi	#head = head->next
	call addItemSorted
	jmp .addItemSorted_end

.addItemSorted_add:
	
	pushq %rdi
	pushq %rsi

	movq $16,%rdi 		#Size of data to allocate. Naievely assuming 16 bytes.
	call malloc
	popq %rsi
	popq %rdi
	movq (%rdi), %r10	#Pushing next pointer onto stack
	movq %rax,(%rdi)	#Store the pointer returned by malloc into our cur->next
	movl %esi, 8(%rdi)	#Store the data into the integer of our struct
	movq (%rdi), %rdi 	#increment current so we can modify cur->next
	movq %r10, (%rdi)

.addItemSorted_end:

	popq %rbp
	ret

.globl deleteList

deleteList: 

	pushq %rbp
	movq %rsp, %rbp

	
	
	
