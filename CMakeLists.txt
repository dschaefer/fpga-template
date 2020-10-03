cmake_minimum_required(VERSION 3.10)

project(dasputer)

enable_testing()
include(GoogleTest)
add_subdirectory(googletest)

find_package(verilator)
add_executable(blinky_test
    blinky/test/blinky.cpp
    blinky/test/test.cpp
)
target_link_libraries(blinky_test PUBLIC gtest gtest_main)
verilate(blinky_test SOURCES
    blinky/blinky.sv
)
