// Create Date:    2019.01.25
// Design Name:    CSE141L
// Module Name:    reg_file 
//
// Additional Comments: 					  $clog2

/* parameters are compile time directives 
       this can be an any-width, any-depth reg_file: just override the params!
*/
module RegFile #(parameter W=8, A=3)(		 // W = data path width (leave at 8); A = address pointer width
  input                Clk,
                       Reset,
                       WriteEn,
                       BranchFlag, // get from Ctrl BranchEn and to show a different format
                       ShiftForm,  // get from Ctrl ShiftFlag to show that format
  input        [A-1:0] RaddrA,				 // address pointers
                       RaddrB,         // also used as for SaddrB
                       Waddr,
  input        [  1:0] BaddrA,
                       BaddrB,
                       SaddrA, 
  input        [W-1:0] DataIn,
  output logic [W-1:0] DataOutA,			 // showing two different ways to handle DataOutX, for
  output logic [W-1:0] DataOutB				 //   pedagogic reasons only
    );

// W bits wide [W-1:0] and 2**4 registers deep 	 
logic [W-1:0] Registers[2**A];	             // or just registers[16] if we know A=4 always

// combinational reads 
/* can write always_comb in place of assign
    difference: assign is limited to one line of code, so
	always_comb is much more versatile     
*/
 
always_comb begin

	if(BranchFlag) begin 
		DataOutA = Registers[BaddrA];	 //for branches the registers will be different instructions  
		DataOutB = Registers[BaddrB];
	end 
	else if(ShiftForm) begin 
      		DataOutA = Registers[SaddrA];	  // for shifts the registers will be at different instructiosn  
      		DataOutB = RaddrB;
	end 
	else begin 
      		DataOutA = Registers[RaddrA];	  
      		DataOutB = Registers[RaddrB];
	end 

end 



// sequential (clocked) writes 
always_ff @ (posedge Clk) begin
  if (Reset) begin
    Registers[0] <= '0;
    Registers[1] <= '0;
    Registers[2] <= '0;
    Registers[3] <= '0;
    Registers[4] <= '0;
    Registers[5] <= '0;
    Registers[6] <= '0;
    Registers[7] <= '0;
  end else if (WriteEn) begin	                             // works just like data_memory writes
   	if(ShiftForm)
		Registers[SaddrA] <= DataIn;
	else if (BranchFlag)
		Registers[BaddrA] <= DataIn;
	else
		Registers[Waddr] <= DataIn;
  end
end

endmodule
