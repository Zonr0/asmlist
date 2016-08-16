.file "ListASM.s"
.text

	.global removeFirst

removeFirst:

	#rdi - Node **
	#rdi - Node * head
	#rbx - node * head->next Callee saved

	pushq %rbp
	movq %rsp, %rbp 
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
	mov %esi, 8(%rax) #Set our integer data
	movq %rax, (%rdi) #Set our head to the new node

	movq $0, %rax	  #return success
	

	popq %rbp
	retq	
	
