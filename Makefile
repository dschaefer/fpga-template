VERILATOR_INCS = $(dir $(shell which verilator))/../share/verilator/include

all: ulx3s.bit test

clean:
	rm -fr build ulx3s.bit test

BLINKY_SV = blinky/blinky.sv

BLINKY_TEST_SRCS = blinky/test/blinky.cpp blinky/test/test.cpp

BLINKY_LIB = build/blinky/Vblinky__ALL.a

$(BLINKY_LIB): $(BLINKY_SV)
	@mkdir -p build/blinky
	verilator -cc --Mdir build/blinky $^
	$(MAKE) -C build/blinky -f Vblinky.mk

TEST_LIBS = $(BLINKY_LIB)

TEST_OBJS = $(BLINKY_TEST_SRCS:%.cpp=build/%.o)

GTESTLIB = gtest/lib/libgtest_main.a gtest/lib/libgtest.a

test: $(TEST_OBJS) $(BLINKY_LIB) $(VERILATOR_INCS)/verilated.cpp $(GTESTLIB)
	$(CXX) -std=c++17 -o $@ $^ -lpthread

ulx3s.bit: ulx3s.ys top.sv $(BLINKY_SV)
	@mkdir -p build
	yosys ulx3s.ys > build/yosys.out
	nextpnr-ecp5 --85k --json build/ulx3s.json --package CABGA381 --lpf ulx3s_v20.lpf \
		--textcfg build/ulx3s_out.config 2> build/nextpnr.out
	ecppack build/ulx3s_out.config ulx3s.bit

$(TEST_OBJS): build/%.o:%.cpp $(TEST_LIBS)
	@mkdir -p $(dir $@)
	$(CXX) -c -MMD -std=c++17 -I$(VERILATOR_INCS) -Ibuild/blinky -Igoogletest/googletest/include -o $@ $<

$(GTESTLIB):
	mkdir -p gtest
	cd gtest && cmake ../googletest && make
