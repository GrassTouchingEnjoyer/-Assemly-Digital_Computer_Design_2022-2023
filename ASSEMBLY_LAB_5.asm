.data

########################################################## STRINGS ##############################################################
#________________________________________________________________________________________________________________________________
menu_string: .asciiz "\nPlease determine operation, entry (E), inquiry (I) or quit (Q): "
compliment: .asciiz "\nThank you, the new entry is the following: "
newline: .asciiz "\n"
empty_space: .asciiz " "
#________________________________________________________________________________________________________________________________

#________________________________________________________________________________________________________________________________
Choice_E_nubmer: .asciiz "\nPlease enter entry number: "
Choice_E_surname: .asciiz "\nPlease enter last name: "  
Choice_E_name: .asciiz "\nPlease enter name: "
Choice_E_phone: .asciiz "\nPlease enter phone number: "
#________________________________________________________________________________________________________________________________

#________________________________________________________________________________________________________________________________
Choice_I_number: .asciiz "\nPlease enter the entry number you wish to retrieve:   "
Choice_I_valid: .asciiz "\nThe number is: "
Choice_I_invalid: .asciiz "\nThere is no such entry in the phonebook "
#________________________________________________________________________________________________________________________________

#________________________________________________________________________________________________________________________________
Choice_Q_quit: .asciiz "\nthank you and goodbye "
#________________________________________________________________________________________________________________________________

#################################################################################################################################


################################################### MEMORY ######################################################################
name_array: .align 2 
.space  200

last_name_array: .align 2
.space  200

phone_number_array: .align 2
.space  200
#________________________________________________________________________________________________________________________________

temp_name_array: .align 2
.space  20

temp_last_name_array: .align 2
.space  20

temp_phone_array: .align 2
.space  20
#________________________________________________________________________________________________________________________________

temp_name_array_A: .align 2
.space  20

temp_last_name_array_B: .align 2
.space  20

temp_phone_array_C: .align 2
.space  20
#________________________________________________________________________________________________________________________________
temp_name_array_D: .align 2
.space  20

temp_last_name_array_E: .align 2
.space  20

temp_phone_array_F: .align 2
.space  20
#################################################################################################################################
#################################################################################################################################

.text

	main:           #IN THE MAIN FUNTION ARE ALL THE PROMPT COMMANDS (Prompt_User) LINE 385
	
		jal Prompt_User    
		
		beq $t0,'E',Get_User_Data
		
		beq $t0,'I',Print_User_Data
		
		beq $t0,'Q',Quit
		
		jal Quit
		
#################################################################################################################################		
#################################################################################################################################

	Get_User_Data:                                                # GET'S USER'S NUMBER SPOT IN THE CATALOG
			li      $v0,4
			la      $a0,Choice_E_nubmer
			syscall
									
		        li      $v0,5			
	               syscall
	               move    $t1,$v0					# THIS ONE IS FOR SAVING THE LISTINGS					
	               move    $t2,$v0					# THIS ONE IS FOR ENDING SCREEN
	               
	               bgt     $t1,10,Get_User_Data			# CHECKING IF NUMBER IS GREATER THAN 10
	j Get_User_Name

#________________________________________________________________________________________________________________________________	
	Get_User_Name:
			li $v0,4                                       # GETS USER'S NAME
			la $a0,Choice_E_name
			syscall
			
			li $a1,20
			la $a0,temp_name_array
			li $v0,8
			syscall
			
	j Get_User_Last_Name

#________________________________________________________________________________________________________________________________
	
	Get_User_Last_Name:						# GETS USER'S LAST NAME
			
			li $v0,4
			la $a0,Choice_E_surname
			syscall
			
			li $a1,20
			la $a0,temp_last_name_array
			li $v0,8
			syscall
			
	j Get_User_Number
	
#________________________________________________________________________________________________________________________________	
	
	Get_User_Number:
									# GETS USER'S TELEPHONE NUMBER
			li $v0,4
			la $a0,Choice_E_phone
			syscall
			
			li $a1,20
			la $a0,temp_phone_array
			li $v0,8
			syscall
			
	j Store_Data
	
