module blinky(
    input logic clk,
    output logic led
);

    logic led_state = 0;

    assign led = led_state;

    always_ff @(posedge clk) begin
        led_state <= ~led_state;
    end

endmodule
