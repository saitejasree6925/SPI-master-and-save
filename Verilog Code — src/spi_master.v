module spi_master (
    input        clk,
    input        rst,
    input        start,
    input  [7:0] data_in,
    input        miso,

    output reg   sclk,
    output reg   mosi,
    output reg   cs,
    output reg [7:0] data_out,
    output reg   done
);

    reg [7:0] tx_data;
    reg [7:0] rx_data;
    reg [3:0] bit_count;
    reg       active;

    always @(posedge clk) begin
        if (rst) begin
            sclk     <= 1'b0;
            mosi     <= 1'b0;
            cs       <= 1'b1;
            data_out <= 8'b0;
            done     <= 1'b0;
            tx_data  <= 8'b0;
            rx_data  <= 8'b0;
            bit_count <= 4'd0;
            active   <= 1'b0;
        end
        else begin
            done <= 1'b0;

            if (start && !active) begin
                active    <= 1'b1;
                cs        <= 1'b0;
                tx_data   <= data_in;
                rx_data   <= 8'b0;
                bit_count <= 4'd0;
                mosi      <= data_in[7];
                sclk      <= 1'b0;
            end

            else if (active) begin
                sclk <= ~sclk;

                if (sclk == 1'b0) begin
                    rx_data <= {rx_data[6:0], miso};

                    if (bit_count == 4'd7) begin
                        active   <= 1'b0;
                        cs       <= 1'b1;
                        data_out <= {rx_data[6:0], miso};
                        done     <= 1'b1;
                        mosi     <= 1'b0;
                        sclk     <= 1'b0;
                    end
                    else begin
                        bit_count <= bit_count + 1'b1;
                        mosi <= tx_data[6];
                        tx_data <= {tx_data[6:0], 1'b0};
                    end
                end
            end
        end
    end

endmodule