#________________________________________________________________________________________________________________________________

	Store_Data:
	
	sub $sp,$sp,32	
	sw  $s0,0($sp)
	sw  $s1,4($sp)				   # IN THIS SEGMENT THE LISTINGS ARE SAVED
	sw  $s2,8($sp)					
	sw  $s3,12($sp)
	sw  $s4,16($sp)			
	sw  $s5,20($sp)	#pointer
	sw  $s6,24($sp)	
	sw  $s7,28($sp)	
			
	mul  $t1,$t1,20
	
###############################################
	jal FILTER_PROLOG_NAME			    # REMOVES THE \n FROM MEMORY USING (FILTER_PROLOG_NAME) LINE 432
###############################################

	la  $s5,temp_name_array_D
		
	lw  $s0,0($s5)
	lw  $s1,4($s5)
	lw  $s2,8($s5)
	lw  $s3,12($s5)				    
	lw  $s4,16($s5)	
#________________________________
	
	move $s5,$zero
	la   $s5,name_array
	add  $s6,$s5,$t1
#________________________________
		
	sw  $s0,0($s6)					#SAVES IT IN THE LIST
	sw  $s1,4($s6)			
	sw  $s2,8($s6)
	sw  $s3,12($s6)
	sw  $s4,16($s6)
					
###############################################
	jal FILTER_PROLOG_LAST_NAME			# REMOVES THE \n FROM MEMORY USING (FILTER_PROLOG_LAST_NAME) LINE 530
###############################################
		
	la  $s5,temp_last_name_array_B
		
	lw  $s0,0($s5)
	lw  $s1,4($s5)
	lw  $s2,8($s5)
	lw  $s3,12($s5)
	lw  $s4,16($s5)
#________________________________
	
	move $s5,$zero
	la   $s5,last_name_array
	add  $s6,$s5,$t1
#________________________________
		
	sw  $s0,0($s6)
	sw  $s1,4($s6)
	sw  $s2,8($s6)					#SAVES IT IN THE LIST
	sw  $s3,12($s6)
	sw  $s4,16($s6)
		
#################################
		 						
	la  $s5,temp_phone_array			# STORES PHONE NUMBER
		
	lw  $s0,0($s5)
	lw  $s1,4($s5)
	lw  $s2,8($s5)
	lw  $s3,12($s5)
	lw  $s4,16($s5)
#________________________________
	
	move $s5,$zero
	la   $s5,phone_number_array			
	add  $s6,$s5,$t1	
#________________________________
		
	sw  $s0,0($s6)					#SAVES IT IN THE LIST
	sw  $s1,4($s6)
	sw  $s2,8($s6)
	sw  $s3,12($s6)
	sw  $s4,16($s6)	
	
#################################

	li $v0,4
	la $a0,compliment
	syscall				
						
	li $v0,1
	move $a0,$t2
	syscall
	
	li $v0,4
	la $a0,newline					
	syscall
	
	li $v0,4
	la $a0,temp_name_array_D  
	syscall	
	
	li $v0,4
	la $a0,empty_space
	syscall
							# PRINTS IT OUT TO THE USER
	li $v0,4					# TO SHOW HIM WHAT WAS STORED
	la $a0,temp_last_name_array_B
	syscall	
	
	li $v0,4
	la $a0,empty_space
	syscall
	
	li $v0,4
	la $a0,temp_phone_array
	syscall	
#################################		
	lw  $s0,0($sp)
	lw  $s1,4($sp)
	lw  $s2,8($sp)
	lw  $s3,12($sp)
	lw  $s4,16($sp)	
	lw  $s5,20($sp)	
	lw  $s6,24($sp)	
	lw  $s7,28($sp)					# LIBERATES THE TYPE S REGISTERS
					
	addiu $sp,$sp,32

	j main
#################################################################################################################################
	
