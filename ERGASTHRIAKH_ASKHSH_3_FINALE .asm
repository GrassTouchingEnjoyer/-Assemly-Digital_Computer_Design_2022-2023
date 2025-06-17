#   							!!!  THE USE OF EACH IMPORTANT REGISTER !!!
					
#								$t0 (array_adress_index)
#								$t4 (array_adress_index)
					
#								$t1 [pointer of(userInput)array]	
#								$t5 [pointer of(filtered)array]
					
#								$t2 = [$t1 + $t0] used in (LOOP)
#								$t2 = [$t1 + $t4] used in (PRINT_ALL_ENDING)
					
#								$t6 = [$t5 + $t4] used in (PRINT_ALL_ENDING) 
									
.data

input: .byte  1

userInput: .space  100 

filtered: .space 100

user_input_text1: .asciiz "\nPlease Enter Your Character:    "

printString:.asciiz "\n\nThe String is: "

newline:.asciiz "\n"

.text 
#________________________________________________________________________________________________________________________________
	main:				 #!!!!!!INITIALIZATION!!!!!	
		
		addi 	$t0,$t0,0	 #INDEX THAT SHOWS, THE ADRESS OF EACH USERINPUT ARRAY VALUE, USED MAINLY IN LOOP 1 (LOOP) 
					 #AND THEN AS A: C(coding language) ex. (for loop) the role of index i==$t0
		addi 	$t4,$t4,0	 #INDEX THAT SHOWS, THE ADRESS OF EACH (filtered) ARRAY VALUE, USED IN LOOP 2 (PRINT_ALL_ENDING) LABEL
		
		la      $t5,filtered	 #POINTER OF THE ADRESS IN MEMORY OF (filtered) ARRAY
		la   	$t1,userInput   #POINTER OF THE ADRESS IN MEMORY OF (userInput) ARRAY
		
	j LOOP				#START THE PROGRAM GOING TO LOOP
	
#_________________________________________________________________________________________________________________________________
	LOOP:					#while (true){
			
		jal 	  TEXT1			#printf("\nPlease Enter Your Character: ");
		
		jal 	  STORE			#scanf("%c",&variable)
		
		jal       NEWLINE		#\n
		
		beq       $s1,'@',TEXT2 	#if (variable == '@'){goes to TEXT2 function}
		add       $t2,$t1,$t0	
	        addi      $t0,$t0,1		#else { pass value of variable to array, increase value of index which is represented by $t0(i++)}
	        
		sb        $s1,0($t2)		#								 				 
		
		jal       NEWLINE		#\n
		
	j LOOP					# } 			
			
#__________________________________________________________________________________________________________________________________
	TEXT1:
		#SAYS THE USER WHAT TO DO
		#PRINTS OUT INSTRUCTIONS ON THE CONSOLE
		li 	 $v0,4
		la  	 $a0,user_input_text1
		syscall
	
	jr $ra
#___________________________________________________________________________________________________________________________________
	STORE:	
		#READS THE VALUE FROM THE CONSOLE AND PLACES IT IN A TRUSTWORTHY REGISTER $s1: C(coding language) ex. a variable 
		#passes its value to another variable ,with a different purpose.
			
		li 	$v0,12
		syscall
		
		move    $s1,$v0
		
	jr $ra
#_____________________________________________________________________________________________________________________________________
	PRINT_FILTERED:
	
		#IT IS USED TO PRINT OUT THE (filtered) ARRAY FOR THE USER TO SEE WHAT CHARACTERS HE/SHE TYPED
		#WITHOUT THE CONTROL CHARACTERS.
			
		
		li 	 $v0,11	
		lb  	 $a0,0($t6)	#LOADS THE VALUE STORED IN $t6 REGISTER ADDRESS TO REGISTER $a0 TO PRINT IT OUT ON CONSOLE
		syscall  
		
	jr $ra
#_______________________________________________________________________________________________________________________________________
	NEWLINE:
		#IT IS WHAT IT SAYS IT IS
		#PRINTS OUT NEW LINE TO BE MORE USER FRIENDLY
		
		
		li 	 $v0,4
		la  	 $a0,newline 		#\n 
		syscall
	
	jr $ra
	
