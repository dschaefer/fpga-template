module top(
    input clk_25mhz,
    input [6:0] btn,
    output [7:0] led
);

    blinky blink(
        .clk(clk_25mhz),
        .nreset(btn[0]),
        .led(led)
    );

endmodule