Print_User_Data:				
		
	sub $sp,$sp,32				# THIS FUNCTION IS FOR PRINTING THINGS ALREADY IN THE LIST
	sw  $s0,0($sp)
	sw  $s1,4($sp)
	sw  $s2,8($sp)					  
	sw  $s3,12($sp)
	sw  $s4,16($sp)			
	sw  $s5,20($sp)	
	sw  $s6,24($sp)	
	sw  $s7,28($sp)
	
#################################	
Print_User_Data_Working_Segment:

	li      $v0,4	
	la      $a0,Choice_I_number		
	syscall
	
	li      $v0,5			
	syscall				# ASKS FOR A NUMBER FROM THE USER
	
	bgt     $v0,10,Print_User_Data_Working_Segment

	mul    $t1,$v0,20		# MULTIPLES IT BY 20 			
	
	la     $s0,name_array
	la     $s1,last_name_array	
	la     $s2,phone_number_array	
	
	add    $s3,$s0,$t1			
	add    $s4,$s1,$t1		# LOAD THE LISTINGS FROM MEMORY
	add    $s5,$s2,$t1

		
	lw  $s0,0($s3)
	lw  $s1,4($s3)			
	lw  $s2,8($s3)	
	lw  $s6,12($s3)	
	lw  $s7,16($s3)	
	
	beq $s0,0x00,ERROR		# ONE CHECK FOR IF THE PLACE IN CATALOG IS EMPTY
	la  $s3,temp_name_array		# IF IT IS IT DISPLAYS MESSAGE IN SUBROUTINE (EMPTY) FOUND IN LINE 420 
					# IF NOT IT GOES ON WITH THE PROCESS		
	sw  $s0,0($s3)
	sw  $s1,4($s3)			
	sw  $s2,8($s3)	
	sw  $s6,12($s3)	
	sw  $s7,16($s3)	
	
	li $v0,4
	la $a0,temp_name_array
	syscall
	
	lw  $s0,0($s4)
	lw  $s1,4($s4)			
	lw  $s2,8($s4)	
	lw  $s6,12($s4)	
	lw  $s7,16($s4)	
	
	la  $s4,temp_last_name_array
							
	sw  $s0,0($s4)
	sw  $s1,4($s4)			
	sw  $s2,8($s4)	
	sw  $s6,12($s4)	
	sw  $s7,16($s4)	
	
	li $v0,4
	la $a0,empty_space
	syscall
	
	li $v0,4
	la $a0,temp_last_name_array
	syscall
	
	li $v0,4
	la $a0,empty_space
	syscall
	
	lw  $s0,0($s5)
	lw  $s1,4($s5)			
	lw  $s2,8($s5)	
	lw  $s6,12($s5)	
	lw  $s7,16($s5)	
	
	la  $s5,temp_phone_array
							
	sw  $s0,0($s5)
	sw  $s1,4($s5)			
	sw  $s2,8($s5)	
	sw  $s6,12($s5)	
	sw  $s7,16($s5)	
	
	li $v0,4
	la $a0,temp_phone_array
	syscall
	
	lw    $s0,0($sp)
	lw    $s1,4($sp)
	lw    $s2,8($sp)
	lw    $s3,12($sp)
	lw    $s4,16($sp)	
	lw    $s5,20($sp)	
	lw    $s6,24($sp)	
		
	addiu $sp,$sp,28
	
	j main				# RETURNS TO MAIN

#################################################################################################################################

Prompt_User:				# THIS IS THE MAIN MENU SUBROUTINE
	
	li $v0,4
	la $a0,menu_string
	syscall
	
	li $v0,12
	syscall
	move $t0,$v0
	
	ble $t0,68,Prompt_User	
	# 69	
	beq $t0,70,Prompt_User		# WE ONLY WANT THE CHARACTERS (E,I,Q)
	beq $t0,71,Prompt_User
	beq $t0,72,Prompt_User	
	# 73	
	beq $t0,74,Prompt_User
	beq $t0,75,Prompt_User
	beq $t0,76,Prompt_User
	beq $t0,77,Prompt_User
	beq $t0,78,Prompt_User
	beq $t0,79,Prompt_User
	beq $t0,80,Prompt_User	
	# 81	
	bge $t0,82,Prompt_User
	
jr $ra
	
