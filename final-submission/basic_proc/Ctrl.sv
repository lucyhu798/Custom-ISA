// CSE141L
import definitions::*;
// control decoder (combinational, not clocked)
// inputs from instrROM, ALU flags
// outputs to program_counter (fetch unit)
module Ctrl (
  input[ 8:0] Instruction,	  // machine code
  input Start, 
  input Clk,
  output logic Jump     ,     // to see if we are doing branchAbs 
               LtFlag,        // flag to know if we want to access LUT2  
               AddiFlag,      // flag to know if we want to access LUT2 
               ShiftFlag,     // flag to see if we are shifting for reg file 
               BranchEn ,     // to see if we are doing Branchreletive 
	             RegWrEn  ,	    // write to reg_file (common)
	             MemWrEn  ,	    // write to mem (store only)
               LoadInst	,	   // mem or ALU to reg_file ?
	             Ack,		        // "done w/ program"
  output logic [3:0] TargSel,       // Select signal for LUT
  output logic [1:0] LtSel,        // select signal for LUT2
  output logic [2:0] AddiSel      // select signal for LUT2
  );

assign MemWrEn = Instruction[8:6]== kSTR;	 //flag for when we want to do store 

assign RegWrEn = Instruction[8:6] != kSTR; // flag for when we want to do load  

assign LtFlag = Instruction[8:4] == 'b11000; // flag for lt LUT2 value 

assign ShiftFlag = Instruction[8:6] == kSFT; // flag for RegFile to know the shift format

assign AddiFlag = Instruction[8:6] == kADDI; // flag for Addi LUT2 value 

assign LoadInst = Instruction[8:6] == kLOAD;

always_comb
  if(Instruction[8:6] ==  kBHS) begin 
    if(Instruction[5:4] == 'b11) begin 
      Jump = 1;
      BranchEn = 0; 
    end 
    else begin
      Jump = 0;
      BranchEn = 1; 
    end 
  end 
  else begin 
    Jump = 0;
    BranchEn = 0; 
  end 

  // if (Start) 
  //   Ack = 'b0; 
  // else 
  //   Ack = &Instruction;



assign TargSel  = Instruction[3:0]; // my targSel that is going into the LUT to see which BranchAbs we will go to
	
assign AddiSel = Instruction[2:0];

assign LtSel = Instruction[1:0]; 

always_ff @(posedge Clk) begin
  if (Start)
    Ack <= 'b0;
  else 
    Ack <= &Instruction;
end


endmodule
