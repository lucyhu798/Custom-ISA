/* CSE141L
   possible lookup table for PC target
   leverage a few-bit pointer to a wider number
   Lookup table acts like a function: here Target = f(Addr);
 in general, Output = f(Input); lots of potential applications 
*/
module LUT(
  input       [ 3:0] Addr,
  output logic[ 9:0] Target
  );

always_comb begin
	Target = 'b1;
 case(Addr)		   
	4'b0000:    Target = 'b0;
	4'b0001:    Target = 'b10;	 
	4'b0010:    Target = 'b11;
   4'b0011:    Target = 'b101010000;  
	4'b0100:    Target = 'b101;	 
	4'b0101:    Target = 'b1000;
   4'b0110:    Target = 'b1001;  
	4'b0111:    Target = 'b10000;	 
	4'b1001:    Target = 'b10001;	 
	4'b1010:    Target = 'b100000;
   4'b1011:    Target = 'b100001;  
	4'b1100:    Target = 'b11111;	 
	4'b1101:    Target = 'b1111;
   4'b1110:    Target = 'b111; 
	4'b1111:    Target = 'b110;
  endcase
end

endmodule




// /* CSE141L
//    possible lookup table for PC target
//    leverage a few-bit pointer to a wider number
//    Lookup table acts like a function: here Target = f(Addr);
//  in general, Output = f(Input); lots of potential applications 
// */
// module LUT(
//   input       [ 3:0] Addr,
//   output logic[ 9:0] Target
//   );

// always_comb begin
// 	Target = 'b1;
//  case(Addr)		   
// 	4'b0000:    Target = 'b0;
// 	4'b0001:    Target = 'b101001110;	 //334
// 	4'b0010:    Target = 'b1011001011;  //715
//    4'b0011:    Target = 'b1011011000;  //728
// 	4'b0100:    Target = 'b110011011;	 //411
// 	4'b0101:    Target = 'b111010111; //471
//    4'b0110:    Target = 'b1000010001;  //529
// 	4'b0111:    Target = 'b1001001101;	 //589
// 	4'b1000:    Target = 'b1010001011; 	 //651
// 	4'b1001:    Target = 'b1010111100;  //700
//    4'b1010:    Target = 'b1010111000;  //696
// // 	4'b1100:    Target = 'b11111;	 
// // 	4'b1101:    Target = 'b1111;
// //    4'b1110:    Target = 'b111; 
// // 	4'b1111:    Target = 'b110;
//   endcase
// end

// endmodule