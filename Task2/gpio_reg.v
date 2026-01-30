module GPIO_register (
    input en,
    input clk,
    input wr,
    input [31:0] data_in,
    output reg [31:0] data_out);

reg [31:0] value;

initial
    begin
      $display("Hello, World");
    end


always @ (posedge clk) begin
    if (en && wr) begin
        data_out <= data_in;
    end
end
endmodule

