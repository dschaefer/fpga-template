#include "blinky.h"

TEST_F(BlinkyTest, Test0) {
    ASSERT_EQ(blinky.led, 0);
    tick();
    ASSERT_EQ(blinky.led, 1);
    tick();
    ASSERT_EQ(blinky.led, 0);
}
