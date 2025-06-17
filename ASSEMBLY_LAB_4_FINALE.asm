															
.data

filtered: .align 2
.space  100

userInput: .align 2 
.space  100

user_input_text1: .asciiz "\nPlease Enter Your Character:    "

printString:.asciiz "\n\nThe String is: "

newline:.asciiz "\n"

.text 
#######################################################################################################################################
	
	main:				 
		
		jal	INIT
		
		jal 	GET_STRING
		
		jal	PROCESS_STRING					
							
		jal	OUT_STRING
	
		jal	EXIT
							
#######################################################################################################################################
	
	INIT:	# INITIALIZATION FOR (filtered) AND (userInput)
	
		addi 	$t0,$t0,0	
						
		addi 	$t4,$t4,0		
		
		la      $t5,filtered	

		la	$t1,userInput
		
	jr	$ra
		
#######################################################################################################################################

	GET_STRING:
	
		li 	 $v0,4			#"\nPlease Enter Your Character:    "
		la  	 $a0,user_input_text1
		syscall
		
		
		sub $sp,$sp,16			#TEMPORARY VARIABLE 
		sw  $s0,0($sp)			#TEMPORARY VARIABLE 
		sw  $s1,4($sp)			#TEMPORARY VARIABLE 
		sw  $s2,8($sp)			#TEMPORARY VARIABLE 	
		sw  $s3,12($sp)			#TEMPORARY VARIABLE 
		
		la  $a0,userInput		#POINTER POINTING TO (userInput)
				
			li 	 $v0,12		#GIVING VALUE TO $v0
			syscall
			move	 $s0,$v0	#STORING IT TO  $s0
			
			li 	 $v0,12		#GIVING VALUE TO $v0
			syscall
			move	 $s1,$v0	#STORING IT TO  $s1
			
			li     	 $v0,12		#GIVING VALUE TO $v0
			syscall
			move	 $s2,$v0	#STORING IT TO  $s2
			
			li 	 $v0,12		#GIVING VALUE TO $v0
			syscall
			move	 $s3,$v0	#STORING IT TO  $s3
			
			move 	 $t9,$s3	# $t9 IS USED TO STORE 4 BYTES FROM $s0,$s1,$s2,$s3
					
			sll	 $t9,$t9,8			

			or	 $t9,$t9,$s2			
			sll	 $t9,$t9,8			

			or 	 $t9,$t9,$s1		
			sll 	 $t9,$t9,8			

			or 	 $t9,$t9,$s0
			
			add	  $a0,$a0,$t0	   # $a0(userInput) + $t0(index)
			
		        sw        $t9,0($a0)     # !!!!!!!!!  STORES $t9 AS A WORD TO $a0 ADRESS  !!!!!!!!!        
		        
		        addi	   $t0,$t0,4     #  INCREASING THE INDEX BY 4 BECAUSE WE STORE WORDS
			
			
			beq	  $s0,'@',INPUT_DONE	#  SEARCHING FOR A (@) IN $S0
			beq	  $s1,'@',INPUT_DONE	#  SEARCHING FOR A (@) IN $S1
			beq	  $s2,'@',INPUT_DONE 	#  SEARCHING FOR A (@) IN $S2
			beq	  $s3,'@',INPUT_DONE	#  SEARCHING FOR A (@) IN $S3
			
			
		lw  $s0,0($sp)		# RESTORING THE ORIGINAL VALUES TO ALL THE VARIABLES SAVES IN STACK
		lw  $s1,4($sp)
		lw  $s2,8($sp)
		lw  $s3,12($sp)			
		addiu $sp,$sp,16       # LIBERATING THE STACK
		
	j GET_STRING	
	
#__________________________________________________________________________________________________________________________________				
	
	INPUT_DONE:	# EXTENSION OF THE GET STRING SUBROUTINE															
							
			
			lw  $s0,0($sp)		# RESTORING THE ORIGINAL VALUES TO ALL THE VARIABLES SAVES IN STACK
			lw  $s1,4($sp)
			lw  $s2,8($sp)
			lw  $s3,12($sp)			
			addiu $sp,$sp,16       # LIBERATING THE STACK				
											
																																															
			li   $v0,4             # "\n\nThe String is: "
			la   $a0,printString 	
			syscall
		
	jr $ra							
				
