1. Explain which programs/features work 

Based on our ISA, all of our instructions fit in a 9-bit field. Our ISA successfully supports various operations like jump, add, addi, shift, xor, and, etc. We tested our programs with different memory inputs and the results match up with the expected results. 

Program 1 works as intended. As per the requirements, program 1 takes in a series of fifteen 11-bit message blocks from data mem[0:29] and results in the corresponding 16-bit encoded data stored in data mem[30:59].

Program 3 also works as intended. It reads in the string from data mem[128:159] and a five-bit pattern stored in bits [7:3] of data mem[160]. It correctly uses this data to populate data mem[192] with the total number of occurrences of the 5-bit pattern in all of the various 8 bytes stored in data mem. It also populates data mem[193] with the number of bytes within which the 5 bit pattern occurs. Likewise, data mem[194] is populated with the right information as per the specification. This part indicates the number of times the 5 bit pattern occurs anywhere in the 256 bit message derived from inputted memory from data mem[128:159].


2. Explain which programs/features don’t work and what challenges you faced when implementing your design. 

There were quite a few challenges we faced while implementing our design. Our initial machine code didn’t work right away as intended when we tested with the final testbench. So, we had to break down testing into smaller pieces. We focused on testing the arm code and whether or not the logic is correct for all the programs. We then made sure whether the translation from assembly to machine code was accurate or not. Furthermore, we started testing the processor. We started with different alu operations, made use of the alu testbench file, looked at the waveform to make sure things were working as they were supposed to. We then tested other things like load, store, branch instructions like jump, program counter and paid careful attention to how the waveform was impacted with our changes. We also had some problems with initializing start so that the program only runs when start is 0. But, overall, we are satisfied with the design implementation now and after thorough testing are confident that everything works for given programs. 

Program 2 did not work as intended. It seems like our program has unbounded looping due to the fact that our looping condition is not holding properly for our program to finish completion. Since it is not halting, we cannot even guess as to what worked in program 2 and what did not other than that looping condition failing. 

3. Include the link and passcode to your zoom video (see above) 
Our team did the final demo with TA Kanlin. 

