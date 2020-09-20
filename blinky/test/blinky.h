#include <gtest/gtest.h>
#include <blinky/Vblinky.h>

class BlinkyTest: public ::testing::Test {
protected:
    Vblinky blinky;

    BlinkyTest();

    void tick() {
        blinky.clk = 1;
        blinky.eval();
        blinky.clk = 0;
        blinky.eval();
    }
};
