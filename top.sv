module top(
    input clk_25mhz,
    input [6:0] btn,
    output [7:0] led
);

    wire [3:0] clocks;
    wire nreset, locked;

    ecp5pll #(
        .in_hz(25_000_000),
        .out0_hz(400_000_000)
    ) ecp5pll_1 (
        .clk_i(clk_25mhz),
        .clk_o(clocks),
        .locked(locked)
    );

    assign nreset = btn[0] & locked;
    assign blink_clock = clocks[0];

    blinky blink(
        .clk(blink_clock),
        .nreset(nreset),
        .led(led)
    );

endmodule
