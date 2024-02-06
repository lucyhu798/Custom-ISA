`timescale 1ns/ 1ps

//Test bench
//Arithmetic Logic Unit
/*
* INPUT: A, B
* op: 000, A ADD B
* op: 100, A_AND B
* ...
* Pleaser refer to definitions.sv for support ops(make changes if necessary)
* OUTPUT A op B
* equal: is A == B?
* even: is the output even?
*/


module ALU_tb;
logic [ 7:0] INPUTA;        // data inputs
logic [ 7:0] INPUTB;
logic [ 2:0] op;  // ALU opcode, part of microcode
logic        LSFT;    // decide of shift left or right 
logic [ 1:0] branches; // opcode for branches after opcode 110 
wire[ 7:0] OUT;
logic [ 7:0] expected;

// CONNECTION
ALU uut(
  .InputA(INPUTA),
  .InputB(INPUTB),
  .OP(op),
  .LSFT(LSFT),
  .Branches(branches),
  .Out(OUT)
    );

initial begin

 INPUTA = 27;
 INPUTB = 2;
 op= 'b111; 
 LSFT = 1;
 branches = 'b000;
 test_alu_func; // void function call
 #5;


 INPUTA = 4;
 INPUTB = 2;
 op= 'b111; 
 LSFT = 0; 
 branches = 'b00;
 test_alu_func; // void function call
 #5;
 end

 task test_alu_func;
 begin
  /* casez({op, LSFT, branches})
 {0, 'bz, 'bz}: expected = INPUTA + INPUTB;  // ADD 
 {1, 'bz, 'bz} : expected = INPUTA + INPUTB;  // ADDI
 {2, 'bz, 'bz} : expected = INPUTA & INPUTB;  // AND 
 {3, 'bz, 'bz} : expected = INPUTA ^ INPUTB;  // XOR
 {6, 'bz, 'b00}: expected = INPUTA < INPUTB;
 {6, 'bz, 'b01}: expected = INPUTA != INPUTB;
 {6, 'bz, 'b10}: expected = INPUTA == INPUTB;
 {6, 'bz, 'b11}: expected = 'b1; 
 {7, 1, 'bz}: expected = INPUTA << INPUTB;
 {7, 0, 'bz}: expected = INPUTA >> INPUTB;
   endcase */

    if (op == 'b000) 
	expected = INPUTA + INPUTB;
    else if (op == 'b001) 
	expected = INPUTA + INPUTB; 
    else if  (op == 'b011) 
	expected = INPUTA ^ INPUTB;
    else if (op == 'b010) 
	expected = INPUTA & INPUTB;

    else if (op == 'b110) begin 
	if (branches == 'b00) 
		expected = INPUTA < INPUTB;
	else if (branches == 'b01) 
		expected = INPUTA != INPUTB;
   	else if (branches == 'b10) 
		expected = INPUTA == INPUTB; 
	else begin
		expected = 1;
	end
    end

    else if (op == 'b111) begin 
	if (LSFT) 
	   expected = INPUTA << INPUTB; 
	else 
	   expected = INPUTA >> INPUTB; 
    end 



   #1; if(expected == OUT)
  begin
   $display("%t YAY!! inputs = %h %h, opcode = %b, LFST = %b, branches = %b, answer = %b",$time, INPUTA,INPUTB,op, LSFT, branches, OUT);
  end
     else begin $display("%t FAIL! inputs = %h %h, opcode = %b, LSFT = %b, branches %b our answer = %b, tbanswer = %b",$time, INPUTA,INPUTB,op, LSFT, branches, OUT, expected);end

 end
 endtask

endmodule
