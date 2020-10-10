module top(
    input clk_25mhz,
    output [7:0] led
);

    blinky blink(
        .clk(clk_25mhz),
        .led(led)
    );

endmodule