#___________________________________________________________________________________________________________________________________
	TEXT2:
						#HERE IT JUMPS FROM LOOP TO GIVE A TEXT TO THE USER
						#TO LET HIM/HER KNOW WHAT TEY ARE LOOKING AT
		li 	 $v0,4
		la  	 $a0,printString	#IT PRINTS OUT: "\nThe String is: "
		syscall
		
	j PRINT_ALL_ENDING			#THEN GOES TO (PRINT_ALL_ENDING) LABEL TO WRITE ON THE CONSOLE WHAT THE USER GAVE
		
				
#____________________________________________________________________________________________________________________________________
	PRINT_ALL_ENDING:			#!!! $t4 IS USED AS AN INDEX FOR ARRAY ADDRESSES IN (PRINT_ALL_ENDING) LABEL !!!

		beq   $t0,$zero,EXIT 		#NOT LETTING $t0 (from LOOP) GO TO WASTE: C(coding language) ex. (for loop)
		addi  $t0,$t0,-1     		#$t0 IS USED AS THE UPPER BOUNDS OF THE LOOP AND CONTINUES UNTIL $t0==0
			   
		add   $t2,$t1,$t4    		#FOR THE ADRESS OF (userInput) ARRAY $t2(adress of (userInput) + index)
		add   $t6,$t5,$t4    		#FOR THE ADRESS OF (filtered)  ARRAY $t6(adress of (filtered) + index)
		
		addi  $t4,$t4,1      		# $t4++  ==   index++;
		
		lb    $s1,0($t2)     		#LOAD BYTE FROM SPECIFIC ADRESS OF (userInput) ARRAY	     
		
		beq   $s1,'!',PRINT_ALL_ENDING
		beq   $s1,'#',PRINT_ALL_ENDING	
		beq   $s1,'$',PRINT_ALL_ENDING   
		beq   $s1,'.',PRINT_ALL_ENDING
		beq   $s1,'%',PRINT_ALL_ENDING       
		beq   $s1,'^',PRINT_ALL_ENDING     
		beq   $s1,'&',PRINT_ALL_ENDING	   
		beq   $s1,'*',PRINT_ALL_ENDING     
		beq   $s1,'(',PRINT_ALL_ENDING       
		beq   $s1,')',PRINT_ALL_ENDING	  	
		beq   $s1,'>',PRINT_ALL_ENDING	    
		beq   $s1,'<',PRINT_ALL_ENDING		       #.		
		beq   $s1,';',PRINT_ALL_ENDING			 ##.	
		beq   $s1,':',PRINT_ALL_ENDING		#############.
		beq   $s1,'\\',PRINT_ALL_ENDING         ###############      !!! THIS FILTERS OUT WHAT WE DON'T WANT !!!
		beq   $s1,'=',PRINT_ALL_ENDING		#############'
		beq   $s1,'?',PRINT_ALL_ENDING			 ##'
		beq   $s1,'/',PRINT_ALL_ENDING		       #'
		beq   $s1,'"',PRINT_ALL_ENDING		   
		beq   $s1,'|',PRINT_ALL_ENDING		
		beq   $s1,'+',PRINT_ALL_ENDING	    
		beq   $s1,'-',PRINT_ALL_ENDING 
		beq   $s1,',',PRINT_ALL_ENDING    
		beq   $s1,'_',PRINT_ALL_ENDING
		beq   $s1,']',PRINT_ALL_ENDING
		beq   $s1,'[',PRINT_ALL_ENDING
		beq   $s1,'}',PRINT_ALL_ENDING
		beq   $s1,'{',PRINT_ALL_ENDING
		beq   $s1,'\n',PRINT_ALL_ENDING
		
		sb    $s1,0($t6)      			 #SAVE SPECIFIC BYTE TO SPECIFIC ADRESS OF (filtered) ARRAY
		jal   PRINT_FILTERED  			 #PRINT THE CHARACTER SAVED IN THE SPECIFIC ADRESS IN (filtered) ARRAY
		
	j PRINT_ALL_ENDING				 #!!! REPEATS THE PROCCESS FROM (PRINT_ALL_ENDING) LABEL !!!
	
#_________________________________________________________________________________________________________________________
	EXIT:
		jal     NEWLINE				#NEW LINE TO MAKE TEXT MORE GOOD LOOKING
		jal     NEWLINE				#ONE MORE JUST TO MAKE SURE
		li      $v0,10				#EXIT
		syscall
			
