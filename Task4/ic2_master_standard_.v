module IC2_master_standard (
    input clk,
    input rst_n,
    input wr,
    input [7:0] addr_offset,
    input [31:0] data_in,
    output reg [31:0] data_out,
    output reg scl,
    inout reg sda
);

reg start_enable = 1'b0;
reg [7:0] clk_div = 1'b1; // Clock divider for generating SCL
reg [6:0] slave_addr; // 7-bit I2C slave address
reg [7:0] data_to_send; // Data to be sent to the I2C slave
reg [7:0] data_received; // Data received from the I2C slave
reg [2:0] status; // Status register
reg [7:0] clk_count; // Clock counter for generating SCL
reg [4:0] bit_index = 1'b0; // Bit index for data transmission/reception
reg mode = 1'b0; // Flag to indicate if we are in transmit mode

initial
    begin
      $display("Hello, World");
    //   $monitor("Time=%0t | data_in=%b, data_out=%b, clk=%b, en=%b, wr=%b", $time, data_in, data_out, clk, en, wr);
    end

always @ (posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        scl <= 1'b1;
        sda <= 1'bz; // High impedance for open-drain
        data_out <= 32'bz;
        status <= 3'b0;

    end else begin
        if (wr) begin
            case (addr_offset)
                8'h00: start_enable <= |data_in; 
                8'h04: clk_div <= data_in[7:0];
                8'h08: slave_addr <= data_in[6:0];
                8'h0C: data_to_send <= data_in[7:0]; // Write data to be transmitted
                8'h10: ; 
                8'h14: status <= data_in[2:0]; 
                8'h18: mode <= data_in[0]; // Set mode (0 for transmit, 1 for receive)
                default: ; 
            endcase
        end else begin
            case (addr_offset)
                8'h00: data_out <= start_enable; // Read start enable bit
                8'h04: data_out <= clk_div; // Read clock divider value
                8'h08: data_out <= {25'b0, slave_addr}; // Read slave address
                8'h0C: data_out <= {24'b0, data_to_send}; // Read data to be sent
                8'h10: data_out <= {24'b0, data_received}; // Read received data
                8'h14: data_out <= status;
                8'h18: data_out <= {31'b0, mode}; // Read mode
                default: ; 
            endcase



        if (clk_div == 0 || clk_div == 1) begin
            scl <= clk; // Pass through the input clock if clk_div is 0 or 1
        end

        always @(posedge clk_in or posedge reset) begin
        if (reset) begin
            clk_count <= 8'd0;
            scl <= 1'b1; // Default high
        end else if (clk_count == (clk_div/2) - 1) begin
            clk_count <= 8'd0;
            scl <= ~scl; // Toggle SCL output
        end else begin
            clk_count <= clk_count + 1'b1;
        end
    end
    end
    end
end

always @(posedge scl) begin
    if (start_enable) begin
              // Implement I2C start condition and data transmission logic here
              // This is a placeholder for the actual I2C state machine
              // For example, toggle SCL and SDA according to I2C protocol
         if (bit_index < 7) begin
            sda <= slave_addr[7 - bit_index]; // Send bits MSB first
            bit_index <= bit_index + 1;
         end else if (bit_index == 7) begin
            sda <= mode; // Write bit (0 for write operation)
            bit_index <= bit_index + 1;
         end else if (bit_index == 8) begin
            sda <= 1'bz; // Release SDA for ACK bit
            bit_index <= bit_index + 1;
         end else if (bit_index == 9) begin
            // Here you would check for ACK from the slave and proceed accordingly
            // For simplicity, we will just move to sending data
            if (sda != 1'bz ) begin // ACK received
                 bit_index <= bit_index + 1;
            end else begin
                 // Handle NACK case (not implemented in this example)
            end
        end else if (bit_index < 16 & mode == 1'b0) begin
            sda <= data_to_send[16 - bit_index]; // Send bits MSB first
            bit_index <= bit_index + 1;
        end else if (bit_index <16 & mode == 1'b1) begin
            data_received[16 - bit_index] = sda; // Receive bits MSB first
            bit_index <= bit_index + 1;
        end else begin
            sda <= 1'bz; // Release SDA after sending 8 bits
            bit_index <= 0; // Reset bit index for next transmission    
    end
              
    end
end
endmodule