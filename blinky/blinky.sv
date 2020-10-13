module blinky(
    input clk,
    input nreset,
    output logic [7:0] led
);

    logic [23:0] count = 0;
    logic [2:0] index = 3'b111;

    always_ff @(posedge clk) begin
        if (~nreset) begin
            led[index] <= 0;
            index <= 0;
        end else if (count == 0) begin
            led[index] <= 0;
            index <= index + 1;
        end else begin
            led[index] <= 1;
        end
        count <= count + 1;
    end

endmodule
