module top(
    input clk_25mhz,
    output [7:0] led
);

    blinky blink(
        .clk(clk_25mhz),
        .led(o_led)
    );

    logic o_led;

    assign led[0] = o_led;

endmodule
