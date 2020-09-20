#include "blinky.h"

TEST_F(BlinkyTest, Test0) {
    ASSERT_EQ(blinky.led, 0);
    int last = 0;
    int cycles = 0;
    for (uint32_t count = 1; count <= 0x4000000; count++) {
        tick();
        ASSERT_EQ(blinky.led, (count & 0x1000000) >> 24);
        if (last != blinky.led) {
            cycles++;
        }
        last = blinky.led;
    }
    ASSERT_EQ(cycles, 4);
}
