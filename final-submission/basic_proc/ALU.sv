// Create Date:    2018.10.15
// Module Name:    ALU 
// Project Name:   CSE141L
//
// Revision 2021.07.27
// Additional Comments: 
//   combinational (unclocked) ALU
import definitions::*;			          // includes package "definitions"
module ALU #(parameter W=8, Ops=3)(
  input        [W-1:0]   InputA,          // data inputs
                         InputB,
  input        [Ops-1 :0] OP,		      // ALU opcode, part of microcode
  input                  LSFT,           // decide left or right shift Instruction[5]
  input          [1:0]  Branches,      // help decide on which branches to chooose Instruction[5:4]
  output logic [W-1:0]   Out,		      // data output 
  output logic           RelFlag       //flag to check if our RelFlag will be true or false, input to PC.  
// you may provide additional status flags, if desired
    );								    
	 
  op_mne op_mnemonic;			          // type enum: used for convenient waveform viewing
	
  always_comb begin
    Out = 'b0;  
	 RelFlag = 'b0;
    if (OP == ADD) 
	    Out = InputA + InputB; 
    else if (OP == ADDI) 
	    Out = InputA + InputB;
    else if (OP == AND)
	    Out = InputA & InputB;
    else if  (OP == XOR) 
	    Out = InputA ^ InputB;
    else if (OP == BHS) begin 
	    if (Branches == 'b00) begin
		    RelFlag = InputA < InputB;
		    Out = InputA; 
	    end
	    else if (Branches == 'b01) begin
		    RelFlag = InputA != InputB;
		    Out = InputA;
	end 
   	  else if (Branches == 'b10) begin
	  	   RelFlag = InputA == InputB;
		    Out = InputA;
	end  
     end
    else if (OP == SFT) begin 
	    Out = InputA; 
	    if (LSFT) 
		begin	
			for (int i = 0; i < InputB; i++) 
	       			Out = {Out[6:0], 1'b0};
		end
	    else  
		begin
			for (int i = 0; i < InputB; i++) 
	      			Out = {1'b0, Out[7:1]};	
		end
	
    end
	 	
	
  end

  //assign Zero   = !Out;                   // reduction NOR
  //assign Parity = ^Out;                   // reduction XOR
  //assign Odd    = Out[0];				  // odd/even -- just the value of the LSB

  always_comb
    op_mnemonic = op_mne'(OP);			  // displays operation name in waveform viewer

endmodule