#################################################################################################################################
#################################################################################################################################

Quit:			# USED IN (Q) SELECTION TO QUIT THE PROGRAM
	li $v0,10
	syscall				
jr $ra	

#################################################################################################################################
#################################################################################################################################
ERROR:			#USED IN (I) TO GIVE ERROR FOR EMPTY SLOTS IN MEMORY

	li $v0,4
	la $a0,Choice_I_invalid
	syscall
	
j main
#################################################################################################################################
#################################################################################################################################
FILTER_PROLOG_NAME:	

				# THIS SUBROUTINE FINDS AND RIPS OUT \n FROM (temp_name_array)
	sub $sp,$sp,36		
	sw  $s0,0($sp)
	sw  $s1,4($sp)			
	sw  $s2,8($sp)
	sw  $s3,12($sp)
	sw  $s4,16($sp)			
	sw  $s5,20($sp)	
	sw  $s6,24($sp)	
	sw  $s7,28($sp)
	sw  $ra,32($sp)
	
	li  $s3,24
	la  $s0,temp_name_array		# ARRAY WITH USER STRING
	la  $s1,temp_name_array_A	# ARRAY YET TO HAVE USER'S STRING
#################################	
FILTER_ASSIGNING:
	
	move $s2,$zero		
	lw   $s7,0($s0)			# LOADS WORD TO CHECK CHARACTERS
	lw   $s6,0($s0)			# LOAD WORD TO MAKE SURE ALL THE CAHRACTERS MAKE IT THROUGH
	addi $s0,$s0,4			# MOVES 4 BYTES IN MEMORY 
	addi $s5,$s5,4			# FOR THE CASE THAT THERE IS NOT (\n) TO TEAR OUT
	j    FILTER_MAIN		# JUMP TO MAIN
#________________________________
FILTER_MOVE_4_AND_SAVE_WORD:
	
	sw   $s6,0($s1)			# SINCE THE $s7 WORD WAS RUINED DUE TO srl THERE IS $s6
	addi $s1,$s1,4			# MOVES (temp_name_array_A) 4 BYTES IN MEMORY
	j    FILTER_ASSIGNING		# GOES TO LOAD NEXT WORD					
#________________________________																										
FILTER_MAIN:	

	beq  $s7,'\n',FILTER_EXIT			# IF (\n) HERE EXIT
	beq  $s5,$s3,FILTER_FULL			# FOR THE CASE THAT THERE IS NOT (\n) TO TEAR OUT
	addi $s2,$s2,1					# FOR LOOP WITH A (4) LOOP LIMIT
	beq  $s2,4,FILTER_MOVE_4_AND_SAVE_WORD		# IF THE LOOP IS COMPLETED THE WORD GOES THROUGH
	j    FILTER_SHIFTING
#________________________________
FILTER_FULL:							
				# FOR THE CASE THAT THERE IS NOT (\n) TO TEAR OUT
	li  $s2,0	
	j   FILTER_EXIT

#________________________________	
FILTER_SHIFTING:
				# SHIFTS TO NEXT BYTE TO CHECK ON
	srl $s7,$s7,8	
	j   FILTER_MAIN	
#################################			
FILTER_EXIT:

	beq  $s2,1,CHECK_FOR_S2_EQUAL_1
	beq  $s2,2,CHECK_FOR_S2_EQUAL_2 	# WE ARE NOT DONE THE CHARACTERS BEFORE THE (\n) WERE NOT ADDED
	beq  $s2,3,CHECK_FOR_S2_EQUAL_3 	# SO DEPENDING ON $s2 WE FIND THE (\n) IN $S6 AND DESTROY IT
	
	lw   $s0,0($sp)
	lw   $s1,4($sp)
	lw   $s2,8($sp)
	lw   $s3,12($sp)
	lw   $s4,16($sp)			
	lw   $s5,20($sp)	
	lw   $s6,24($sp)	
	lw   $s7,28($sp)
	lw   $ra,32($sp)
	addi $sp,$sp,36	
	jr   $ra
