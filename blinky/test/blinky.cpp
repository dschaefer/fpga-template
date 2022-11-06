#include "blinky.h"

BlinkyTest::BlinkyTest() {
    Verilated::traceEverOn(true);
    blinky.clk = 0;
    blinky.eval();
}
