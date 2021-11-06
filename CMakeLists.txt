cmake_minimum_required(VERSION 3.10)

project(dasputer)

set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

include(hdl)

enable_testing()
include(Dart)
include(GoogleTest)
add_subdirectory(googletest)

hdl_bit(blinky
    TOP top
    SOURCES
        top.sv
        ecp5pll.sv
        blinky/blinky.sv
)

hdl_test(blinky
    SOURCES
        blinky/blinky.sv
    TEST_SOURCES
        blinky/test/blinky.cpp
        blinky/test/test.cpp
)
