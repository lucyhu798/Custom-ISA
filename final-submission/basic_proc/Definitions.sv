//This file defines the parameters used in the alu
// CSE141L
//	Rev. 2020.5.27
// import package into each module that needs it
//   packages very useful for declaring global variables
package definitions;
    
// Instruction map
    const logic [2:0]kADD  = 3'b000;    //Add 
    const logic [2:0]kADDI  = 3'b001;   //Addi
    const logic [2:0]kAND  = 3'b010;    // AND 
    const logic [2:0]kXOR  = 3'b011;    // XOR 
    const logic [2:0]kSTR  = 3'b100;    // store 
	const logic [2:0]kLOAD  = 3'b101; // load 
	const logic [2:0]kBHS  = 3'b110; // branches 
    const logic [2:0]kSFT   = 3'b111; // shift 
// enum names will appear in timing diagram
    typedef enum logic[2:0] {
        ADD, ADDI, AND, XOR,
        STR, LOAD, BHS, SFT } op_mne;
// note: kADD is of type logic[2:0] (3-bit binary)
//   ADD is of type enum -- equiv., but watch casting
//   see ALU.sv for how to handle this   
endpackage // definitions
