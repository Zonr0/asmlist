.file "ListASM.s"
.text

###############################################################################
# Function	 : removeFirst
#
# Arguments	 : rdi - List (Node **) targetList
#
# Returns	 : 1 if list is empty, 0 if remove was succesful.
#
# Preconditions  : targetList is an initialized non-empty list. Failure to init
#		   will cause the function to segfault.
#
# Postconditions : targetList will have the first item in the list removed and
#                  the head removed.
#
# Notes		 : 
###############################################################################
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

	


###############################################################################
# Function	 : addToList
#
# Arguments	 : rdi - List (Node **) targetList
#		   rsi - void * pData
#
# Returns	 : 0
#
# Preconditions	 : targetList is an initialized list. If unitialized, the
#		   function will segfault. pData must either point to a valid
#		   location in memory, or be null.
#
# Postconditions : targetList has pData added to the front of the list.
#
# Notes		 : We add at the front of the list for efficiency. This also
#		   makes it trivial to use the list in a stack implementation.
###############################################################################
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

###############################################################################
# Function	 : findInList
#
# Arguments	 : rdi - List (Node **) targetList
#		   rsi - void * pData
#		   rdx - int comparator(void *, void *)
#
# Returns	 : a void pointer that points to the saved data inside of the
#		   list.
#
# Preconditions	 : targetList must be an non-empty, initialized list. If not
#		   initialized, the function will segfault. pData must point to
#		   valid data (or null, though comparator needs to be defined
#		   to account for this). Comparator must compare the two
#		   passed in arguments and return positive if the first
#		   argument is greater than the second, 0 if equal, and
#		   negative if less.
#
# Postconditions : targetList and its contents are unchanged, but a pointer is
#		   returned to the found data.
#
# Notes		 : We need to use a user-defined comparator since we're using
#		   void pointers. The data stored in the list could be anything
###############################################################################
	
	.globl findInList
findInList:

	#RDI - List handle
	#RSI - void * containing item we're searching for
	#RDX - Comparator func pointer
	
	pushq %rbp
	movq %rsp, %rbp

.findInList_baseCase:


	movq $0, %rax	  #By default, we return 0 for not found
	movq (%rdi), %rdi #We don't need to modify our list, so just deref
	#Note, this is the same operation we use to traverse the list as well.
	cmp $0, %rdi
	je .findInList_end	

.findInList_compareItems:
	pushq %rdi
	pushq %rsi
	pushq %rdx
	movq 8(%rdi),%rdi #Pass our node's data pointer in as 1st arg
	#Asterisk is needed as part of AT&T syntax
	call *%rdx	  #RSI is already the arg we need to pass.
	popq %rdx
	popq %rsi
	popq %rdi

	cmp $0,%rax 	  #If node data matches passed in data
	jne .findInList_baseCase #Return to our base case if not found

	movq 8(%rdi),%rax #Copy our void pointer into our return
	
.findInList_end:
	
	popq %rbp
	retq
	
	.globl deleteList

###############################################################################
# Function	 : deleteList
#
# Arguments	 : rdi - List (Node **) targetList
#
# Returns	 : 0
#
# Preconditions	 : A non-empty initialized list. An unitialized list will
#		   segfault. 
#
# Postconditions : All nodes in the list are deleted. All void pointers in the
#		   nodes are freed as well.
#
# Notes		 : Data is not cleaned up yet as of 8/30/2016
###############################################################################
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

###############################################################################
# Function	 : cleanupList
#
# Arguments	 : rdi - List (Node **) targetList
#
# Returns	 : 0
#
# Preconditions	 : An empty, initialized list.
#
# Postconditions : All overhead memory is cleaned up.
#
# Notes		 : This is the opposite of our initialize function.
###############################################################################
cleanupList:

	pushq %rbp
	movq %rsp, %rbp

	movq (%rdi), %rdi#Dereference the list handle
	call free
			#No need to restore rdi
	movq $0, %rax	#Return success
	popq %rbp
	ret
