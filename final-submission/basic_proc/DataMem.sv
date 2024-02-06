// Create Date:    2017.01.25
// Design Name:
// Module Name:    DataMem
// single address pointer for both read and write
// CSE141L
module DataMem #(parameter W=8, A=8)  (
  input                 Clk,
                        Reset,
                        WriteEn,
  input       [A-1:0]   DataAddress, // A-bit-wide pointer to 256-deep memory
  input       [W-1:0]   DataIn,		 // W-bit-wide data path, also
  output logic[W-1:0]   DataOut);

  logic [W-1:0] Core[2**A];			 // 8x256 two-dimensional array -- the memory itself
									 
  always_comb                        // reads are combinational
    DataOut = Core[DataAddress];

/* optional way to plant constants into DataMem at startup
    initial 
      $readmemh("dataram_init.list", Core);
*/

  always_ff @ (posedge Clk)	begin	 // writes are sequential
/*( Reset response is needed only for initialization (see inital $readmemh above for another choice)
  if you do not need to preload your data memory with any constants, you may omit the if(Reset) and the else,
  and go straight to if(WriteEn) ...
*/
	
    if(Reset) 
	$readmemh("L://Desktop//CSE141L-main//data_mem_00-initial.hex", Core);
// you may initialize your memory w/ constants, if you wish
     // for(int i=0;i<256;i++)
	//      Core[i] <= 0;
	//end
    else if(WriteEn) 
      Core[DataAddress] <= DataIn;

end

endmodule
