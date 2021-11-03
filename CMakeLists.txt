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
target_link_libraries(blinky_test PUBLIC gtest_main)
verilate(blinky_test SOURCES
    blinky/blinky.sv
)

add_custom_target(bitstream ALL
    DEPENDS "${CMAKE_CURRENT_BINARY_DIR}/blinky.bit"
)

add_custom_command(
    OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/blinky.bit"
    COMMAND yosys 
        -p "synth_ecp5 -top top -json blinky.json"
        ${CMAKE_CURRENT_SOURCE_DIR}/top.sv
        ${CMAKE_CURRENT_SOURCE_DIR}/blinky/blinky.sv
        > yosys.out
	COMMAND nextpnr-ecp5 --85k --json blinky.json --package CABGA381
        --lpf ${CMAKE_CURRENT_SOURCE_DIR}/ulx3s_v20.lpf
		--textcfg blinky.config 2> nextpnr.out
	COMMAND ecppack --compress --freq 62.0
        --input blinky.config
        --bit blinky.bit
    DEPENDS 
        ${CMAKE_CURRENT_SOURCE_DIR}/top.sv
        ${CMAKE_CURRENT_SOURCE_DIR}/blinky/blinky.sv
)