#________________________________	
CHECK_FOR_S2_EQUAL_1:

	sll $s6,$s6,24				# IF $s2 = 1
	srl $s6,$s6,24
	sw  $s6,0($s1) 				
	
	li  $s2,0x000000
	j   FILTER_EXIT
#________________________________	
CHECK_FOR_S2_EQUAL_2:

	sll $s6,$s6,16				# IF $s2 = 2
	srl $s6,$s6,16
	sw  $s6,0($s1) 
	
	li  $s2,0x000000
	j   FILTER_EXIT
#________________________________	
CHECK_FOR_S2_EQUAL_3:				# IF $s2 = 3

	sll $s6,$s6,8
	srl $s6,$s6,8
	sw  $s6,0($s1) 
	
	li  $s2,0x000000
	j   FILTER_EXIT

#################################################################################################################################

FILTER_PROLOG_LAST_NAME:		
	
	sub $sp,$sp,36					# THIS SUBROUTINE FINDS AND TEARS OUT \n FROM (temp_last_name_array)
	sw  $s0,0($sp)					# IT IS A COPY OF (FILTER_PROLOG_NAME) IN LINE 429 SO NO NEED TO EXPLAIN
	sw  $s1,4($sp)					# FOR EXPLANATION GO TO LINE 429 
	sw  $s2,8($sp)
	sw  $s3,12($sp)
	sw  $s4,16($sp)			
	sw  $s5,20($sp)	
	sw  $s6,24($sp)	
	sw  $s7,28($sp)
	sw  $ra,32($sp)
	
	la  $s0,temp_last_name_array
	la  $s1,temp_last_name_array_B
				
#________________________________	
FILTER_ASSIGNING_2:
	
	move $s2,$zero
	lw   $s7,0($s0)	
	lw   $s6,0($s0)	
	addi $s0,$s0,4	
	addi $s5,$s5,4		
	j    FILTER_MAIN_2
#________________________________
FILTER_MOVE_4_AND_SAVE_WORD_2:
	
	sw   $s6,0($s1)
	addi $s1,$s1,4	
	j    FILTER_ASSIGNING_2						
#________________________________																										
FILTER_MAIN_2:	

	beq  $s7,'\n',FILTER_EXIT_2
	beq  $s5,24,FILTER_FULL_2		
	addi $s2,$s2,1
	beq  $s2,4,FILTER_MOVE_4_AND_SAVE_WORD_2
	j    FILTER_SHIFTING_2
#________________________________
FILTER_FULL_2:

	li  $s2,0
	j   FILTER_EXIT_2

#________________________________	
FILTER_SHIFTING_2:
	
	srl $s7,$s7,8	
	j   FILTER_MAIN_2	
#################################			
FILTER_EXIT_2:

	beq  $s2,1,CHECK_FOR_S2_EQUAL_1_2
	beq  $s2,2,CHECK_FOR_S2_EQUAL_2_2
	beq  $s2,3,CHECK_FOR_S2_EQUAL_3_2
		
	lw   $s0,0($sp)
	lw   $s1,4($sp)
	lw   $s2,8($sp)
	lw   $s3,12($sp)
	lw   $s4,16($sp)			
	lw   $s5,20($sp)	
	lw   $s6,24($sp)	
	lw   $s7,28($sp)
	lw   $ra,32($sp)
	addi $sp,$sp,36	
	jr   $ra
#________________________________	
CHECK_FOR_S2_EQUAL_1_2:
				
	sll $s6,$s6,24
	srl $s6,$s6,24
	sw  $s6,0($s1) 
		
	li  $s2,0x000000
	j   FILTER_EXIT_2				
#________________________________	
CHECK_FOR_S2_EQUAL_2_2:

	sll $s6,$s6,16
	srl $s6,$s6,16
	sw  $s6,0($s1) 
	
	li  $s2,0x000000
	j   FILTER_EXIT_2
#________________________________	
CHECK_FOR_S2_EQUAL_3_2:

	sll $s6,$s6,8
	srl $s6,$s6,8
	sw  $s6,0($s1) 
	
	li  $s2,0x000000
	j   FILTER_EXIT_2
	
#################################################################################################################################
