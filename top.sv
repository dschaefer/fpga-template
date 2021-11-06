module top(
    input clk_25mhz,
    input [6:0] btn,
    output [7:0] led
);

    wire clk_100mhz;
    wire nreset, locked;

    clocks clocks(
        .clkin(clk_25mhz),
        .clkout0(clk_100mhz),
        .locked(locked)
    );

    assign nreset = btn[0] & locked;

    blinky blink(
        .clk(clk_100mhz),
        .nreset(nreset),
        .led(led)
    );

endmodule
