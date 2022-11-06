#include "blinky.h"
#include <verilated_fst_c.h>

TEST_F(BlinkyTest, Test0) {
    VerilatedFstC *trace = new VerilatedFstC;
    blinky.trace(trace, 5);
    trace->open("Test0.fst");
    ASSERT_EQ(blinky.led, 0);
    int last = 0;
    int cycles = 0;
    blinky.nreset = 1;
    tick();
    trace->dump(cycles);
    for (uint32_t count = 1; count <= (1 << 24) * 16; count++) {
        tick();
        if (cycles < 8) {
            trace->dump(cycles);
        }
        if ((count & 0xffffff) == 0) {
            ASSERT_EQ(blinky.led, 0);
        } else {
            ASSERT_EQ(blinky.led, 1 << ((count & (7 << 24)) >> 24));
            if (last != blinky.led) {
                cycles++;
            }
            last = blinky.led;
        }
    }
    ASSERT_EQ(cycles, 16);
    trace->close();
}
