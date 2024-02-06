module LUT2(
  input        	     AddiFlag,
  input 	     LtFlag,
  input       [ 2:0] AddiVal,
  input       [ 1:0] LtVal,
  input       [ 7:0] DataOutB,
  output logic[ 9:0] inputB
  );

always_comb begin
    if(AddiFlag) begin
        case(AddiVal)
            3'b000:  inputB = 'b10100000; 
	         3'b001:	 inputB = 'b1;
	         3'b010:	 inputB = 'b100;
            3'b011:  inputB = 'b1000000;
            3'b100:  inputB = 'b100000;
            3'b101:  inputB = 'b10000;
            3'b110:  inputB = 'b1000;
            3'b111:  inputB = 'b10; 
        endcase 
    end 
    else if(LtFlag) begin
        case(LtVal)
        	2'b00:  inputB = 'b1;
	        2'b01:	inputB = 'b10011111;
	        2'b10:  inputB = 'b1000; 
            2'b11:  inputB = 'b100000; 
        endcase
    end 
    else 
        inputB = DataOutB; 
end

endmodule
