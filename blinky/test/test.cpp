#include "blinky.h"

TEST_F(BlinkyTest, Test0) {
    ASSERT_EQ(blinky.led, 0);
    int last = 0;
    int cycles = 0;
    blinky.nreset = 1;
    tick();
    for (uint32_t count = 1; count <= 1 << 28; count++) {
        tick();
        if ((count & 0xffffff) == 0) {
            ASSERT_EQ(blinky.led, 0);
        } else {
            ASSERT_EQ(blinky.led, 1 << ((count & (7 << 24)) >> 24));
        }
        if (last != blinky.led) {
            cycles++;
        }
        last = blinky.led;
    }
    ASSERT_EQ(cycles, 32);
}
