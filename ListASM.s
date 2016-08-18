.file "ListASM.s"
.text

	.global removeFirst

removeFirst:

	#rdi - Node **
	#rdi - Node * head
	#rbx - node * head->next Callee saved

	pushq %rbp
	movq %rsp, %rbp 
	pushq %rbx	#Caller saved register
	movq $1, %rax	#Initialize rax to 1 (empty error) We don't have to
			#worry about losing this in the call to free since
			#we'll set it to 0 in that case anyway.

	cmp $0,(%rdi)
	je .removeFirst_End

	#pushq (%rdi)	#Pushing our head pointer onto the stack for later use
	pushq %rdi
	movq (%rdi), %rdi #storing the dereferenced handle in rdi to pass as arg
	movq (%rdi), %rbx #While we've got the head, store next in rbx
	call free

	popq %rdi 	#Restore rdi
	movq %rbx, (%rdi)
	movq $0, %rax	#set return value to no error

.removeFirst_End:

	popq %rbx
	popq %rbp
	retq

	



	.globl addToList

addToList:

	pushq %rbp
	movq %rsp, %rbp

	pushq %rdi
	pushq %rsi
	movq $16,%rdi

	call malloc

	popq %rsi
	popq %rdi
	movq (%rdi),%r10 #Store the current head of the list


	movq %r10,(%rax)  #Set the new node's next to head
	movq %rsi, 8(%rax) #Set our integer data
	movq %rax, (%rdi) #Set our head to the new node

	movq $0, %rax	  #return success
	

	popq %rbp
	retq	
	
	.globl deleteList

deleteList:

	pushq %rbp
	movq %rsp, %rbp

	pushq %rdi	#Push the list handle onto the stack- we don't need it until the end.
	movq (%rdi),%rdi#Then store the node pointer into rdi

.deleteList_compare:
	cmp $0, %rdi	
	je .deleteList_empty

.deleteList_delete:
	pushq (%rdi)	#Push the next pointer onto the stack
	call free	
	popq %rdi	#Instead of restoring to original value of rdi, we restore to the next pointer
	jmp .deleteList_compare

.deleteList_empty:
	popq %rdi	#Restore our original list handle
	movq $0, (%rdi)	#Set our first node pointer to null

	movq  $0, %rax	#Return success

	popq %rbp
	ret

	.globl cleanupList

cleanupList:

	pushq %rbp
	movq %rsp, %rbp

	movq (%rdi), %rdi#Dereference the list handle
	call free
			#No need to restore rdi
	movq $0, %rax	#Return success
	popq %rbp
	ret
