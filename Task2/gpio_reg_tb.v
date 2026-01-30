`timescale 1ns/1ps

module tb_gpio_reg;
  reg en;
  reg clk;
  reg wr;
  reg [31:0] data_in;
  wire [31:0] data_out;

  GPIO_register dut (
    .en(en),
    .clk(clk),
    .wr(wr),
    .data_in(data_in),
    .data_out(data_out)
  );

  always #5 clk = ~clk;

  initial begin
    $dumpfile("gpio_reg.vcd");
    $dumpvars(0, tb_gpio_reg);

    en = 1;
    clk = 0;
    wr = 0;
    data_in = 32'h0;


    #10;
    wr = 1;
    data_in = 32'hA5A5A5A5;

    #10;
    wr = 0;


    #10;
    wr = 1;
    data_in = 32'h12345678;

    #10;
    en = 0;
    wr = 0;
    data_in = 32'hA5A5A5A6;

    #20;
    $finish;
  end

endmodule