find_package(verilator)

function(hdl_bit NAME)
    set(singleValueArgs TOP)
    set(multiValueArgs SOURCES)
    cmake_parse_arguments(HDL "" "${singleValueArgs}" "${multiValueArgs}" ${ARGN})

    list(TRANSFORM HDL_SOURCES PREPEND "${CMAKE_CURRENT_SOURCE_DIR}/")

    add_custom_target(${NAME}_bit ALL
        DEPENDS "${CMAKE_CURRENT_BINARY_DIR}/${NAME}.bit"
    )

    add_custom_command(
        OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/${NAME}.bit"
        COMMAND yosys 
            -p "synth_ecp5 -top ${HDL_TOP} -json ${NAME}.json"
            ${HDL_SOURCES}
            > yosys.out
    	COMMAND nextpnr-ecp5
            --85k --timing-allow-fail
            --json ${NAME}.json
            --lpf ${CMAKE_CURRENT_SOURCE_DIR}/ulx3s_v20.lpf
    		--textcfg ${NAME}.config
            2> nextpnr.out
    	COMMAND ecppack
            --compress
            --freq 62.0
            --input ${NAME}.config
            --bit ${NAME}.bit
        DEPENDS ${HDL_SOURCES}
    )
endfunction(hdl_bit)

function(hdl_test NAME)
    set(multiValueArgs SOURCES TEST_SOURCES)
    cmake_parse_arguments(HDL "" "${singleValueArgs}" "${multiValueArgs}" ${ARGN})

    add_executable(${NAME} ${HDL_TEST_SOURCES})
    target_link_libraries(${NAME} PUBLIC gtest_main)
    verilate(${NAME} SOURCES ${HDL_SOURCES})

    add_test(
        NAME ${NAME}
        COMMAND ${NAME}
    )
endfunction(hdl_test)
