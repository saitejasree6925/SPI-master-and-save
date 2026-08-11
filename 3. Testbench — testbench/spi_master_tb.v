`timescale 1ns/1ps

module spi_master_tb;

    reg clk;
    reg rst;
    reg start;
    reg [7:0] data_in;
    reg miso;

    wire sclk;
    wire mosi;
    wire cs;
    wire [7:0] data_out;
    wire done;

    spi_master uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .data_in(data_in),
        .miso(miso),
        .sclk(sclk),
        .mosi(mosi),
        .cs(cs),
        .data_out(data_out),
        .done(done)
    );

    // Clock generation
    always #5 clk = ~clk;

    // SPI slave model
    reg [7:0] slave_data;
    integer i;

    always @(negedge sclk) begin
        if (!cs) begin
            miso <= slave_data[7];
            slave_data <= {slave_data[6:0], 1'b0};
        end
    end

    initial begin
        clk = 0;
        rst = 1;
        start = 0;
        data_in = 8'b10101010;
        miso = 0;
        slave_data = 8'b11001100;

        #20;
        rst = 0;

        #20;
        start = 1;

        #10;
        start = 0;

        wait(done);

        #20;

        $display("SPI Transfer Complete");
        $display("Transmitted Data = %b", data_in);
        $display("Received Data    = %b", data_out);

        #20;
        $finish;
    end

    initial begin
        $dumpfile("spi_master.vcd");
        $dumpvars(0, spi_master_tb);
    end

endmodule