#######################################################################################################################################
	
	PROCESS_STRING:			
	
#       TEMPORARY VARIABLE STORED IN STACK	
	sub  $sp,$sp,8
	sw   $s0,0($sp)
	sw   $ra,4($sp)
		
#	PARAMETERS:
	la   $a1,userInput
	la   $a2,filtered
		
		
			beq  $t0,$zero,EXIT_PROCESS 	
			sub  $t0,$t0,1     		
			   
			add   $a1,$a1,$t4     		# (userInput)+(index)
		
			addi  $t4,$t4,1      		# USERINPUT'S ARRAY INDEX INCREASES BY 1
		
			lb    $s0,0($a1)     		
						
			beq   $s0,'!',PROCESS_STRING
			beq   $s0,'#',PROCESS_STRING
			beq   $s0,'$',PROCESS_STRING 
			beq   $s0,'@',PROCESS_STRING
			beq   $s0,'.',PROCESS_STRING  
			beq   $s0,'%',PROCESS_STRING         
			beq   $s0,'^',PROCESS_STRING       
			beq   $s0,'&',PROCESS_STRING  	   
			beq   $s0,'*',PROCESS_STRING     
			beq   $s0,'(',PROCESS_STRING        
			beq   $s0,')',PROCESS_STRING    	
			beq   $s0,'>',PROCESS_STRING  	    		 # 
			beq   $s0,'<',PROCESS_STRING     	         #.		
			beq   $s0,';',PROCESS_STRING			 ##.	
			beq   $s0,':',PROCESS_STRING		#############.
			beq   $s0,'\\',PROCESS_STRING           ###############-   !!! THIS FILTERS OUT WHAT WE DON'T WANT !!!
			beq   $s0,'=',PROCESS_STRING		#############'  
			beq   $s0,'?',PROCESS_STRING			 ##'  
			beq   $s0,'/',PROCESS_STRING		         #' 
			beq   $s0,'"',PROCESS_STRING		    	 #
			beq   $s0,'|',PROCESS_STRING	
			beq   $s0,'+',PROCESS_STRING	    
			beq   $s0,'-',PROCESS_STRING
			beq   $s0,',',PROCESS_STRING  
			beq   $s0,'_',PROCESS_STRING
			beq   $s0,']',PROCESS_STRING
			beq   $s0,'[',PROCESS_STRING
			beq   $s0,'}',PROCESS_STRING
			beq   $s0,'{',PROCESS_STRING
			beq   $s0,'\n',PROCESS_STRING
			
			add   $a2,$a2,$t8    		# (filtered)+(index)
			
			addi  $t8,$t8,1      		# FILTERED'S ARRAY INDEX INCREASES BY 1
			
			sb    $s0,0($a2)      		# SAVES BYTE TO (filtered) ARRAY	 		
			
			
	lw     $s0,0($sp)
	lw     $ra,4($sp)	# RETURNING THE ORIGINAL ADRESS
	addiu  $sp,$sp,8
		
	j PROCESS_STRING					 
#_____________________________________________________________________________________________________________________________________	
				
	EXIT_PROCESS: 			# EXTENSION OF PROCESS STRING
	 
		lw     $s0,0($sp)	# FREEING THE FUNCTION VARIABLE
		lw     $ra,4($sp)	# RETURNING THE ORIGINAL ADRESS
		addiu  $sp,$sp,8
		
		jr $ra	

#######################################################################################################################################
	
	OUT_STRING: # PRINTS OUT (filtered)
	
		li $v0,4
		la $a0,filtered
		syscall
		
	jr $ra	
			
#######################################################################################################################################
	
	EXIT: 						# EXITS PROGRAM
	
		jal     NEWLINE				#NEW LINE TO MAKE TEXT MORE GOOD LOOKING
		jal     NEWLINE				#ONE MORE JUST TO MAKE SURE
		li      $v0,10				#EXIT
		syscall

#######################################################################################################################################
	
	NEWLINE:
							#IT IS WHAT IT SAYS IT IS
							#PRINTS OUT NEW LINE TO BE MORE USER FRIENDLY
		
		
		li 	 $v0,4
		la  	 $a0,newline 			#\n 
		syscall
	
	jr $ra
#######################################################################################################################################


