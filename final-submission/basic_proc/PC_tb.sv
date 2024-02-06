timeunit 1ns;
timeprecision 1ps;

//Test bench
//Arithmetic Program Counter
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


module PC_tb;
logic Reset;        
logic Start;
logic Clk;  
logic BranchRel; 
logic BranchAbs;
logic Decision;
logic ALU_flag;
logic [9:0] target;
logic [9:0] ProgCtr;

// CONNECTION
ProgCtr uut(
  .Reset(Reset),
  .Start(Start),
  .Clk(Clk),
  .BranchRel(BranchRel),
  .BranchAbs(BranchAbs),
  .Decision(Decision),
  .ALU_flag(ALU_flag),
  .Target(target),
  .ProgCtr(ProgCtr)
    );


initial begin

 BranchRel = 0;
 BranchAbs = 0;
 Decision = 0;
 Reset = 1;
 #1;
 Reset = 0;
 BranchAbs = 1;
 target = 20;
 test_pc_func; 
 #1;
 Reset = 1;
 BranchAbs = 0;
 #5;

 test_pc_func;
 #5;

 #1;
 Reset = 0;
 BranchRel = 1;
 Decision = 1;
 test_pc_func;
 #1;
 Reset = 1;
 #5;
 Reset = 0;
 Decision = 0;
 test_pc_func;
 #1;

 Reset = 1;
 #5;
 Reset = 0;
 BranchRel = 0;
 test_pc_func;
 end

 always begin
     #1 Clk = 'b1;
     #1 Clk = 'b0;
 end

 task test_pc_func;
 begin
   #1; 
   $display("%t ProgCtr = %d", $time, $ProgCtr);
 end
 endtask

endmodule
