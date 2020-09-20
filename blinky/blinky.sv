module blinky(
    input logic clk,
    output logic led
);

    logic [24:0] count = 0;

    assign led = count[24];

    always_ff @(posedge clk) begin
        count <= count + 1;
    end

endmodule
